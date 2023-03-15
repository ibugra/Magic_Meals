import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_text.dart';

class LoginInputScreen extends StatefulWidget {
  LoginInputScreen();

  @override
  _LoginInputScreenState createState() => _LoginInputScreenState();
}

class _LoginInputScreenState extends State<LoginInputScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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
              padding: const EdgeInsets.only(bottom: 32),
              child: AppInputText(
                controller: emailController,
                enable: true,
                title: "Email address",
                hint: "test@test.com",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: AppInputText(
                controller: passwordController,
                enable: true,
                title: "Password",
                hint: "*********",
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, "/home_page");
                  },
                  child: const AppText(
                    color: vermilion,
                    size: 17,
                    weight: FontWeight.w600,
                    text: "Forgot passcode?",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            AppButton(
                bgColor: vermilion,
                borderRadius: 30,
                fontSize: 23,
                fontWeight: FontWeight.w600,
                onTap: () {
                  _authService.signIn(emailController.text, passwordController.text).then((value){
                    return Navigator.pushNamed(context, "/home_page");
                  });
                },
                text: "Login",
                textColor: athens_gray)
          ],
        ),
      ),
    );
  }
}