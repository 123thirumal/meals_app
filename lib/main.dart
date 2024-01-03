import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals_app/screens/starting_screen.dart';

var kDarkColorScheme=ColorScheme.fromSeed(
  brightness: Brightness.dark,
    seedColor: const Color(0xFC13204F),
);

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    child: MaterialApp(


      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        textTheme: TextTheme(
          titleLarge:GoogleFonts.robotoCondensed(fontSize: 20),
          bodyMedium: GoogleFonts.robotoCondensed(fontSize: 20),
        ),
      ),

      themeMode: ThemeMode.dark,


      home: StartingScreen(),
      ),
  ),
  );
}