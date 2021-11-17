import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/constants.dart';
import 'signup.dart';
import 'package:quiz_app/screens/categories.dart';
import 'dart:ui';

class SignInScreen extends StatefulWidget {
  static String tag = 'register-page';
  @override
  _SignIn createState() => new _SignIn();
}

class _SignIn extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailTextEditController = new TextEditingController();
  final passwordTextEditController = new TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String _errorMessage = '';

  void processError(final PlatformException error) {
    setState(() {
      _errorMessage = error.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned.fill(
          child: Image(
            image: AssetImage("assets/icons/bg1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 100.0,
            ),
            Image.asset('assets/icons/aum.png'),
            Text(
              "American University of the Middle East",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.white),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "BOOK CONTEST",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40.0,
            ),
            Form(
              key: _formKey,
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("SIGN IN",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              )),
                          FlatButton(
                            color: Colors.black12,
                            textColor: Colors.white,
                            child: Text('SIGN UP',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                )),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return SignUP();
                                }),
                              );
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '$_errorMessage',
                          style: TextStyle(fontSize: 14.0, color: Colors.red),
                          textAlign: TextAlign.center,
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
                          autofocus: true,
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
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              child: Container(
                color: Colors.green[900],
                margin: EdgeInsets.only(top: 10.0),
                width: double.infinity,
                height: 80.0,
                child: Center(
                  child: Text('LOGIN',
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
                        .signInWithEmailAndPassword(
                            email: emailTextEditController.text,
                            password: passwordTextEditController.text);
                    if (User != null) {
                      username = User.user.displayName;
                      email = User.user.email;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoriesScreen(),
                          ));
                    } else {
                      print('user does not exist');
                    }
                  } on FirebaseAuthException catch (e) {
                    if (e.message ==
                        "There is no user record corresponding to this identifier. The user may have been deleted.")
                      loginAlertDialog(context,
                          "User not found. Please signup if you don't have an account.");
                    else
                      loginAlertDialog(context, e.message);
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

loginAlertDialog(BuildContext context, String str) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Sign-in Error!"),
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
