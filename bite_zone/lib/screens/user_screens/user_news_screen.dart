import 'package:bite_zone/components/news_widget.dart';
import 'package:flutter/material.dart';

class UserNewsScreen extends StatefulWidget {
  const UserNewsScreen({super.key});

  @override
  State<UserNewsScreen> createState() => _UserNewsScreenState();
}

class _UserNewsScreenState extends State<UserNewsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            NewsWidget(),
          ],
        ),
      ),
    );
  }
}
