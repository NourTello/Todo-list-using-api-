import 'package:flutter/material.dart';
import 'package:tasks_list/core/consts/colors.dart';

import '../../../settings/domain/bloc/settings_cubit.dart';

Widget TaskCard(
    {required String title,
    required String description,
    required double height,
    required BuildContext context,
     bool? isCompleted,
    required Function(bool?) checkBoxFunction,
    }) {
  return Container(
    padding: EdgeInsets.all(16),
    color:  (SettingsCubit.darkMode)?darkModeItemColor:lightModeItemColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Checkbox(value: isCompleted, onChanged:checkBoxFunction,)
          ],
        ),
        SizedBox(
          height: height / 100,
        ),
        Text(description,style:  Theme.of(context).textTheme.labelLarge,),

      ],
    ),
  );
}
