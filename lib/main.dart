import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:tasks_list/bloc_observer.dart';
import 'package:tasks_list/chash_helper.dart';
import 'package:tasks_list/core/consts/colors.dart';
import 'package:tasks_list/features/settings/domain/bloc/settings_cubit.dart';
import 'dart:ui';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/settings/domain/bloc/settings_state.dart';
import 'features/tasks/presentation/screens/show_tasks.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CashHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // EasyLoading.instance..displayDuration = const Duration(milliseconds: 2000);

    return BlocProvider(
      create: (BuildContext context)=>SettingsCubit(),
      child:BlocConsumer<SettingsCubit,SettingsState>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {

          var cubit=SettingsCubit.get(context);
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tasks list',
              locale: SettingsCubit.english?Locale('en'):Locale('ar'),
              localizationsDelegates: [
                S.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: [
                Locale('en', 'US'), // English
                Locale('ar', ''), // Arabic
              ],
              theme:ThemeData(
                  iconTheme: IconThemeData(color:lightModeTextColor),

                  textTheme: TextTheme(
                      titleLarge: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Tajawal'
                      ),
                      labelLarge: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey.shade600,
                          fontFamily: 'Tajawal'
                      ),
                      bodyLarge : TextStyle(
                        overflow: TextOverflow.ellipsis,
                          fontFamily: 'Tajawal',
                      )

                  ),
                  appBarTheme: AppBarTheme(
                    iconTheme: IconThemeData(color: lightModeTextColor),
                    actionsIconTheme: IconThemeData(color: lightModeTextColor),
                    centerTitle: true,
                    backgroundColor: lightModeBackgroundColor,
                  ),
                  scaffoldBackgroundColor: lightModeBackgroundColor,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: secondaryColor,
                  ),
                  primaryColor: primaryColor,
                  primarySwatch: MaterialColor(
                    0xFF27AE60,
                    {
                      50: Color(0xFF27AE60),
                      100: Color(0xFF27AE60),
                      200: Color(0xFF27AE60),
                      300: Color(0xFF27AE60),
                      400: Color(0xFF27AE60),
                      500: Color(0xFF27AE60),
                      600: Color(0xFF27AE60),
                      700: Color(0xFF27AE60),
                      800: Color(0xFF27AE60),
                      900: Color(0xFF27AE60),
                    },
                  ),
                  progressIndicatorTheme: ProgressIndicatorThemeData(
                    color: secondaryColor,
                  )),

              themeMode:SettingsCubit.darkMode? ThemeMode.dark:ThemeMode.light,
              builder: EasyLoading.init(),

              darkTheme: ThemeData(
                iconTheme: IconThemeData(color:darkModeTextColor),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: darkModeBackgroundColor
                ),
                  textTheme: TextTheme(
                    titleLarge: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: darkModeTextColor,
                        fontFamily: 'Tajawal'
                    ),
                      labelLarge: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey.shade600,
                          fontFamily: 'Tajawal'
                      ),
                    bodyLarge : TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: darkModeTextColor,
                      fontFamily: 'Tajawal',
                    )

                  ),
                  appBarTheme: AppBarTheme(
                    centerTitle: true,
                    backgroundColor: darkModeBackgroundColor,
                  ),
                  scaffoldBackgroundColor: darkModeBackgroundColor,
                  floatingActionButtonTheme: FloatingActionButtonThemeData(
                    backgroundColor: secondaryColor,
                  ),
                  primaryColor: primaryColor,

                  primarySwatch: MaterialColor(
                    0xFF27AE60,
                    {
                      50: Color(0xFF27AE60),
                      100: Color(0xFF27AE60),
                      200: Color(0xFF27AE60),
                      300: Color(0xFF27AE60),
                      400: Color(0xFF27AE60),
                      500: Color(0xFF27AE60),
                      600: Color(0xFF27AE60),
                      700: Color(0xFF27AE60),
                      800: Color(0xFF27AE60),
                      900: Color(0xFF27AE60),
                    },
                  ),
                  progressIndicatorTheme: ProgressIndicatorThemeData(
                    color: secondaryColor,
                  )),
              home: CashHelper.checkExistence(key: 'token')
                  ? ShowTasksScreen()
                  : LoginScreen()
            //ShowTasksScreen()
          );
        },)
    );
  }
}
