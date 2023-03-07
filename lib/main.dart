import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:my_first_cubit_app/model/sharedPreferencesModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/view/login_screen.dart';

void main() async {
  runApp(const MyApp());
  await initDependencyInjection();
}

Future<void> initDependencyInjection() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferencesModel>(
      SharedPreferencesModel(sharedPreferences));
}

final getIt = GetIt.instance;

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
