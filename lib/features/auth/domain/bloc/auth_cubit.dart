import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_list/chash_helper.dart';
import 'package:tasks_list/core/consts/app_const.dart';
import 'package:tasks_list/features/auth/data/auth_repo.dart';
import 'package:tasks_list/features/auth/domain/bloc/auth_states.dart';
import 'package:tasks_list/features/auth/domain/models/login_model.dart';
import 'package:tasks_list/features/auth/domain/models/register_model.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  AuthRepo authRepo = new AuthRepo();

  static AuthCubit get(context) => BlocProvider.of(context);

  bool hidePassword = true;
  bool hideConfirmationPassword = true;

  void changeConfirmationPasswordVisibility() {
    hideConfirmationPassword = !hideConfirmationPassword;
    if (hidePassword)
      emit(hidePasswordState());
    else
      emit(showPasswordState());
  }

  void changePasswordVisibility() {
    hidePassword = !hidePassword;
    if (hidePassword)
      emit(hidePasswordState());
    else
      emit(showPasswordState());
  }

  void login({required String emailAddress, required String password}) async {
    emit(LoginLoadingState());
    LoginModel response =
        await authRepo.login(email: emailAddress, password: password);

    if (response.success!) {
      await CashHelper.putStringData(
          key: 'token', value: response.data!.token!);
      AppConst.token = CashHelper.getStringData(key: 'token');
      emit(LoginSuccessState());
    } else
      emit(LoginErrorState(response.message!));
  }

  void register(
      {required String emailAddress,
      required String password,
      required String name,
      required String passwordConfirmation}) async {
    emit(RegisterLoadingState());
    RegisterModel response = await authRepo.register(
        emailAddress: emailAddress,
        password: password,
        name: name,
        passwordConfirmation: passwordConfirmation);
    if (response.success!) {
      await CashHelper.putStringData(
          key: 'token', value: response.data!.token!);
      AppConst.token = CashHelper.getStringData(key: 'token');
      emit(RegisterSuccessState());
    } else
      emit(RegisterErrorState(response.message!));
  }
}
