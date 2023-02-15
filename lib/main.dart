import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kori_proto/screens/IntroScreen.dart';
import 'package:kori_proto/screens/MainScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KORi-Z Robot App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff191919),
        textTheme: TextTheme(

          //영어폰트용
          titleLarge:
              GoogleFonts.roboto(color: Color(0xffF0F0F0), fontSize: 45),
          titleMedium:
              GoogleFonts.roboto(color: Color(0xffB7B7B7), fontSize: 32),
          bodyLarge: GoogleFonts.roboto(color: Color(0xffB7B7B7), fontSize: 28),
          bodyMedium:
              GoogleFonts.roboto(color: Color(0xffB7B7B7), fontSize: 24),
          bodySmall: GoogleFonts.roboto(color: Color(0xffB7B7B7), fontSize: 20),


          //한글폰트용
          displayLarge:
          GoogleFonts.notoSans(color: Color(0xffF0F0F0), fontSize: 160),
          displayMedium:
              GoogleFonts.notoSans(color: Color(0xffB7B7B7), fontSize: 100),
          displaySmall:GoogleFonts.notoSans(color: Color(0xffB7B7B7), fontSize: 20),
          headlineLarge:
              GoogleFonts.notoSans(color: Color(0xffB7B7B7), fontSize: 24),
          headlineMedium: GoogleFonts.notoSans(color: Color(0xffB7B7B7), fontSize: 20),
        ),
      ),
      home: IntroScreen(),
    );
  }
}
