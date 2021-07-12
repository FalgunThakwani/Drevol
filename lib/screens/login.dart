import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 50),
              child: Image.asset("images/flutter.png"),
            ),
            Container(
                margin: EdgeInsets.only(top: 20, left: 30, right: 30),
                child: TextFormField(
                  controller: username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "* Required";
                    } else {
                      return null;
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "User Name",
                      hintText: "Username"),
                )),
            Container(
              margin: EdgeInsets.only(top: 10, left: 30, right: 30),
              child: TextFormField(
                controller: password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "* Required";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Password"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 70, right: 70),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                child: Text("Login"),
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    validateUsername(username, password);
                  } else {
                    print("Not Validated");
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void validateUsername(var username, var password) {
    String username1 = username.text;
    String password1 = password.text;
    if (username1 == "admin") {
      if (password1 == "1234") {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          Fluttertoast.showToast(msg: 'Login Successfull');
          return HomePage();
        }));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("Incorrect username or password")));
      return print("incorrect");
    }
  }
}
