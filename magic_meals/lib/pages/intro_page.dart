import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';

class IntroScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 138, 120, 1),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Image.asset("assets/magic_meals_logo.png"),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: AppText(
                  size: 50,
                  color: Colors.white,
                  text: "Food for Everyone",
                  weight: FontWeight.w800,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          /*Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              "assets/images/toyface_right.png",
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              "assets/images/toyface_left.png",
              height: MediaQuery.of(context).size.height * 0.55,
            ),
          ),*/
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color.fromRGBO(255, 138, 120, 1), Color.fromRGBO(255, 138, 120, 1)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: AppButton(
              text: "Get Started",
              bgColor: Colors.white,
              textColor: vermilion,
              borderRadius: 30,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              onTap: () {
                Navigator.pushNamed(context, "/login_page");
              },
            ),
          )
        ],
      ),
    );
  }
}