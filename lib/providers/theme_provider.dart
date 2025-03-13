import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;
  final String _themeKey = 'isDarkMode';

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  // Load saved theme preference
  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? true; // Default to dark mode
    notifyListeners();
  }

  // Save theme preference
  Future<void> _saveThemeToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
  }

  // Toggle theme
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveThemeToPrefs();
    notifyListeners();
  }

  // Get current theme
  ThemeData get themeData {
    return _isDarkMode ? darkTheme : lightTheme;
  }

  // Dark theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color.fromARGB(255, 243, 109, 201),
    scaffoldBackgroundColor: const Color.fromARGB(255, 24, 22, 47),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        color: Colors.grey,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color.fromARGB(255, 243, 109, 201),
      secondary: Color.fromARGB(255, 243, 109, 201),
      surface: Color.fromARGB(255, 37, 38, 66),
      background: Color.fromARGB(255, 24, 22, 47),
    ),
    cardColor: Colors.black.withOpacity(0.3),
    dividerColor: Colors.white24,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );

  // Light theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color.fromARGB(255, 243, 109, 201),
    scaffoldBackgroundColor: const Color.fromARGB(255, 245, 245, 250),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Color.fromARGB(255, 60, 60, 80)),
      titleTextStyle: TextStyle(
        color: Color.fromARGB(255, 60, 60, 80),
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: Color.fromARGB(255, 60, 60, 80),
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        color: Color.fromARGB(255, 60, 60, 80),
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        color: Color.fromARGB(255, 60, 60, 80),
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        color: Color.fromARGB(255, 60, 60, 80),
      ),
      bodyMedium: TextStyle(
        color: Color.fromARGB(255, 120, 120, 140),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color.fromARGB(255, 243, 109, 201),
      secondary: Color.fromARGB(255, 243, 109, 201),
      surface: Colors.white,
      background: Color.fromARGB(255, 245, 245, 250),
    ),
    cardColor: Colors.white,
    dividerColor: Colors.black12,
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 60, 60, 80),
    ),
  );
}
