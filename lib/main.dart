import 'package:flutter/material.dart';
import 'telas/tela_login.dart';
import 'telas/tela_cadastro.dart';
import 'package:smartbusserra/telas/home_aluno.dart';
import 'package:smartbusserra/telas/home_coord.dart';
import 'package:smartbusserra/telas/home_motorista.dart';
import 'package:smartbusserra/user_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Mantemos a tela de login como inicial
    );
  }
}
