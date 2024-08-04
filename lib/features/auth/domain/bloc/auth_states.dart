import 'package:tasks_list/features/tasks/domain/bloc/tasks_cubit.dart';
import 'package:tasks_list/features/tasks/domain/bloc/tasks_states.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginErrorState extends AuthState {
  String msg;
  LoginErrorState(this.msg);
}

class RegisterLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class RegisterErrorState extends AuthState {
  String msg;
  RegisterErrorState(this.msg);
}

class showPasswordState extends AuthState {}

class hidePasswordState extends AuthState {}
