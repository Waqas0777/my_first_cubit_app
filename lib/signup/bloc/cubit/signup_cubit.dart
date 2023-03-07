import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:my_first_cubit_app/main.dart';
import 'package:my_first_cubit_app/model/sharedPreferencesModel.dart';

part '../states/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());

  void submittedData(context, String name, String email, String pass) {
    validateUser(context, name, email, pass).then((value) async {
      if (value) {
         emit(SignupLoadingState());
        Future.delayed(const Duration(seconds: 2), () {
          emit(SignupSuccessState());
        });
      } else {

        Future.delayed(const Duration(seconds: 1), () {
          emit(SignupFailedState());
        });
      }
    }).onError((error, stackTrace) {
      emit(SignupFailedState());

    });
  }

  void storeInSharedPreference(
      context, String name, String email, String pass) {
    validateUser(context, name, email, pass).then((value) {
      if (value) {
        emit(SignupSuccessState());
      } else {
        emit(SignupFailedState());
      }
    }).onError((error, stackTrace) {
      emit(SignupFailedState());
    });
  }

  Future<bool> validateUser(
      context, String name, String email, String pass) async {
    if (name.isEmpty || email.isEmpty || pass.isEmpty) {
      return Future.value(false);
    } else {
      savedUserInfo(context, name, email, pass);

      return Future.value(true);
    }
  }

  void savedUserInfo(context, String name, String email, String pass) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    getIt<SharedPreferencesModel>().setUserName(name);
    getIt<SharedPreferencesModel>().setUserEmail(email);
    getIt<SharedPreferencesModel>().setUserPassword(pass);



    // prefs.setString("name", name);
    // prefs.setString("email", email);
    // prefs.setString("password", pass);
  }
}
