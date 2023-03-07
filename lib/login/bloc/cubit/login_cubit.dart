import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_first_cubit_app/main.dart';
import 'package:my_first_cubit_app/model/sharedPreferencesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
part '../states/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());



  void submittedData(context, String email, String pass,) {
    emit(LoginLoadingState());
    validateUser(context, email, pass).then((value) async {
      if (value) {
        Future.delayed(const Duration(seconds: 2), () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("status", true);
          emit(LoginSuccessState());

        });
      } else   {

        Future.delayed(const Duration(seconds: 2), () {
          emit(LoginFailedState());
        });
      }

    }).onError((error, stackTrace) {
      emit(LoginFailedState());
    });
  }

  Future<bool> validateUser(
    context,
    String email,
    String pass,
  ) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();

    String userEmail = getIt<SharedPreferencesModel>().getUserEmail();
    String userPassword = getIt<SharedPreferencesModel>().getUserPassword();
    if (email.isEmpty || pass.isEmpty) {
      return Future.value(false);
    } else if (email != userEmail || pass != userPassword) {
      return Future.value(false);
    } else if (email == userEmail || pass == userPassword) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
