import 'package:app_chat/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackerBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: PrimaryColor, fontSize: 18),),
        backgroundColor: Color(0xffC7EDE6),
      )
  );
}