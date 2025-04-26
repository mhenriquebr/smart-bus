import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/telas/tela_cadastro.dart';

class HomeMotorista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Área do Motorista'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Text(
          'Bem-vindo, Motorista!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
