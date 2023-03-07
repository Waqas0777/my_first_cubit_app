part of '../cubit/signup_cubit.dart';

@immutable
abstract class SignupState {}


class SignupInitial extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {}

class SignupFailedState extends SignupState {}
