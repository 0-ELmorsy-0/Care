import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'presentation/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // تهيئة اتصال فايربيس بشكل آمن
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase Initialization Warning: $e');
  }

  runApp(
    // تغليف التطبيق بـ ProviderScope لتمكين Riverpod
    const ProviderScope(
      child: ELmorsyCareApp(),
    ),
  );
}

class ELmorsyCareApp extends StatelessWidget {
  const ELmorsyCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ELmorsy Care',
      debugShowCheckedModeBanner: false,
      
      // دعم اللغة العربية والـ RTL بشكل تلقائي
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [
        Locale('ar', 'EG'), // العربية - مصر
        Locale('en', 'US'), // الإنجليزية (اختياري)
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // التصميم الثيم الطبي (Blue & Green)
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
        primaryColor: const Color(0xFF2A7FFF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2A7FFF),
          primary: const Color(0xFF2A7FFF),
          secondary: const Color(0xFF28C76F),
          background: const Color(0xFFFAFAFA),
        ),
        
        // تطبيق الخط العربي الأنيق (Cairo أو Tajawal)
        textTheme: GoogleFonts.cairoTextTheme(
          Theme.of(context).textTheme,
        ).copyWith(
          displayLarge: GoogleFonts.cairo(fontWeight: FontWeight.bold),
          titleLarge: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 18),
          bodyMedium: GoogleFonts.cairo(fontSize: 14),
        ),
        
        // الإعدادات الافتراضية للكروت وللبطاقات براديوس 12-16
        cardTheme: CardTheme(
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
