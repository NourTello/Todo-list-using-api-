import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasks_list/chash_helper.dart';
import 'package:tasks_list/features/settings/data/settings_repo.dart';
import 'package:tasks_list/features/settings/domain/bloc/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingInitialState());
  SettingsRepo settingsRepo=SettingsRepo();

  static SettingsCubit get(context) => BlocProvider.of(context);

  static  bool darkMode = true;
  static bool english = true;

  void switchLanguage() {
    english = !english;
    CashHelper.putBooleanData(key: 'english', value: english);
    emit(ChangeLanguageState());
  }

  void switchMode() {
    darkMode = !darkMode;
    CashHelper.putBooleanData(key: 'dark_mode', value: darkMode);
    emit(ChangeModeState());
  }

  Future<void> logout()async{
    emit(LogoutLoadingState());
    bool response =await settingsRepo.logout();
    if (response)
      {
        emit(LogoutSuccessState());
        CashHelper.removeData( key:'token');
      }
    else emit(LogoutErrorState());
  }
}
