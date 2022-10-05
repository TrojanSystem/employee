import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String userEmail = '';

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _EmailController = TextEditingController();

  final _emailFocusNode = FocusNode();

  final auth = FirebaseAuth.instance;

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _EmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
              child: Image.asset('images/logo.jpg'),
            ),
          ),
          Expanded(
            flex: 4,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Forgot',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Password?',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: const [
                        Text(
                          'Don\'t worry! It happens.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        Text(
                          'Please enter your email address.',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                          textInputAction: TextInputAction.go,
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
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                        try {
                          _EmailController.clear();
                          _passwordController.clear();
                          await auth.sendPasswordResetEmail(email: userEmail);
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.blue[500],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
