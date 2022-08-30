import 'package:flutter/material.dart';
import 'package:projectchat/Providers/loginprovider.dart';
import 'package:projectchat/Screens/LoginScreen/main.dart';
import 'package:projectchat/Screens/OnboardingScreen/main.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => LoginProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
        routes: {},
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SafeArea(child: LoginScreen()),
      );
    });
  }
}
