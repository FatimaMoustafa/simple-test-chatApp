import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({this.hintText, this.onChanged, this.obsecureText = false});

   Function(String)? onChanged;
  String? hintText;
  bool? obsecureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText!,
      obscuringCharacter: '*',
      validator: (data){
        if(data!.isEmpty){
          return "Field is required";
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffC7EDE6),
          )
        )
      ),
    );
  }
}
