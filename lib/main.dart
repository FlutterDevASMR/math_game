import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_game/widgets/numberpad_button.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> buttonTexts = [
    '7',
    '8',
    '9',
    'Check',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '0',
  ];

  String userAnswer = '';

  int firstNum = Random().nextInt(10);
  int secondNum = Random().nextInt(10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Math game',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: yellowColor,
        elevation: 0,
      ),
      backgroundColor: yellowColor,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$firstNum + $secondNum = ',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        userAnswer,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    buttonTapped(buttonTexts[index]);
                  },
                  child: NumberpadButton(
                    buttonText: buttonTexts[index],
                  ),
                ),
                itemCount: buttonTexts.length,
                physics: NeverScrollableScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void buttonTapped(String text) {
    if (text == 'Check') {
      if (userAnswer.isNotEmpty) {
        checkAnswer();
      }
    } else if (text == 'DEL') {
      if (userAnswer.isNotEmpty) {
        setState(() {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        });
      }
    } else {
      if (userAnswer.length < 3) {
        setState(() {
          userAnswer += text;
        });
      }
    }
  }

  void checkAnswer() {
    if (firstNum + secondNum == int.parse(userAnswer)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Correct!'),
          content: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              goToNextQuestion();
            },
            child: Text('Go to next question'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ),
      );
      goToNextQuestion();
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Incorrect!'),
          content: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);

              tryAgain();
            },
            child: Text('Try again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
          ),
        ),
      );
    }
  }

  void goToNextQuestion() {
    setState(() {
      userAnswer = '';

      firstNum = Random().nextInt(10);
      secondNum = Random().nextInt(10);
    });
  }

  void tryAgain() {
    setState(() {
      userAnswer = '';
    });
  }
}
