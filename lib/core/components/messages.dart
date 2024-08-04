import 'package:flutter/material.dart';
import 'package:tasks_list/core/consts/colors.dart';

 ShowErrorMessage({required String msg,required context}){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: secondaryColor,
    content: Text(msg,style: TextStyle(
      color:Colors.white,
      fontFamily: 'Tajawal'
    ),),
  ));
}