// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/utilities/colors.dart';

class LoginForm extends ConsumerStatefulWidget {
  final String? email;
  const LoginForm({super.key, this.email = ''});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  var supabase = Supabase.instance.client;
  Session? session;

  //Login with email and password in supabase
  void login() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await supabase.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      session = response.session;
      final User? user = response.user;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(user?.email ?? ''),
          behavior: SnackBarBehavior.floating,
        ),
      );
      context.go('/todos');
    } catch (e) {
      //Snackbar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating),
      );
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  //logout from supabase
  void logout() async {
    try {
      setState(() {
        isLoading = true;
      });
      await supabase.auth.signOut();
      session = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logout success', style: TextStyle(color: Colors.white)),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      //Snackbar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString(), style: const TextStyle(color: Colors.white)), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating),
      );
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    session = supabase.auth.currentSession;
    emailController.text = widget.email!;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (session != null) GoRouter.of(context).go('/todos');
    });
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Todo App',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.email, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    controller: emailController,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.lock, color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: login,
                    style: ElevatedButton.styleFrom(backgroundColor: buttonPrimaryColor, foregroundColor: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text('Login'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
