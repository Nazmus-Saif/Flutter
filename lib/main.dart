import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simon Says Game',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final List<String> _colors = ['red', 'blue', 'green', 'purple'];
  List<String> _gameSequence = [];
  List<String> _userSequence = [];
  bool _started = false;
  int _level = 0;
  int _highestScore = 0;
  String _statusMessage = "Press Start to Begin";
  Set<String> _flashingButtons = {};
  Color _backgroundColor = const Color(0xFFFAEBD7);

  void _startGame() {
    if (!_started) {
      setState(() {
        _started = true;
        _level = 0;
        _gameSequence.clear();
        _userSequence.clear();
        _backgroundColor = const Color(0xFFFAEBD7);
        _statusMessage = "Level 1";
      });
      _levelUp();
    }
  }

  void _levelUp() {
    setState(() {
      _userSequence.clear();
      _level++;
      _statusMessage = "Level $_level";
      _gameSequence.add(_colors[Random().nextInt(4)]);
    });
    _playSequence();
  }

  Future<void> _playSequence() async {
    String currentColor = _gameSequence.last;
    await _flashButton(currentColor);
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _flashButton(String color) async {
    setState(() {
      _flashingButtons.add(color);
    });
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      _flashingButtons.remove(color);
    });
  }

  void _checkInput(String color) {
    _userSequence.add(color);

    if (_userSequence[_userSequence.length - 1] !=
        _gameSequence[_userSequence.length - 1]) {
      _endGame();
      return;
    }

    if (_userSequence.length == _gameSequence.length) {
      setState(() {
        if (_level > _highestScore) _highestScore = _level;
      });
      Future.delayed(const Duration(seconds: 1), _levelUp);
    }
  }

  void _endGame() {
    setState(() {
      _statusMessage = "Wrong Press! Score: $_level\nPress Start to Restart";
      _backgroundColor = Colors.red;
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _backgroundColor = const Color(0xFFFAEBD7);
        });
      });
      _started = false;
      _gameSequence.clear();
      _userSequence.clear();
      _level = 0;
    });
  }

  Widget _buildButton(String color) {
    final isFlashing = _flashingButtons.contains(color);
    return GestureDetector(
      onTap: _started ? () => _checkInput(color) : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isFlashing
              ? (color == 'red'
                  ? Colors.redAccent
                  : color == 'blue'
                      ? Colors.lightBlueAccent
                      : color == 'green'
                          ? Colors.lightGreenAccent
                          : Colors.deepPurpleAccent)
              : (color == 'red'
                  ? Colors.red
                  : color == 'blue'
                      ? Colors.blue
                      : color == 'green'
                          ? Colors.green
                          : Colors.purple),
          border: Border.all(color: Colors.black, width: 4),
          borderRadius: BorderRadius.only(
            topLeft: color == 'red' ? const Radius.circular(100) : Radius.zero,
            topRight:
                color == 'blue' ? const Radius.circular(100) : Radius.zero,
            bottomLeft:
                color == 'green' ? const Radius.circular(100) : Radius.zero,
            bottomRight:
                color == 'purple' ? const Radius.circular(100) : Radius.zero,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonSize =
        MediaQuery.of(context).size.width / 5; // Adjust button size dynamically
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Simon Says Game",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            "Highest Score: $_highestScore",
            style: const TextStyle(fontSize: 20, color: Colors.black54),
          ),
          const SizedBox(height: 20),
          Text(
            _statusMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.fromLTRB(80.0, 0.0, 80.0, 60.0),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: _colors.map((color) {
                return SizedBox(
                  width: buttonSize,
                  height: buttonSize,
                  child: _buildButton(color),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startGame,
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
