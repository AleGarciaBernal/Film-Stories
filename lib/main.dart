import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_stories/responsive/mobile_screen_layout.dart';
import 'package:movie_stories/responsive/responsive_layout_screen.dart';
import 'package:movie_stories/responsive/web_screen_layout.dart';
import 'package:movie_stories/screens/loginScreen.dart';
import 'package:movie_stories/screens/signupScreen.dart';
import 'package:movie_stories/utils/colors.dart';
import 'package:movie_stories/responsive/responsive_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCPkz1NbKaPbm0TbadPPxks_luf7y9M2hQ',
          appId: '1:1071467755265:web:267368f7559988c1e98d00',
          messagingSenderId: '1071467755265',
          projectId: 'film-stories',
          storageBucket: 'film-stories.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //quitar el banner de "debug"
      title: 'Film Stories', //nombre de la aplicacion
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: webBackgroundColor,
      ),
      //poner un tema
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: primaryColor,
            ));
          }
          return const SignupScreen();
        },
      ),

//      ),
    );
  }
}
