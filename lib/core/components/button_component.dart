import 'package:flutter/material.dart';
import 'package:tasks_list/core/consts/colors.dart';

Widget ButtonComponent(
        {required Function()? onPressed,
        Color color = primaryColor,
        required String text,
        double width = double.infinity,
        double height = 40,
        Color textColor = Colors.white}) =>
    MaterialButton(
      minWidth: width,
      onPressed: onPressed,
      height: height,
      color: color,
      child: Text(
        text,
        style: TextStyle(
            color: textColor,
            fontFamily: 'Tajawal',
            fontWeight: FontWeight.bold,
            fontSize: 15),
      ),
    );
