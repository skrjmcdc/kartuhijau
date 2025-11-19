import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pdjau = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Center(
          child: ListView(
            children: [
              const Text('Register'),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username...',
                ),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password...',
                ),
                obscureText: true,
              ),
              TextField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm...',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  String username = _usernameController.text;
                  String password1 = _passwordController.text;
                  String password2 = _confirmPasswordController.text;
                  final response = await pdjau.postJson(
                      "http://localhost:8123/auth/register/",
                      jsonEncode({
                        'username': username,
                        'password1': password1,
                        'password2': password2,
                  }));
                  if (context.mounted) {
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                              const SnackBar(
                                content: Text('Successfully registered account.')
                              ));
                      Navigator.pop(context);
                    } else {
                      String message = response['message'];
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                            SnackBar(
                                content: Text('Login failed: $message')
                            ));
                    }
                  }
                },
                child: const Text('Register'),
              ),
            ],
          ),
        )
    );
  }
}