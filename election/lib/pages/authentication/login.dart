import 'package:election/pages/dashboard.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email = '';
  String _password = '';
  final Color _textColor = Colors.black; // Initial text color
  final OutlineInputBorder _focusedBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue), // Set the focused border color
  );
  bool _rememberPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.arrow_back_ios_new_sharp),
                ),
                Container(
                  height: 180,
                ),
                Container(
                  height: 530,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 54),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 14),
                            child: SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  "Login to your account",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              controller: emailController,
                              style: const TextStyle(
                                  color: Colors
                                      .black), // Set input text color here
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                hintText: 'Enter your email',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.person),
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your email';
                                }
                                // Email validation using regex pattern
                                final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
                                );
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                _email = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: TextFormField(
                              controller: passwordController,
                              style: const TextStyle(
                                  color: Colors
                                      .black), // Set input text color here
                              decoration: const InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter your password',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Colors.white,
                                prefixIcon: Icon(Icons.lock),
                                contentPadding: EdgeInsets.all(12.0),
                              ),
                              obscureText: true, // Hide the password characters
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          //
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: SizedBox(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        Transform.scale(
                                          scale: 0.7,
                                          child: Switch(
                                            activeColor: Colors.green[300],
                                            trackColor:
                                                const MaterialStatePropertyAll(
                                                    Colors.black12),
                                            activeTrackColor: Colors.black12,
                                            value: _rememberPassword,
                                            onChanged: (value) {
                                              setState(() {
                                                _rememberPassword = value;
                                              });
                                            },
                                          ),
                                        ),
                                        const Text('Remember Password',
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.green[300],
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //
                          const SizedBox(
                            height: 14,
                          ),
                          FilledButton.tonal(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.green[300])),
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   _formKey.currentState!.save();
                                // }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Dashboard();
                                    },
                                  ),
                                );
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(color: Colors.black),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              const TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                  text: "Register here",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green[300],
                                    fontWeight: FontWeight.w400,
                                  )),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
