import 'package:firebaseauth/cubits/auth_cubit/auth_cubit.dart';
import 'package:firebaseauth/cubits/auth_cubit/auth_state.dart';
import 'package:firebaseauth/screens/verify_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Sign In With phone no.",
        style: TextStyle(fontSize: 24),
      )),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: phoneController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Enter phone no.',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthCodeSentsState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VerifyPhoneScreen()),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                    onPressed: () {
                      String phoneNumber = "+977${phoneController.text}";
                      BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                    },
                    child: const Text("Sign In"));
              },
            )
          ],
        ),
      ),
    );
  }
}
