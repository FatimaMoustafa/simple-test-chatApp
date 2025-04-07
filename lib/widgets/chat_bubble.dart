import 'package:app_chat/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
class ChatBubble extends StatelessWidget {
  ChatBubble({
    super.key,
    required this.message
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: PrimaryColor,
        ),
        child: Text(
          message.message,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  ChatBubbleForFriend({
    super.key,
    required this.message
  });

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          message.message,
          style: TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}