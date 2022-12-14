import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyApp(),);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color start_color = Colors.white;
  int randomNumber = Random().nextInt(20);

  changeBackground(String value, int tries) async {
    print(tries);
    int guessedNumber = int.parse(value);
    Color color;
    if(guessedNumber == -1) {
      color = Colors.white;
    }
    else if(guessedNumber == randomNumber) {
      color = Colors.green;
    }
    else if(guessedNumber > randomNumber) {
      color = Colors.blue;
    }
    else {
      color = Colors.red;
    }
    setState(() {
      start_color = color;
    });
  }
  var tries = 0;

  tempChange(var value) async {
    changeBackground(value, tries);
    await Future.delayed(Duration(seconds: 1));
    changeBackground("-1", tries);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: start_color,
        appBar: AppBar(
          title: Text("Guessing Game"),
        ),
        body: Center(
          child: TextField(
            onSubmitted: (String value) {
              tries++;
              tempChange(value);
              if(tries == 3) {
                showDialog(context: context, builder: (_) {
                    return AlertDialog(
                          title: const Text('Alert !'),
                          content: const Text('You have exhausted 3 tries !'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                });
              }
            }
          ),
        ),

    );
  }
}