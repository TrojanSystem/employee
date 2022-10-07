import 'package:ada_bread/crediential/forgot_password.dart';
import 'package:ada_bread/crediential/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../home_page.dart';
import '../other/constants.dart';

bool _isLoading = false;

class LoginDemo extends StatefulWidget {
  const LoginDemo({Key key}) : super(key: key);

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _EmailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  final _passFocus = FocusNode();
  final _emailFocus = FocusNode();
  String userEmail = '';
  String userPassword = '';
  bool _obscureText = true;
  @override
  void dispose() {
    _passFocus.dispose();
    _emailFocus.dispose();
    _passwordController.dispose();
    _EmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Login page',
          style: storageTitle,
        ),
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        opacity: 0.5,
        blur: 0,
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      clipBehavior: Clip.antiAlias,
                      width: 210,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Image.asset('images/logo.jpg')),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            focusNode: _emailFocus,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () =>
                                FocusScope.of(context).requestFocus(_passFocus),
                            controller: _EmailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email can\'t be empty';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              userEmail = value;
                            },
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              labelText: 'Email',
                              hintText: 'Enter the email',
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 8, 35, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            focusNode: _passFocus,
                            textInputAction: TextInputAction.go,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password can\'t be empty';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              userPassword = value;
                            },
                            obscureText: _obscureText,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              labelText: 'Password',
                              hintText: 'Enter the password',
                              filled: true,
                              fillColor: Colors.grey[200],
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ForgotPassword(),
                      ),
                    );
                  },
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      _EmailController.clear();
                      _passwordController.clear();
                      final user = await auth.signInWithEmailAndPassword(
                          email: userEmail, password: userPassword);
                      if (user != null) {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => HomePage(),
                          ),
                        );
                      }
                    } catch (e) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'Error Occurred',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w900),
                              ),
                              content: Text(e.toString(),
                                  overflow: TextOverflow.visible),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Ok'),
                                )
                              ],
                            );
                          });
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  }
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(130, 10, 130, 0),
                  width: double.infinity,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('New User?'),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => SignUpScreen()),
                      );
                    },
                    child: const Text('Create Account'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
