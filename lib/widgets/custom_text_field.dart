import 'package:flutter/material.dart';
import 'package:scholar_chat_app/constants.dart';

class CustomTextField extends StatelessWidget {
 const CustomTextField({super.key, required this.hintTxt, required this.onChanged, this.showTxt = false});
  final String hintTxt;
  final Function(String) onChanged;
  final bool showTxt;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'field is required';
        }
        else{
          return null;
        }
      },
      obscureText: showTxt,
      onChanged: onChanged,
      style: TextStyle(color: vPrimaryColor),
      decoration: InputDecoration(
        hintText: hintTxt,
        hintStyle: TextStyle(color: vPrimaryColor , fontSize: 18, fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: vPrimaryColor,
            width: 5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: vPrimaryColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: EdgeInsets.all(20),
      ),
    );
  }
}
