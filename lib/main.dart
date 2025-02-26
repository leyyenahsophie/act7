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
      home: DefaultTabController (
        length: 2,
        child: HomeScreen(toggleTheme: toggleTheme),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({Key? key, required this.toggleTheme}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{
  bool _isVisible = true; // Controls text visibility
  Color pickerColor = Colors.black; // Default text color
  Color textColor = const Color(0xff443a49); // Initial text color
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController =TabController(length: 2, vsync:this);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

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

  Widget buildAnimatedTab(String text, Duration duration) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: duration,
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
        const SizedBox(height: 20),
        BlockPicker(
          pickerColor: textColor,
          onColorChanged: changeColor,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fading Text Animation"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Animation 1"),
            Tab(text: "Animation 2"),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleTheme, // Toggle light/dark mode
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // First tab: "Hello, Flutter!" with 1-second duration
          buildAnimatedTab("Hello, Flutter!", const Duration(seconds: 1)),
          // Second tab: "Goodbye, Flutter!" with 3-second duration
          buildAnimatedTab("Goodbye, Flutter!", const Duration(seconds: 3)),
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
