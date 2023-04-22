import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:my_favorite_places/providers/navigation_bar_provider.dart';
import 'package:my_favorite_places/screens/auth_screen.dart';
import 'package:my_favorite_places/screens/navigation_bar_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './providers/my_fav_places.dart';

import 'package:my_favorite_places/helpers/auth.dart';
import 'package:my_favorite_places/screens/country_selection_screen.dart';
import 'package:my_favorite_places/screens/place_detail_screen.dart';
import 'package:my_favorite_places/screens/user_settings_screen.dart';

import '../screens/places_list_screen.dart';
import '../screens/add_place_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyFavPlaces());
}

class MyFavPlaces extends StatelessWidget {
  final Color primaryColor = Color.fromRGBO(37, 52, 71, 1);
  final Color secondaryColor = Color.fromRGBO(196, 216, 226, 1);
  final Color accentColor = Color.fromRGBO(255, 168, 0, 1);

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
            stream: Auth().authStateChanges,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const NavigationBarScreen();
              } else {
                return AuthScreen();
              }
            },
          ),
        ),
        routes: {
          PlacesListScreen.routeName: (ctx) => PlacesListScreen(),
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
          CountrySelectionScreen.routeName: (ctx) => CountrySelectionScreen(),
          UserSettingsScreen.routeName: (ctx) => UserSettingsScreen(),
          AuthScreen.routeName: (ctx) => AuthScreen(),
          NavigationBarScreen.routeName: (ctx) => NavigationBarScreen(),
        },
      ),
    );
  }
}