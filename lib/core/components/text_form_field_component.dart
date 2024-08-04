import 'package:flutter/material.dart';

import '../../features/settings/domain/bloc/settings_cubit.dart';
import '../consts/colors.dart';

Widget TextFormFieldComponent({
  required TextEditingController controller,
  String? Function(String?)? validation,
  String? hintText,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Color? hintColor,
  Color? iconColor,
  bool? filled,
  Function()? onPressedSuffixIcon,
  bool hideText = false,
  Color? fillColor,
  Function()? onTap,
  bool readOnly = false,
}) =>
    TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      textInputAction: TextInputAction.next,
      controller: controller,
      validator: validation,
      obscureText: hideText,
      style: TextStyle(
          color:
              (SettingsCubit.darkMode) ? darkModeTextColor : lightModeTextColor,
          fontFamily: 'Tajawal'),
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        prefixIconColor: (iconColor != null)
            ? iconColor
            : (SettingsCubit.darkMode)
                ? darkModeTextColor
                : lightModeHintColor,
        suffixIcon: (suffixIcon != null)
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: onPressedSuffixIcon,
              )
            : null,
        hintText: hintText,
        filled: (filled != null) ? filled : true,
        fillColor: (fillColor != null)
            ? fillColor
            : (SettingsCubit.darkMode)
                ? darkModeTextFieldColor
                : lightModeTextFieldColor,
        // border: BorderRadius,
        suffixIconColor: (iconColor != null)
            ? iconColor
            : (SettingsCubit.darkMode)
                ? darkModeTextColor
                : lightModeHintColor,
        hintStyle: TextStyle(
            color: (hintColor != null)
                ? hintColor
                : (SettingsCubit.darkMode)
                    ? darkModeTextColor
                    : lightModeHintColor,
            fontFamily: 'Tajawal'),
      ),
    );
