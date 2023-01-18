import 'package:firebaseauth/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebaseauth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/auth_cubit/auth_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Home",
        style: TextStyle(fontSize: 24),
      )),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthCodeLoggedOutState) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).logOut();
            },
            child: const Text(
              "Log Out",
              style: TextStyle(color: Colors.blue, fontSize: 24),
            ),
          );
        },
      ),
    );
  }
}
