import 'package:flutter/material.dart';
import'home.dart';

void main() {
  runApp(NumberGuessingGame());
}

class NumberGuessingGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Guessing Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumberGuessingHomePage(),
    );
  }
}