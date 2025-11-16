import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  loginAuth({required String email , required String password}) async {
    emit(LoginLoading());
    try{
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        emit(LoginSuccess());
      } catch(e) {
        emit(LoginFailure(errMessage: e.toString()));
    }

  }

}
