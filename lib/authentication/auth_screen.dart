import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_favorite_places/screens/navigation_bar_screen.dart';

import '../helpers/auth.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum AuthAction { signUp, login }

class _LoginScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoginForm = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  var _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (_isLoginForm) {
          setState(() {
            _isLoading = true;
          });
          await Auth()
              .loginUser(_emailController.text, _passwordController.text);
        } else {
          setState(() {
            _isLoading = true;
          });
          await Auth()
              .signUpUser(_emailController.text, _passwordController.text);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _isLoading = false;
        });
        Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.BOTTOM);
      }
    }
  }

  void _switchFormMode() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.flight),
            SizedBox(width: 10),
            Text('JourneyJar'),
          ],
        ),
      ),
      body: Stack(children: [
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
                            controller: _usernameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Insert your username';
                              }
                              return null;
                            },
                          ),
                        TextFormField(
                          controller: _emailController,
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
                        ),
                        TextFormField(
                          controller: _passwordController,
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
                        ),
                        if (!_isLoginForm)
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Confirm password',
                            ),
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords are not the same!';
                              }
                              return null;
                            },
                          ),
                        SizedBox(height: 20),
                        _isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: _submitForm,
                                child: Text(_isLoginForm ? 'LOGIN' : 'SIGN UP'),
                              ),
                        TextButton(
                          onPressed: _switchFormMode,
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
      ]),
    );
  }
}
