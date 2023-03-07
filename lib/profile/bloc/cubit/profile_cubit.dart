import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part '../state/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
}
