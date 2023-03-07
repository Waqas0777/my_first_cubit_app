import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_cubit_app/signup/bloc/cubit/signup_cubit.dart';
import '../../login/view/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Signup"),
          centerTitle: true,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              authFormWidget(),
              const SizedBox(
                height: 10,
              ),
              loginRowWidget(context),
              const SizedBox(
                height: 10,
              ),
              signUpButtonBlocWidget(context),
            ],
          ),
        ),
      )),
    );
  }

  BlocConsumer<SignupCubit, SignupState> signUpButtonBlocWidget(context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupFailedState) {
          showInSnackBar(context, "Failed");
        } else if (state is SignupSuccessState) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        } else {}
      },
      builder: (context, state) {
        if (state is SignupInitial) {
          return signUpButtonWidget(context);
        } else if (state is SignupLoadingState) {
          return const CircularProgressIndicator();
        } else {
          return signUpButtonWidget(context);
        }
        // return CupertinoButton(
        //     color: Colors.blue,
        //     child: const Text("Signup"),
        //     onPressed: () {
        //       if (_formKey.currentState!.validate()) {
        //         BlocProvider.of<SignupCubit>(context).submittedData(
        //             context,
        //             usernameController.text,
        //             emailController.text,
        //             passwordController.text);
        //       }
        //     });
      },
    );
  }

  Widget signUpButtonWidget(BuildContext context) {
    return CupertinoButton(
        color: Colors.blue,
        child: const Text("Login"),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<SignupCubit>(context).submittedData(
                context,usernameController.text, emailController.text, passwordController.text);
          }
        });
  }

  Widget loginRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text("Already have an account ?  ",
            style: TextStyle(
              fontSize: 16,
            )),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  const LoginScreen()),
            );
          },
          child: const Text(
            "Login.",
            style: TextStyle(fontSize: 16, color: Colors.blue),
          ),
        )
      ],
    );
  }

  Widget authFormWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: usernameController,
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Please enter your name'
                  : null;
            },
            decoration: InputDecoration(
              labelText: "Enter Username",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            keyboardType: TextInputType.text,
            style: const TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (val) {},
            validator: (value) {
              return value == null || value.isEmpty
                  ? 'Please enter your email'
                  : !EmailValidator.validate(value)
                      ? 'Please enter valid email'
                      : null;
            },
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Enter Your Email",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: const BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            style: const TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            onChanged: (val) {},
            controller: passwordController,
            validator: (value) {
              return value == null || value.isEmpty
                  ? "Please enter your password"
                  : null;
            },
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

  void showInSnackBar(context, String s) {
    var snackBar = SnackBar(content: Text(s), backgroundColor: Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
