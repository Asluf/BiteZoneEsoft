import 'package:bite_zone/screens/common_screens/login_screen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_m.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
                child: Image.asset(
                  'assets/logo.png',
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
                height: 5,
                color: Colors.red[400],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                height: 5,
                color: Colors.red[400],
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                height: 5,
                color: Colors.red[400],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              height: 50,
              child: Center(
                child: SizedBox(
                  height: 45,
                  width: 240,
                  child: FloatingActionButton(
                      backgroundColor: Colors.red[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        'GET STARTED',
                        // style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
