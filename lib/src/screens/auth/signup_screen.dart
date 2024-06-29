import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../controllers/auth_controller.dart';
import '../../routing/router.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {

  static const String route = '/signup';
  static const String name = "Sign Up Screen";

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  late TextEditingController email, password, confirmPassword;
  late bool isClicked = false;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
     return CupertinoPageScaffold(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80,),
            GestureDetector(
              onTap: () => GlobalRouter.I.router.go(LoginScreen.route),
              child: const Row(
                children: [
                  SizedBox(width: 25,),
                  Icon(Icons.arrow_back_ios),
                ],
              )
            ),
            const SizedBox(height: 70,),
            const Text("Create your Account"),
            const SizedBox(height: 30,),
            SizedBox(
              width: MediaQuery.of(context).size.width * .80,
              height: 50,
              child: CupertinoTextField(
                controller: email,
                placeholder: "Enter email",
                placeholderStyle: const TextStyle(color: CupertinoColors.inactiveGray),
                decoration: BoxDecoration(
                  color: CupertinoColors.white, 
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: CupertinoColors.inactiveGray, 
                    width: 1.0, 
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * .80,
              height: 50,
              child: CupertinoTextField(
                controller: password,
                placeholder: "Enter password",
                placeholderStyle: const TextStyle(color: CupertinoColors.inactiveGray),
                decoration: BoxDecoration(
                  color: CupertinoColors.white, 
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: CupertinoColors.inactiveGray, 
                    width: 1.0, 
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                obscureText: isClicked ? false : true,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      isClicked = !isClicked;
                    });
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        Icon(isClicked ? Icons.visibility : Icons.visibility_off),
                        const SizedBox(width: 10,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            SizedBox(
              width: MediaQuery.of(context).size.width * .80,
              height: 50,
              child: CupertinoTextField(
                controller: confirmPassword,
                placeholder: "Confirm password",
                placeholderStyle: const TextStyle(color: CupertinoColors.inactiveGray),
                decoration: BoxDecoration(
                  color: CupertinoColors.white, 
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: CupertinoColors.inactiveGray, 
                    width: 1.0, 
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                obscureText: isClicked ? false : true,
                suffix: GestureDetector(
                  onTap: () {
                    setState(() {
                      isClicked = !isClicked;
                    });
                  },
                  child: SizedBox(
                    child: Row(
                      children: [
                        Icon(isClicked ? Icons.visibility : Icons.visibility_off),
                        const SizedBox(width: 10,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .80,
                child: CupertinoButton.filled(
                  onPressed: () async {
                    if(noEmptyInputs(email.text, password.text, confirmPassword.text)){
                      if(validateInputs(email.text, password.text, confirmPassword.text)){
                          try{
                            showCupertinoDialog(
                              context: context, 
                              builder: (context) {
                                return const Center(child: CupertinoActivityIndicator());
                              }
                            );
                            await AuthController.I.register(email.text.trim(), password.text.trim());
                          } on FirebaseAuthException catch (e){
                            Navigator.pop(context);
                            showErrorMessage(e.message!);
                          }
                        }
                    }
                  },
                  child: const Text("Sign up"),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            const Text("Or sign up with:"),
            const SizedBox(height: 30,),
            Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () async { 
                      },
                      child: Container(
                        width: 100,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 1, color: Colors.black)
                        ),
                        child: SvgPicture.asset('lib/src/assets/logos/google_logo.svg', fit: BoxFit.scaleDown,),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.black)
                      ),
                      child: SvgPicture.asset('lib/src/assets/logos/facebook_logo.svg', fit: BoxFit.scaleDown,),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      width: 100,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(width: 1, color: Colors.black)
                      ),
                      child: SvgPicture.asset('lib/src/assets/logos/twitter_logo.svg', fit: BoxFit.scaleDown,),
                    ),
                    const Spacer(),
                  ],
                ),
        ],
      ),)
    );
  }

  showErrorMessage(String error){
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text('Sign up Failed'),
          content: Text(error),
          actions: <Widget>[
           CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool noEmptyInputs(String email, String password, String confirmPassword){
    if(email.isEmpty && (password.isNotEmpty && confirmPassword.isNotEmpty)){
      showErrorMessage("Please input an email.");
      return false;
    }else if(password.isEmpty && (email.isNotEmpty && confirmPassword.isNotEmpty)){
      showErrorMessage("Please input a password.");
      return false;
    }else if(confirmPassword.isEmpty && (email.isNotEmpty && password.isNotEmpty)){
      showErrorMessage("Please input confirm password.");
      return false;
    }else if(email.isEmpty && password.isEmpty && confirmPassword.isEmpty){
      showErrorMessage("Please input all fields.");
      return false;
    }
    return true;
  }

  bool validateInputs(String email, String password, String confirmPassword) {
    final bool emailValid = 
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    if(!emailValid){
        showErrorMessage("Please input a valid email.");
        return false;
      }else{
        if(password != confirmPassword){
          showErrorMessage("Password do not match!");
          return false;
        }
    }
    return true;
  }
}