import 'package:bite_zone/providers/theme_provider.dart';
import 'package:bite_zone/services/bite_zone_db_service.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:bite_zone/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  void sendUser() async {
    try {
      await AuthService().login(_email!, _password!);
      loginConfirm();
    } catch (er) {
      print(er.toString());
      loginError(er.toString());
    }
  }

  void loginConfirm() async {
    final user = await BiteZoneDBService.instance.getUser();
    if (user != null) {
      String role = user['role'];
      String route = _getHomeRoute(role);

      Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
    } else {
      loginError("Invalid Username or password");
    }
  }

  String _getHomeRoute(String role) {
    switch (role) {
      case 'WASTE_COLLECTOR':
        return '/waste_collector_home';
      case 'USER':
        return '/user_home';
      default:
        return '/login';
    }
  }

  void loginError(String error) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Oops!",
      text: error,
      confirmBtnText: 'Try again',
      confirmBtnColor: const Color.fromARGB(255, 67, 78, 68),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_o.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 150, 0, 0),
                        child: Image.asset(
                          'assets/logo.png',
                          height: 200,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          _email = value!;
                        },
                        validator: (email) {
                          if (email == null || email.isEmpty) {
                            return "Please Enter Email";
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) return "Its not a valid Email";
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "User Email",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          // fillColor: Colors.transparent,
                          // enabledBorder: InputBorder.none,
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.black),
                          // ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.red[300],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        onSaved: (value) {
                          _password = value!;
                        },
                        validator: (password) {
                          if (password == null || password.isEmpty) {
                            return "Please Enter password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          filled: true,
                          // fillColor: Colors.transparent,
                          // enabledBorder: InputBorder.none,
                          // focusedBorder: UnderlineInputBorder(
                          //   borderSide: BorderSide(color: Colors.black),
                          // ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.red[300],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            sendUser();
                          } else {
                            print('not valid form');
                            return;
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Abadi',
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed('/register_user');
                            },
                            child: const Text(
                              "New User? Sign-Up",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
