import 'package:culture/utils/EmailValidator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

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
                  } else if (value.isValidEmail() == false) {
                    return 'Invalid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email'),
              ),
            ),
            TextFormField(
              controller: usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your Username';
                }
                return null;
              },
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  hintText: 'Enter Username'),
            ),
            const SizedBox(
              height: 8,
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
                          print(_passwordInvisibility);
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
            TextFormField(
              controller: confirmPasswordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the confirm password field';
                } else if (value != passwordController.text) {
                  return "Passwords do not match";
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
                      child: const Icon(Icons.remove_red_eye_sharp)),
                  icon: const Icon(Icons.key),
                  border: const OutlineInputBorder(),
                  hintText: 'Confirm Password'),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                    onPressed: () {
                      context.go('/loginpage');
                    },
                    child: const Text('Log In')),
                const SizedBox(width: 10),
                TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          credential.user!
                              .updateDisplayName(usernameController.text);
                          context.go('/loginpage');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            debugPrint('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            debugPrint(
                                'The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
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
