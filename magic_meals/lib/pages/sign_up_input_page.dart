import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';


class SignUpInputScreen extends StatefulWidget {
  SignUpInputScreen();

  @override
  _SignUpInputScreenState createState() => _SignUpInputScreenState();
}

class _SignUpInputScreenState extends State<SignUpInputScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthService _authService = AuthService();

  final RoundedLoadingButtonController _btnController1 =
  RoundedLoadingButtonController();

  void _doSomething(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 1), () {
      controller.success();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AppInputText(
                controller: nameController,
                enable: true,
                hint: "Please write your name",
                title: "Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: AppInputText(
                controller: emailController,
                enable: true,
                hint: "Please write your e-mail address",
                title: "Email address",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: AppInputText(
                controller: passwordController,
                enable: true,
                hint: "*********",
                title: "Password ",
              ),
            ),
            RoundedLoadingButton(
              color: vermilion,
              borderRadius: 30,
              successIcon: Icons.check,
              successColor: vermilion,
              failedIcon: Icons.cottage,
              child: const Text('Sign-up', style: TextStyle(color: Colors.white, fontSize: 23,)),
              controller: _btnController1,
              onPressed: () {
                  _authService.createPerson(nameController.text, emailController.text, passwordController.text).then((value){
                    return Navigator.pushNamed(context, "/login_page");
                  });
                _doSomething(_btnController1);
              },
            ),
            /*AppButton(
                bgColor: vermilion,
                borderRadius: 30,
                fontSize: 23,
                fontWeight: FontWeight.w600,
                onTap: () {
                  _authService.createPerson(nameController.text, emailController.text, passwordController.text).then((value){
                    return Navigator.pushNamed(context, "/login_page");
                  });
                },
                text: "Sign-up",
                textColor: athens_gray)*/
          ],
        ),
      ),
    );
  }
}