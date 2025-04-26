import 'package:bot_toast/bot_toast.dart';
import 'package:dog_breeds/providers/app_provider.dart';
import 'package:dog_breeds/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<AppProvider>(context, listen: true).darkMode;
    return MaterialApp(
      title: 'Dog Breeds',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          foregroundColor: isDarkMode ? Colors.white : Colors.black,
          color: isDarkMode ? Colors.black : Colors.white,
          iconTheme: IconThemeData(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
        ),
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          bodyMedium: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          titleMedium: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          titleLarge: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          titleSmall: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          bodySmall: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          labelLarge: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomeScreen(),
    );
  }
}
