import 'package:firebaseauth/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebaseauth/cubits/auth_cubit/auth_state.dart';
import 'package:firebaseauth/screens/home_screen.dart';
import 'package:firebaseauth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState) {
            return oldState is AuthInitialState;
          },
          builder: (context, state) {
            if (state is AuthCodeLoggedInState) {
              return const HomeScreen();
            } else if (state is AuthCodeLoggedOutState) {
              return const SignInScreen();
            } else {
              //splash screen
              return const Scaffold();
            }
          },
        ),
      ),
    );
  }
}
