import 'package:flutter/material.dart';

import '../navigation/navigation_bar_screen.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(this.submitForm, this.isLoading);

  final bool isLoading;
  final void Function(
      String email, String password, String? username, bool isLogin) submitForm;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

final _formKey = GlobalKey<FormState>();

String _userEmail = '';
String _userPassword = '';
String? _userName;

bool _isLoginForm = true;

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    void trySubmitForm() {
      final isValid = _formKey.currentState!.validate();
      FocusScope.of(context).unfocus();
      if (isValid) {
        _formKey.currentState!.save();
        widget.submitForm(
          _userEmail.trim(),
          _userPassword.trim(),
          _userName?.trim(),
          _isLoginForm,
        );
      }
    }

    void switchFormMode() {
      setState(() {
        _isLoginForm = !_isLoginForm;
      });
    }

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_screen_picture.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.white60,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(25),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (!_isLoginForm)
                        TextFormField(
                          key: const ValueKey('username'),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Insert your username';
                            }
                            return null;
                          },
                          onSaved: (newValue) => _userName = newValue,
                        ),
                      TextFormField(
                        key: const ValueKey('emailAddress'),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _userEmail = newValue!,
                      ),
                      TextFormField(
                        key: const ValueKey('password'),
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 5) {
                            return 'Password is too short!';
                          }
                          return null;
                        },
                        onSaved: (newValue) => _userPassword = newValue!,
                      ),
                      if (!_isLoginForm)
                        TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'Confirm password',
                          ),
                        ),
                      const SizedBox(height: 20),
                      widget.isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: trySubmitForm,
                              child: Text(_isLoginForm ? 'LOGIN' : 'SIGN UP'),
                            ),
                      TextButton(
                        onPressed: switchFormMode,
                        child: Text(
                            '${_isLoginForm ? 'Don\'t have an account?' : 'Already have an account?'} ${_isLoginForm ? 'Sign up' : 'Login'}'),
                      ),
                      TextButton(
                        child: const Text('Continue as guest'),
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              NavigationBarScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
