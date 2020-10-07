import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/screens/dashboard/dashboard_screen.dart';
import 'package:pharmacy_app/src/store/providers/auth_provider.dart';
import 'package:pharmacy_app/src/utils/animation.dart';
import 'package:pharmacy_app/src/utils/wave_clipper.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username;
  String _password;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isErrorVisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xff21254A),
      body: Form(
        key: _formKey,
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                height: 200 + kToolbarHeight,
                child: FadeAnimation(
                  1,
                  ClipPath(
                    clipper: WaveClipperTwo(),
                    child: Container(
                      height: 120,
                      color: Colors.orange,
                      child: Center(
                          child: Text(
                        "PharmacyApp",
                        style: TextStyle(fontSize: 36),
                      )),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Hello there, \nwelcome back",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FadeAnimation(
                    1,
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.transparent,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value.length < 5)
                                  return "Error";
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              onSaved: (value) => _username = value,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey[100],
                                ),
                              ),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value.length < 5)
                                  return "Error";
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                              onSaved: (value) => _password = value,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: isErrorVisible,
                    child: Center(
                      child: FadeAnimation(
                        1,
                        Text(
                          "Error while logging in, please try again",
                          style: TextStyle(
                            color: Colors.pink[200],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FadeAnimation(
                    1,
                    GestureDetector(
                      onTap: () {
                        _checkInfoAndLogin();
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromRGBO(49, 39, 79, 1),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FadeAnimation(
                    1,
                    Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.pink[200],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _checkInfoAndLogin() async {
    //check fields
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      AuthProvider authProvider = context.read<AuthProvider>();
      bool results = await authProvider.loginClient(
          username: _username, password: _password);
      if (results) {
        debugPrint("Success while logging in");
        //user logged in
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => DashBoardScreen(),
            ),
            (route) => false);
      } else {
        debugPrint("Error while logging in");
        setState(() {
          isErrorVisible = true;
        });
      }
    }
  }
}
