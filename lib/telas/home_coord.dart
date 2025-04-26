import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/telas/tela_cadastro.dart';

class HomeCoordenacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Área da Coordenação'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
        child: Text(
          'Bem-vindo, Coordenação!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
