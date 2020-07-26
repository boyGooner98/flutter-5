import 'package:flutter/material.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:loading/loading.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  bool loginMode = true;
  bool loading = false;

  Future<void> signUp() async {
    setState(() {
      loading = true;
    });
    await Provider.of<Auth>(context, listen: false).addUser(emailController.text, passwordController.text);
    setState(() {
      loading = false;
    });
  }

  Future<void> logIn() async {
    setState(() {
      loading = true;
    });
    await Provider.of<Auth>(context, listen: false).loginUser(emailController.text, passwordController.text);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginMode
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  colors: [Colors.green, Colors.pink],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Your Shop',
                      style: TextStyle(fontFamily: 'moderno-bold', fontSize: 40),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            autovalidate: true,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  autocorrect: true,
                                  decoration: InputDecoration(labelText: 'email'),
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(passwordFocusNode);
                                  },
                                  textInputAction: TextInputAction.next,
                                  controller: emailController,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autocorrect: true,
                                  decoration: InputDecoration(labelText: 'password'),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                                  },
                                  controller: passwordController,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    !loading
                                        ? RaisedButton(
                                            child: Text('Login'),
                                            onPressed: logIn,
                                          )
                                        : Loading(
                                            indicator: BallPulseIndicator(),
                                            color: Colors.pink,
                                            size: 20,
                                          ),
                                    FlatButton(
                                      child: Text('SignUp'),
                                      onPressed: () {
                                        setState(() {
                                          loginMode = false;
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.green, Colors.pink],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Your Shop',
                      style: TextStyle(fontFamily: 'moderno-bold', fontSize: 40),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            autovalidate: true,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  autocorrect: true,
                                  decoration: InputDecoration(labelText: 'email'),
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(passwordFocusNode);
                                  },
                                  textInputAction: TextInputAction.next,
                                  controller: emailController,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autocorrect: true,
                                  decoration: InputDecoration(labelText: 'password'),
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
                                  },
                                  controller: passwordController,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  autocorrect: true,
                                  decoration: InputDecoration(labelText: 'confirm-password'),
                                  textInputAction: TextInputAction.done,
                                  controller: confirmPasswordController,
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: <Widget>[
                                    !loading
                                        ? RaisedButton(
                                            child: Text('signUp'),
                                            onPressed: signUp,
                                          )
                                        : Loading(
                                            indicator: BallPulseIndicator(),
                                            color: Colors.pink,
                                            size: 20,
                                          ),
                                    FlatButton(
                                      child: Text('Login'),
                                      onPressed: () {
                                        setState(() {
                                          loginMode = true;
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
