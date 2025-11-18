import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pdjau = context.watch<CookieRequest>();
    return Scaffold(
      appBar:   AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ListView(
          children: [
            const Text('Login'),
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
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;
                String password = _passwordController.text;
                final response = await pdjau.login("http://localhost:8123/auth/login/", {
                  'username': username,
                  'password': password,
                });
                if (pdjau.loggedIn) {
                  String message = response['message'];
                  String uname = response['username'];
                  if (context.mounted) {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                          SnackBar(
                              content: Text('$message Welcome, $uname.')
                          ));
                    Navigator.pop(context);
                  }
                } else {
                }
              },
              child: const Text('Login'),
            ),
          ],
        ),
      )
    );
  }
}