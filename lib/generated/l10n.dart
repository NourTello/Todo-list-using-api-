// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login_string {
    return Intl.message(
      'Login',
      name: 'login_string',
      desc: '',
      args: [],
    );
  }

  /// `Create new account`
  String get register_string {
    return Intl.message(
      'Create new account',
      name: 'register_string',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account ?`
  String get do_not_have_account {
    return Intl.message(
      'Don\'t have an account ?',
      name: 'do_not_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get already_have_an_account {
    return Intl.message(
      'Already have an account? ',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `User name `
  String get user_name {
    return Intl.message(
      'User name ',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get password_validation {
    return Intl.message(
      'Enter password',
      name: 'password_validation',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email address`
  String get email_address_validation {
    return Intl.message(
      'Enter your email address',
      name: 'email_address_validation',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get password_does_not_match {
    return Intl.message(
      'Password does not match',
      name: 'password_does_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get password_confirmation {
    return Intl.message(
      'Confirm password',
      name: 'password_confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Enter user name`
  String get user_name_validation {
    return Intl.message(
      'Enter user name',
      name: 'user_name_validation',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get password_confirmation_validation {
    return Intl.message(
      'Confirm your password',
      name: 'password_confirmation_validation',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters`
  String get password_must_be_at_least_8_characters {
    return Intl.message(
      'Password must be at least 8 characters',
      name: 'password_must_be_at_least_8_characters',
      desc: '',
      args: [],
    );
  }

  /// `Enter task title`
  String get title_validation {
    return Intl.message(
      'Enter task title',
      name: 'title_validation',
      desc: '',
      args: [],
    );
  }

  /// `Enter task description`
  String get description_validation {
    return Intl.message(
      'Enter task description',
      name: 'description_validation',
      desc: '',
      args: [],
    );
  }

  /// `Title `
  String get title {
    return Intl.message(
      'Title ',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Long description`
  String get long_description {
    return Intl.message(
      'Long description',
      name: 'long_description',
      desc: '',
      args: [],
    );
  }

  /// `New Task`
  String get new_task {
    return Intl.message(
      'New Task',
      name: 'new_task',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `My tasks`
  String get my_tasks {
    return Intl.message(
      'My tasks',
      name: 'my_tasks',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Mode`
  String get mode {
    return Intl.message(
      'Mode',
      name: 'mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Light mode`
  String get light_mode {
    return Intl.message(
      'Light mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Completed date`
  String get completed_date {
    return Intl.message(
      'Completed date',
      name: 'completed_date',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get day {
    return Intl.message(
      'Day',
      name: 'day',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
