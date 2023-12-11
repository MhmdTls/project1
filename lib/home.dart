import 'package:flutter/material.dart';
import 'dart:math';
import 'page2.dart';


class NumberGuessingHomePage extends StatefulWidget {
  @override
  _NumberGuessingHomePageState createState() => _NumberGuessingHomePageState();
}

class _NumberGuessingHomePageState extends State<NumberGuessingHomePage> {
  late String _selectedDifficulty = 'Medium';
  late int _difficultyLevel = 100;

  void updateDifficulty(int difficultyLevel) {
    setState(() {
      _difficultyLevel = difficultyLevel;
      if (_selectedDifficulty == 'Easy') {
        _generatedNumber = _random.nextInt(50) + 1;
      } else if (_selectedDifficulty == 'Hard') {
        _generatedNumber = _random.nextInt(1000) + 1;
      } else {
        _generatedNumber = _random.nextInt(_difficultyLevel) + 1;
      }
    });
  }

  final Random _random = Random();
  int _generatedNumber=0;
  TextEditingController _controller = TextEditingController();
  String _guessResult = '';

  void openPage2() {
    try {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const Page2(),
          )
      );
    }
    catch(e) {
      print(e);
    }
  }



  void checkGuess(int guess) {
    setState(() {
      if (guess == _generatedNumber) {
        _guessResult = 'Congratulations! You guessed the correct number $_generatedNumber';
        openPage2();
      } else if (guess < _generatedNumber) {
        _guessResult = 'Try a higher number';
      } else {
        _guessResult = 'Try a lower number';
      }
    });
  }



  void resetGame() {
    setState(() {
      _controller.clear();
      _guessResult = '';
      if (_selectedDifficulty == 'Easy') {
        _generatedNumber = _random.nextInt(50) + 1;
      } else if (_selectedDifficulty == 'Hard') {
        _generatedNumber = _random.nextInt(1000) + 1;
      } else {
        _generatedNumber = _random.nextInt(_difficultyLevel) + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Guessing Game'),
        backgroundColor: Color(0xff301e42),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose Difficulty', style: TextStyle(fontSize: 35)),
            const SizedBox(height: 20),
            MyDropdownMenuWidget(updateDifficulty: updateDifficulty),

            Text(
              _guessResult.isEmpty
                  ? 'Guess a number between ${_selectedDifficulty == 'Easy' ? '1 and 50' : _selectedDifficulty == 'Hard' ? '1 and 1000' : '1 and $_difficultyLevel'}:'
                  : _guessResult,
              style: TextStyle(fontSize: 20),
            ),



            SizedBox(height: 20),
            SizedBox(
              width: 180,
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onSubmitted: (String value) {
                  int guess = int.tryParse(value) ?? 0;


                  if (_selectedDifficulty == 'Easy' && guess >= 1 && guess <= 50) {
                    checkGuess(guess);
                  } else if (_selectedDifficulty == 'Hard' && guess >= 1 && guess <= 1000) {
                    checkGuess(guess);
                  } else if (_selectedDifficulty == 'Medium' && guess >= 1 && guess <= _difficultyLevel) {
                    checkGuess(guess);
                  }
                  setState(() {
                    if (_selectedDifficulty == 'Easy') {
                      _guessResult = 'Please enter a valid number between 1 and 50';
                    } else if (_selectedDifficulty == 'Hard') {
                      _guessResult = 'Please enter a valid number between 1 and 1000';
                    } else {
                      _guessResult = 'Please enter a valid number between 1 and $_difficultyLevel';
                    }
                  });




                },
              ),
            ),
            const SizedBox(height: 20),


            ElevatedButton(
              onPressed: () {
                int guess = int.tryParse(_controller.text) ?? 0;
                if (_selectedDifficulty == 'Easy' && guess >= 1 && guess <= 50) {
                  checkGuess(guess);
                } else if (_selectedDifficulty == 'Hard' && guess >= 1 && guess <= 1000) {
                  checkGuess(guess);
                } else if (_selectedDifficulty == 'Medium' && guess >= 1 && guess <= _difficultyLevel) {
                  checkGuess(guess);
                } else {
                  setState(() {
                    if (_selectedDifficulty == 'Easy') {
                      _guessResult = 'Please enter a valid number between 1 and 50';
                    } else if (_selectedDifficulty == 'Hard') {
                      _guessResult = 'Please enter a valid number between 1 and 1000';
                    } else {
                      _guessResult = 'Please enter a valid number between 1 and $_difficultyLevel';
                    }
                  });
                }
              },
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(primary: Color(0xff000036)),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetGame,
              child: Text('Reset Game'),
              style: ElevatedButton.styleFrom(primary: Color(0xff000036)),

            ),
          ],
        ),
      ),


    );


  }
}

class MyDropdownMenuWidget extends StatefulWidget {
  const MyDropdownMenuWidget({required this.updateDifficulty, Key? key}) : super(key: key);
  final Function(int) updateDifficulty;

  @override
  State<MyDropdownMenuWidget> createState() => _MyDropdownMenuWidgetState();
}

class _MyDropdownMenuWidgetState extends State<MyDropdownMenuWidget> {
  late String _selectedDifficulty = 'Medium';

  void updateDifficulty() {
    int difficultyLevel = 0;
    switch (_selectedDifficulty) {
      case 'Easy':
        difficultyLevel = 50;
        break;
      case 'Medium':
        difficultyLevel = 100;
        break;
      case 'Hard':
        difficultyLevel = 1000;
        break;
      default:
        difficultyLevel = 100;
    }
    widget.updateDifficulty(difficultyLevel);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedDifficulty,
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedDifficulty = newValue;
            updateDifficulty();
          });
        }
      },
      items: <String>['Easy', 'Medium', 'Hard'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}