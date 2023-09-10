import 'package:election_dapp/Provider/election_provider.dart';
import 'package:election_dapp/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LifeMeaningProvider lmp = new LifeMeaningProvider(context);
    return ChangeNotifierProvider(
      create: (_) => LifeMeaningProvider(context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.deepPurple
          ),

          home: MyHomePage(),
      ),
    );
  }
}

