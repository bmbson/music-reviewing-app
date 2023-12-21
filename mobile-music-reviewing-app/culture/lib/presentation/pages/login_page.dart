import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _passwordInvisibility = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("Culture",
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Username'),
              ),
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: _passwordInvisibility,
              decoration: InputDecoration(
                  suffixIcon: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        setState(() {
                          _passwordInvisibility = !_passwordInvisibility;
                        });
                      },
                      child: const Icon(Icons.remove_red_eye)),
                  icon: const Icon(Icons.key),
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Password'),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () {
                      context.go('/signuppage');
                    },
                    child: const Text('Sign Up')),
                const SizedBox(width: 10),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate() == true) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          context.go('/genreselectionscaffold');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            debugPrint('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            debugPrint('Wrong password provided for that user.');
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill in the form fields.')),
                        );
                      }
                    },
                    child: const Text("Submit")),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
