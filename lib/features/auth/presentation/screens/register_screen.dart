import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_list/core/components/button_component.dart';
import 'package:tasks_list/core/components/text_form_field_component.dart';
import 'package:tasks_list/core/consts/colors.dart';
import 'package:tasks_list/features/auth/domain/bloc/auth_cubit.dart';
import 'package:tasks_list/features/auth/domain/bloc/auth_states.dart';
import 'package:tasks_list/generated/l10n.dart';

import '../../../../core/components/messages.dart';
import '../../../../core/functions/regular_expr_functions.dart';
import '../../../settings/domain/bloc/settings_cubit.dart';
import '../../../settings/presentation/widgets/actionBar.dart';
import '../../../tasks/presentation/screens/show_tasks.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController emailAddressController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordConfirmationController =
      new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is RegisterSuccessState)
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ShowTasksScreen()));
          else if (state is LoginErrorState)
            ShowErrorMessage(msg: state.msg, context: context);
        },
        builder: (BuildContext context, AuthState state) {
          var cubit = AuthCubit.get(context);

          return Stack(
            children: [
              Image.asset(
                width: width,
                height: height,
                'assets/images/notebook.jpg',
                fit: BoxFit.cover,
              ),
              Container(
                width: width,
                height: height,
                color: (SettingsCubit.darkMode)
                    ? Colors.black.withOpacity(0.5)
                    : Colors.white
                        .withOpacity(0.3), // Black color with opacity 0.3
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [ActionBarSettings(context)],
                ),
                body: Container(
                  padding: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Container(
                      height: height,
                      width: width,
                      child: (state is RegisterLoadingState)
                          ? Center(child: CircularProgressIndicator())
                          : Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormFieldComponent(
                                    hintColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    iconColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    fillColor: (SettingsCubit.darkMode)
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.white.withOpacity(0.3),
                                    controller: nameController,
                                    hintText: S.of(context).user_name,
                                    prefixIcon: Icons.person,
                                    validation: (value) {
                                      if (value!.isEmpty) {
                                        return S
                                            .of(context)
                                            .user_name_validation;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height / 20,
                                  ),
                                  TextFormFieldComponent(
                                    hintColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    iconColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    fillColor: (SettingsCubit.darkMode)
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.white.withOpacity(0.3),
                                    controller: emailAddressController,
                                    hintText: S.of(context).email_address,
                                    prefixIcon: Icons.email_outlined,
                                    validation: (value) {
                                      if (value!.isEmpty ||
                                          validateEmail(value)) {
                                        return S
                                            .of(context)
                                            .email_address_validation;
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height / 20,
                                  ),
                                  TextFormFieldComponent(
                                    hintColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    iconColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    fillColor: (SettingsCubit.darkMode)
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.white.withOpacity(0.3),
                                    controller: passwordController,
                                    hintText: S.of(context).password,
                                    prefixIcon: Icons.lock_outline_rounded,
                                    suffixIcon: cubit.hidePassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    onPressedSuffixIcon: () =>
                                        cubit.changePasswordVisibility(),
                                    hideText: cubit.hidePassword,
                                    validation: (value) {
                                      if (value!.isEmpty)
                                        return S
                                            .of(context)
                                            .password_validation;
                                      if (value.length < 8)
                                        return S
                                            .of(context)
                                            .password_must_be_at_least_8_characters;
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height / 20,
                                  ),
                                  TextFormFieldComponent(
                                    hintColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    iconColor: (SettingsCubit.darkMode)
                                        ? darkModeTextColor
                                        : lightModeTextColor,
                                    fillColor: (SettingsCubit.darkMode)
                                        ? Colors.black.withOpacity(0.3)
                                        : Colors.white.withOpacity(0.3),
                                    controller: passwordConfirmationController,
                                    hintText:
                                        S.of(context).password_confirmation,
                                    prefixIcon: Icons.lock_outline_rounded,
                                    suffixIcon: cubit.hideConfirmationPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    onPressedSuffixIcon: () => cubit
                                        .changeConfirmationPasswordVisibility(),
                                    hideText: cubit.hideConfirmationPassword,
                                    validation: (value) {
                                      if (value!.isEmpty)
                                        return S
                                            .of(context)
                                            .password_confirmation_validation;
                                      if (value != passwordController.text)
                                        return S
                                            .of(context)
                                            .password_does_not_match;
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height / 20,
                                  ),
                                  ButtonComponent(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate())
                                          print("correct info");
                                        cubit.register(
                                            emailAddress:
                                                emailAddressController.text,
                                            password: passwordController.text,
                                            name: nameController.text,
                                            passwordConfirmation:
                                                passwordConfirmationController
                                                    .text);
                                      },
                                      text: S.of(context).register_string),
                                  SizedBox(height: height / 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).already_have_an_account,
                                        style: TextStyle(
                                            color: (SettingsCubit.darkMode)
                                                ? darkModeTextColor
                                                : lightModeTextColor,
                                            fontFamily: 'Tajawal'),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LoginScreen())),
                                          child: Text(
                                            S.of(context).login_string,
                                            style: TextStyle(
                                                color: secondaryColor,
                                                fontFamily: 'Tajawal',
                                                fontWeight: FontWeight.bold),
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
