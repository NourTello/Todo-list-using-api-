import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_list/chash_helper.dart';
import 'package:tasks_list/core/components/button_component.dart';
import 'package:tasks_list/core/consts/colors.dart';
import 'package:tasks_list/features/auth/presentation/screens/login_screen.dart';
import 'package:tasks_list/features/settings/domain/bloc/settings_cubit.dart';
import 'package:tasks_list/features/settings/domain/bloc/settings_state.dart';
import '../../../../generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    var cubit = SettingsCubit.get(context);
    return BlocBuilder<SettingsCubit,SettingsState>(
      builder: (BuildContext context, state) {  return  Scaffold(
        appBar: AppBar(
            title: Row(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.settings),
                SizedBox(
                  width: 10,
                ),
                Text(S.of(context).settings,style: Theme.of(context).textTheme.titleLarge,)
              ],
            )),
        body:(state is LogoutLoadingState)?Center(child: CircularProgressIndicator()): Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          S.of(context).language + ' : ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        // SizedBox(
                        //     width: width /5), // Add some spacing between buttons
                        Expanded(child:Container()),
                        RadioMenuButton(
                          value: 1,
                          groupValue: SettingsCubit.english ? 1 : 2,
                          onChanged: (newValue) => cubit.switchLanguage(),
                          child: Text(
                            'English',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Spacer(),
                        RadioMenuButton<int>(
                          value: 2,
                          groupValue: SettingsCubit.english ? 1 : 2,
                          onChanged: (newValue) => cubit.switchLanguage(),
                          child: Text(
                            'العربية',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 20,
                    ),
                    SizedBox(
                      height: height/10,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              S.of(context).mode + ' : ',
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          RadioMenuButton(
                            value: 1,
                            groupValue: SettingsCubit.darkMode ? 1 : 2,
                            onChanged: (newValue) => cubit.switchMode(),
                            child: Text(
                              S.of(context).dark_mode,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),

                          RadioMenuButton<int>(
                            value: 2,
                            groupValue: SettingsCubit.darkMode ? 1 : 2,
                            onChanged: (newValue) => cubit.switchMode(),
                            child: Text(
                              S.of(context).light_mode,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              CashHelper.checkExistence(key: 'token')?ButtonComponent(
                  onPressed: () => cubit.logout().then((value) =>
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))),
                  text: S.of(context).logout,
                  color: darkModeItemColor):Container()

            ],
          ),
        ),
      );},
    );
  }
}
