import 'package:flutter/material.dart';
import 'package:myFinances/src/utils/values/colors.dart';

class FormFieldMain extends StatelessWidget {

  final Key key;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final TextInputType textInputType;
  final String hintText;
  final bool obscured;
  final void Function(void) onChanged;

  const FormFieldMain({
    this.key,
    @required this.marginLeft,
    @required this.marginRight,
    @required this.marginTop,
    @required this.textInputType,
    @required this.hintText,
    @required this.obscured,
    @required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft, right: marginRight, top: marginTop),
      child: TextField(
        key: key,
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: obscured,
        decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0XCC000000),
            ),
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          fillColor: Colors.white,
          hintText: hintText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstant.colorMainPurple,
            )
          ),
        ),
      ),
    );
  }
}