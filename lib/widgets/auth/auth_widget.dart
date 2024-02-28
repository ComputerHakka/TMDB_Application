import 'package:cinema_app/theme/app_button_style.dart';
import 'package:flutter/material.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to your account'),
      ),
      body: ListView(
        children: const [
          _HeaderWidget(),
        ],
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 16,
      color: Colors.black,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const _FormWidget(),
          const SizedBox(height: 20),
          const Text(
            'In order to usethe editing and rating capabilities of TMDb, as well as get personal recommendations you will need to login to your account. If you do not have an account, registering for an account is free and simple. Click here to get started.',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: const Text('Register'),
          ),
          const SizedBox(height: 20),
          const Text(
            'If you signed up but didn`t get your verification email, click here to have it resent',
            style: textStyle,
          ),
          const SizedBox(height: 5),
          TextButton(
            onPressed: () {},
            style: AppButtonStyle.linkButton,
            child: const Text('Verify email'),
          ),
        ],
      ),
    );
  }
}

class _FormWidget extends StatefulWidget {
  const _FormWidget({super.key});

  @override
  State<_FormWidget> createState() => __FormWidgetState();
}

class __FormWidgetState extends State<_FormWidget> {
  final _loginTExtController = TextEditingController(text: 'admin');
  final _passwordTExtController = TextEditingController(text: 'admin');
  String? errorText;

  void _auth() {
    final login = _passwordTExtController.text;
    final password = _passwordTExtController.text;
    if (login == 'admin' && password == 'admin') {
      errorText = null;

      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      errorText = 'Неверный логин или пароль';
      print('error');
    }
    setState(() {});
  }

  void _resetPassword() {
    print('reset password');
  }

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF01B4E4);
    const textStyle = TextStyle(
      fontSize: 16,
      color: Color(0xFF212529),
    );
    const textFieldDecoration = InputDecoration(
      border: OutlineInputBorder(),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      isCollapsed: true,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorText != null) ...[
          Text(
            errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 17),
          ),
          const SizedBox(height: 25)
        ],
        const Text(
          'Username',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          controller: _loginTExtController,
          decoration: textFieldDecoration,
        ),
        const SizedBox(height: 20),
        const Text(
          'Password',
          style: textStyle,
        ),
        const SizedBox(height: 5),
        TextField(
          decoration: textFieldDecoration,
          controller: _passwordTExtController,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            ElevatedButton(
              onPressed: _auth,
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(color),
                foregroundColor: MaterialStatePropertyAll(Colors.white),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                padding: MaterialStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(width: 15),
            TextButton(
              onPressed: _resetPassword,
              style: AppButtonStyle.linkButton,
              child: const Text('Reset password'),
            )
          ],
        )
      ],
    );
  }
}
