import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_favorite_places/navigation/navigation_bar_provider.dart';
import 'package:my_favorite_places/authentication/auth_screen.dart';
import 'package:my_favorite_places/navigation/navigation_bar_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'places/my_fav_places.dart';

import 'package:my_favorite_places/places/country_selection_screen.dart';
import 'package:my_favorite_places/places/place_detail_screen.dart';
import 'package:my_favorite_places/users/user_settings_screen.dart';

import 'places/places_list_screen.dart';
import 'places/add_place_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(JourneyJar());
}

class JourneyJar extends StatelessWidget {
  final Color primaryColor = const Color.fromRGBO(37, 52, 71, 1);
  final Color secondaryColor = const Color.fromRGBO(196, 216, 226, 1);
  final Color accentColor = const Color.fromRGBO(255, 168, 0, 1);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MyFavoritePlaces(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => NavigationBarProvider(),
        )
      ],
      child: MaterialApp(
        title: "JourneyJar",
        theme: ThemeData(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodyLarge: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            bodyMedium: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            bodySmall: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
          colorScheme: ColorScheme(
            primary: primaryColor,
            primaryContainer: Colors.black,
            secondary: secondaryColor,
            secondaryContainer: Colors.black54,
            surface: secondaryColor,
            background: secondaryColor,
            error: Colors.red,
            onPrimary: Colors.white,
            onSecondary: Colors.black,
            onSurface: Colors.black,
            onBackground: Colors.black,
            onError: Colors.white,
            brightness: Brightness.light,
          ),
          appBarTheme: AppBarTheme(
            color: primaryColor,
          ),
        ),
        home: AnimatedSplashScreen(
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.fade,
          animationDuration: const Duration(milliseconds: 1000),
          duration: 1200,
          curve: Curves.easeIn,
          splash: Image.asset('assets/images/splash_photo.png'),
          nextScreen: StreamBuilder(
            stream: _auth.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const NavigationBarScreen();
              } else {
                return const AuthScreen();
              }
            },
          ),
        ),
        routes: {
          PlacesListScreen.routeName: (ctx) => PlacesListScreen(),
          AddPlaceScreen.routeName: (ctx) => const AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
          CountrySelectionScreen.routeName: (ctx) => CountrySelectionScreen(),
          UserSettingsScreen.routeName: (ctx) => const UserSettingsScreen(),
          AuthScreen.routeName: (ctx) => const AuthScreen(),
          NavigationBarScreen.routeName: (ctx) => const NavigationBarScreen(),
        },
      ),
    );
  }
}
