import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauth/cubits/auth_cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      //logged in
      emit(AuthCodeLoggedInState(currentUser));
    } else {
      //Logged out
      emit(AuthCodeLoggedOutState());
    }
  }

  String? _verificationId;

  void sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: ((verificationId, forceResendingToken) {
          _verificationId = verificationId;
          emit(AuthCodeSentsState());
        }),
        verificationCompleted: (phoneAuthCredential) {
          signInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (erroor) {
          emit(AuthCodeErrorState(erroor.message.toString()));
        },
        codeAutoRetrievalTimeout: (verificationId) {
          _verificationId = verificationId;
        });
  }

  void verifyOTP(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    try {
      UserCredential userCrednetial =
          await _auth.signInWithCredential(credential);
      if (userCrednetial.user != null) {
        emit(AuthCodeLoggedInState(userCrednetial.user!));
      }
    } on FirebaseAuthException catch (ex) {
      emit(AuthCodeErrorState(ex.message.toString()));
    }
  }

  void logOut() async {
    await _auth.signOut();
    emit(AuthCodeLoggedOutState());
  }
}
