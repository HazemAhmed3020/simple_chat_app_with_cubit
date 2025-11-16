import 'package:flutter/material.dart';
import 'package:scholar_chat_app/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.txt});
 final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 10),
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Container(
          padding: EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Text(txt,
          // textAlign: TextAlign.center,
          style: TextStyle(
            color: vPrimaryColor,
          ),
          ),
        ),
      ),
    );
  }
}
class ChatBubbleForAnotherUser extends StatelessWidget {
  const ChatBubbleForAnotherUser({super.key, required this.txt});
 final String txt;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0 , vertical: 10),
      child: Align(
        alignment: AlignmentGeometry.centerRight,
        child: Container(
          padding: EdgeInsets.only(
            top: 30,
            bottom: 30,
            left: 10,
            right: 10,
          ),
          decoration: BoxDecoration(
            color: cPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(35),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Text(txt,
          // textAlign: TextAlign.center,
          style: TextStyle(
            color: vPrimaryColor,
          ),
          ),
        ),
      ),
    );
  }
}
