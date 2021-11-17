import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'dart:ui';

class SignUP extends StatefulWidget {
  static String tag = 'register-page';
  @override
  _SignUP createState() => new _SignUP();
}

class _SignUP extends State<SignUP> {
  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = new TextEditingController();
  final firstNameTextEditController = new TextEditingController();
  final lastNameTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();
  final confirmPasswordTextEditController = new TextEditingController();

  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  String _errorMessage = '';

  void processError(final PlatformException error) {
    setState(() {
      _errorMessage = error.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Register',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned.fill(
          child: Image(
            image: AssetImage("assets/icons/bg1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 50.0,
            ),
            Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 36.0, left: 24.0, right: 24.0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '$_errorMessage',
                      style: TextStyle(fontSize: 20.0, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your first name.';
                        }
                        return null;
                      },
                      controller: firstNameTextEditController,
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      focusNode: _firstNameFocus,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_lastNameFocus);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your last name.';
                        }
                        return null;
                      },
                      controller: lastNameTextEditController,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      focusNode: _lastNameFocus,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_emailFocus);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.isEmpty ||
                            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                          return 'Please enter a valid email.';
                        }
                        return null;
                      },
                      controller: emailTextEditController,
                      keyboardType: TextInputType.emailAddress,
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context).requestFocus(_passwordFocus);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value.length < 8) {
                          return 'Password must be longer than 8 characters.';
                        }
                        return null;
                      },
                      autofocus: false,
                      obscureText: true,
                      controller: passwordTextEditController,
                      textInputAction: TextInputAction.next,
                      focusNode: _passwordFocus,
                      onFieldSubmitted: (term) {
                        FocusScope.of(context)
                            .requestFocus(_confirmPasswordFocus);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      controller: confirmPasswordTextEditController,
                      focusNode: _confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value.isEmpty ||
                            value != passwordTextEditController.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0),
                            borderSide:
                                BorderSide(color: Colors.white, width: 10)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        errorStyle:
                            TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            GestureDetector(
              child: Container(
                color: Colors.green[900],
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 80.0,
                child: Center(
                  child: Text('SIGN UP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                ),
              ),
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  try {
                    UserCredential User = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailTextEditController.text,
                            password: passwordTextEditController.text);
                    if (User != null) {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(emailTextEditController.text)
                          .set({
                        'email': emailTextEditController.text,
                        'firstName': firstNameTextEditController.text,
                        'lastName': lastNameTextEditController.text,
                      });
                      User.user.updateDisplayName(
                          (firstNameTextEditController.text).toUpperCase());
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return SignInScreen();
                        }),
                      );
                    } else {
                      print('user does not exist');
                    }
                  } on FirebaseAuthException catch (e) {
                    signupAlertDialog(context, e.message);
                  }
                }
              },
            ),
          ],
        ),
      ]),
    );
  }
}

signupAlertDialog(BuildContext context, String str) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sign-up Error!"),
    content: Text(str),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
