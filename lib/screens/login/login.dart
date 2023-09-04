import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/components/login/login_form.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          //background with linear gradient
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromRGBO(66, 153, 49, 1), Color.fromRGBO(42, 114, 28, 1)],
            ),
            color: Colors.white,
          ),
          child: const Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                        child: LoginForm(
                      email: 'carlos.ramv97@gmail.com',
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
