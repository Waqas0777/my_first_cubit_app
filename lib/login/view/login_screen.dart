import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_cubit_app/login/bloc/cubit/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../profile/view/profile_screen.dart';
import '../../signup/view/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SharedPreferences? prefs;

  @override
  void initState() {
    super.initState();
    getPref();
  }

  getPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text("Login"),
        ),
        body: bodyWidget(context),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              authFormWidget(),
              const SizedBox(
                height: 10,
              ),
              signUpRowWidget(context),
              const SizedBox(
                height: 10,
              ),
              loginButtonBlocWidget()
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<LoginCubit, LoginState> loginButtonBlocWidget() {
    return BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
      if (state is LoginFailedState) {
        showInSnackBar("Failed");
      } else if (state is LoginSuccessState) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
      } else {}
    }, builder: (context, state) {
      if (state is LoginInitial) {
        return loginButtonWidget(context);
      } else if (state is LoginLoadingState) {
        return const CircularProgressIndicator();
      } else {
        return loginButtonWidget(context);
      }
    });
  }

  Widget signUpRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text(
          "Don't have an account ?  ",
          style: TextStyle(fontSize: 16),
        ),
        InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 16, color: Colors.blue),
            )),
      ],
    );
  }

  Widget authFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Valid email';
              } else if (!EmailValidator.validate(value)) {
                return "Please Enter valid email";
              } else {
                return null;
              }
            },
            onChanged: (val) {},
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Enter Your Email",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Valid password';
              }
              return null;
            },
            controller: passwordController,
            onChanged: (val) {},
            decoration: InputDecoration(
              labelText: "Enter Your Password",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(),
              ),
            ),
            keyboardType: TextInputType.text,
            style: const TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ],
      ),
    );
  }

  Widget loginButtonWidget(BuildContext context) {
    return CupertinoButton(
        color: Colors.blue,
        child: const Text("Login"),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<LoginCubit>(context).submittedData(
                context, emailController.text, passwordController.text);
          }
        });
  }

  void showInSnackBar(String value) {
    var snackBar = SnackBar(content: Text(value), backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
