import 'package:flutter/material.dart';
import 'package:bite_zone/services/auth_service.dart';
import 'package:quickalert/quickalert.dart';

class UserRegisterScreen extends StatefulWidget {
  @override
  _UserRegisterScreenState createState() => _UserRegisterScreenState();
}

class _UserRegisterScreenState extends State<UserRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _name;
  String? _email;
  String? _password;
  bool _passtoggle = true;

  void _registerUser() async {
    try {
      await AuthService().registerUser(_name!, _email!, _password!);
      _showSuccessAlert();
    } catch (er) {
      _showErrorAlert();
    }
  }

  void _showSuccessAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Registration",
      text: 'Successful!',
      confirmBtnText: 'Continue',
      confirmBtnColor: const Color.fromARGB(255, 101, 145, 103),
      onConfirmBtnTap: () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },
    );
  }

  void _showErrorAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Oops!",
      text: 'Registration failed!',
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
              child: Column(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child:
                        _buildTextField("Full Name", (value) => _name = value),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: _buildTextField("Email", (value) => _email = value),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: _buildPasswordField(
                        "Password", (value) => _password = value),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _registerUser();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
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
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/login', (route) => false);
                          },
                          child: const Text(
                            "Already have an account? Sign-in",
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
    );
  }

  Widget _buildTextField(String label, Function(String?) onSaved) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: (text) {
          if (text!.isEmpty) {
            return "$label can't be empty";
          }
          if (label == "Full Name") {
            if (text.length < 3) {
              return "Full Name must be at least 3 characters long";
            }
            if (!RegExp(r"^[a-zA-Z\s]+$").hasMatch(text)) {
              return "Full Name can only contain letters and spaces";
            }
          }
          if (label == "Email") {
            if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
                .hasMatch(text)) {
              return "Enter a valid email address";
            }
          }
          return null;
        },
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: "Enter your $label",
          filled: true,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, Function(String?) onSaved) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        validator: (text) {
          if (text!.isEmpty) {
            return "$label can't be empty";
          }
          if (text.length < 8) {
            return "Password must be at least 8 characters long";
          }
          if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$')
              .hasMatch(text)) {
            return "Password must contain at least one uppercase letter, one lowercase letter, and one number";
          }
          return null;
        },
        onSaved: onSaved,
        obscureText: _passtoggle,
        decoration: InputDecoration(
          hintText: "Enter $label",
          filled: true,
          
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _passtoggle ? Icons.visibility_off : Icons.visibility,
              color: Colors.red[300],
            ),
            onPressed: () {
              setState(() {
                _passtoggle = !_passtoggle;
              });
            },
          ),
        ),
      ),
    );
  }
}
