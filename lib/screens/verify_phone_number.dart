import 'package:firebaseauth/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebaseauth/cubits/auth_cubit/auth_state.dart';
import 'package:firebaseauth/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<VerifyPhoneScreen> {
  TextEditingController verifyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Verify phone no.",
        style: TextStyle(fontSize: 24),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: verifyController,
              maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter verify code',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthCodeLoggedInState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } else if (state is AuthCodeErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      duration: const Duration(milliseconds: 600),
                      content: Text(state.error)));
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                    onPressed: () {
                      String otpNumber = verifyController.text;
                      BlocProvider.of<AuthCubit>(context).verifyOTP(otpNumber);
                    },
                    child: const Text("Verify"));
              },
            )
          ],
        ),
      ),
    );
  }
}
