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
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailAddressController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (BuildContext context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is LoginSuccessState)
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
              Container(
                padding: EdgeInsets.all(16),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [ActionBarSettings(context)],
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      height: height,
                      width: width,
                      child: (state is LoginLoadingState)
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
                                    controller: emailAddressController,
                                    hintText: S.of(context).email_address,

                                    prefixIcon: Icons.email_outlined,
                                    // filled: true,

                                    validation: (value) {
                                      if (value!.isEmpty ||
                                          !(validateEmail(
                                              emailAddressController.text))) {
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
                                    //  filled: true,
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
                                      if (value!.isEmpty) {
                                        return S
                                            .of(context)
                                            .password_validation;
                                      } else if (value.length < 8)
                                        return S
                                            .of(context)
                                            .password_must_be_at_least_8_characters;
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: height / 10,
                                  ),
                                  ButtonComponent(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          print("correct info");
                                          cubit.login(
                                              emailAddress:
                                                  emailAddressController.text,
                                              password:
                                                  passwordController.text);
                                        }
                                      },
                                      text: S.of(context).login_string),
                                  SizedBox(height: height / 20),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        S.of(context).do_not_have_account,
                                        style: TextStyle(
                                          fontFamily: 'Tajawal',
                                          color: (SettingsCubit.darkMode)
                                              ? darkModeTextColor
                                              : lightModeTextColor,
                                        ),
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
                                                          RegisterScreen())),
                                          child: Text(
                                            S.of(context).register_string,
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
