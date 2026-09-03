import 'package:flogin_rive_animation/screen/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  //De cajon
  runApp(
    const MyApp(),
  ); //Ejecuta la clase MyApp que es la que contiene el diseño de la app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override //Sobre escritura
  Widget build(BuildContext context) {
    //context: te dice donde estas situado
    return MaterialApp(
      //estilo Android
      title: 'Flutter Demo',
      theme: ThemeData(
        //paleta de colores
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    );
  }
}
