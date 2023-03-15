import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'custom_text.dart';

class AppInputText extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final bool enable;
  const AppInputText({required this.title, required this.controller, required this.hint, required this.enable});

  @override
  _AppInputTextState createState() => _AppInputTextState();
}

class _AppInputTextState extends State<AppInputText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: widget.title,
          color: black_90,
          size: 15,
          weight: FontWeight.w600,
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          enabled: widget.enable,
          controller: widget.controller,
          decoration: InputDecoration(hintText: widget.hint),
        ),
      ],
    );
  }
}