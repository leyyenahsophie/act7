import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system; // Default theme mode

  void toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, brightness: Brightness.light),
      darkTheme: ThemeData(useMaterial3: true, brightness: Brightness.dark),
      themeMode: _themeMode,
      home: HomeScreen(toggleTheme: toggleTheme),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _FadingTextAnimationState extends State<FadingTextAnimation> {
  bool _isVisible = true;
  Color pickerColor = Colors.black;
  Color textColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
      textColor = pickerColor;
    });
  }

  void toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fading Text Animation"),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleTheme, // Toggle light/dark mode
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                'Hello, Flutter!',
                style: TextStyle(fontSize: 24, color: textColor),
              ),
            ),
          ),
          SizedBox(height: 20),
          BlockPicker(
          pickerColor: textColor, 
          onColorChanged: changeColor,
          ),
        ],
        
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: toggleVisibility, // Toggle fading text
            tooltip: 'Fade Text',
            child: const Icon(Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: widget.toggleTheme, // Toggle theme
            tooltip: 'Toggle Theme',
            child: const Icon(Icons.brightness_6),
          ),
        ],
      ),
    );
  }
}
