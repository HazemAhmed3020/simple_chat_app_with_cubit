import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  signupAuth({required String email, required String password}) async {
    emit(SignupLoading());
    try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        emit(SignupSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailure(errMessage: e.toString()));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailure(errMessage: e.toString()));
      } else {
        emit(SignupFailure(errMessage: e.toString()));
      }
    } catch (e) {
      emit(SignupFailure(errMessage: e.toString()));
    }
  }
}
