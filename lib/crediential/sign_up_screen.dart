import 'package:ada_bread/crediential/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../data_provider.dart';
import '../home_page.dart';
import '../other/constants.dart';

bool _isRegistering = false;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _UserNameController = TextEditingController();
  final TextEditingController _EmailController = TextEditingController();
  final _userNameFocus = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscureTextForSignup = true;
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();
  String username = '';
  String userEmail = '';
  String userPassword = '';
  @override
  void dispose() {
    _userNameFocus.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordController.dispose();
    _EmailController.dispose();
    _UserNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
        title: const Text(
          'Create an account',
          style: storageTitle,
        ),
        elevation: 0,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isRegistering,
        opacity: 0.5,
        blur: 0,
        progressIndicator: const CircularProgressIndicator(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
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
                            'Username',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            focusNode: _userNameFocus,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_emailFocusNode),
                            controller: _UserNameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Username can\'t be empty';
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              username = value;
                            },
                            decoration: InputDecoration(
                                labelText: 'Username',
                                hintText: 'Enter the username',
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
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(10),
                                )),
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
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passwordFocusNode),
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red),
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
                            focusNode: _passwordFocusNode,
                            textInputAction: TextInputAction.go,
                            controller: _passwordController,
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
                            obscureText: _obscureTextForSignup,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureTextForSignup =
                                        !_obscureTextForSignup;
                                  });
                                },
                                icon: Icon(_obscureTextForSignup
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
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    setState(() {
                      _isRegistering = true;
                    });
                    try {
                      _EmailController.clear();
                      _UserNameController.clear();
                      _passwordController.clear();
                      final user = await auth.createUserWithEmailAndPassword(
                          email: userEmail, password: userPassword);
                      if (user != null) {
                        setState(() {
                          _isRegistering = false;
                        });
                        FirebaseFirestore.instance
                            .collection('LoggedUser')
                            .add({
                          'username': username,
                          'userEmail': userEmail,
                          'loggedDate': DateTime.now().toString()
                        });
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (ctx) => HomePage(),
                          ),
                        );
                        setState(() {
                          Provider.of<DataProvider>(context, listen: false)
                              .checker(auth.currentUser.email);
                        });
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
                              content: Text(e, overflow: TextOverflow.visible),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Ok'))
                              ],
                            );
                          });
                      setState(() {
                        _isRegistering = false;
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
                      'Sign up',
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
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Have an Account ?',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const LoginDemo(),
                        ),
                      );
                    },
                    child: const Text('Login'),
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
