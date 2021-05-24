import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:rd_health/providers/auth.dart';
import 'package:rd_health/screens/home_screen.dart';
import 'package:rd_health/screens/auth_screen.dart';
import 'package:rd_health/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        // ChangeNotifierProxyProvider<Auth, Tours>(
        //     create: null,
        //     update: (ctx, auth, previousTours) {
        //       if(previousTours != null && auth.token != null) {
        //         previousTours.setToken(auth.token);
        //         return previousTours;
        //       }
        //       return Tours(auth.token);
        //     }),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'RD Health',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? HomeScreen()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx, authResultSnapshot) =>
            authResultSnapshot.connectionState ==
                ConnectionState.waiting
                ? SplashScreen()
                : auth.isAuth
                ? HomeScreen()
                : AuthScreen(),
          ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
        ),
      ),
    );
  }
}
