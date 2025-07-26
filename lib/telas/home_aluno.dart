import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/user_data.dart';
import 'package:smartbusserra/telas/perfil_page.dart';

class HomeAluno extends StatefulWidget {
  final String cidadeAluno;

  const HomeAluno({required this.cidadeAluno});

  @override
  _HomeAlunoState createState() => _HomeAlunoState();
}

class _HomeAlunoState extends State<HomeAluno> {
  final List<Map<String, dynamic>> onibusDisponiveis = [
    {
      'onibus': 'Ônibus 1',
      'placa': 'ABC-1234',
      'motorista': 'José da Silva',
      'saida': '07:00',
      'chegada': '08:30',
      'status': 'ativo',
      'presencaConfirmada': false,
    },
    {
      'onibus': 'Ônibus 2',
      'placa': 'XYZ-5678',
      'motorista': 'Maria Oliveira',
      'saida': '12:00',
      'chegada': '13:30',
      'status': 'inativo',
      'presencaConfirmada': false,
    },
    {
      'onibus': 'Ônibus 3',
      'placa': 'DEF-9012',
      'motorista': 'Carlos Souza',
      'saida': '09:00',
      'chegada': '10:30',
      'status': 'ativo',
      'presencaConfirmada': false,
    },
    {
      'onibus': 'Ônibus 4',
      'placa': 'GHI-3456',
      'motorista': 'Ana Paula',
      'saida': '14:00',
      'chegada': '15:30',
      'status': 'ativo',
      'presencaConfirmada': false,
    },
    {
      'onibus': 'Ônibus 5',
      'placa': 'JKL-7890',
      'motorista': 'Roberto Alves',
      'saida': '16:00',
      'chegada': '17:30',
      'status': 'inativo',
      'presencaConfirmada': false,
    },
    {
      'onibus': 'Ônibus 6',
      'placa': 'MNO-1234',
      'motorista': 'Fernanda Lima',
      'saida': '18:00',
      'chegada': '19:30',
      'status': 'ativo',
      'presencaConfirmada': false,
    },
  ];

  void confirmarPresenca(int index) {
    bool jaConfirmado =
        onibusDisponiveis.any((onibus) => onibus['presencaConfirmada'] == true);

    if (jaConfirmado) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Você já confirmou presença em outro ônibus!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      onibusDisponiveis[index]['presencaConfirmada'] = true;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Presença confirmada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  void cancelarPresenca(int index) {
    setState(() {
      onibusDisponiveis[index]['presencaConfirmada'] = false;
    });
  }

  Future<void> _abrirPerfil() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PerfilPage()),
    );
    setState(() {}); // Atualiza a tela quando voltar
  }

  void _sair() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  Widget _buildUserInfoCard() {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: UserData.imagemPerfil != null
                  ? FileImage(File(UserData.imagemPerfil!))
                  : null,
              child: UserData.imagemPerfil == null
                  ? Icon(Icons.person, size: 30, color: Colors.pinkAccent)
                  : null,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    UserData.nome ?? 'Nome do Aluno',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    UserData.email ?? 'email@aluno.com',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Cidade: ${UserData.cidade ?? 'Não informada'}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dataAtual = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        title: Text('Painel do Aluno'),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (value) {
              if (value == 'perfil') {
                _abrirPerfil();
              } else if (value == 'sair') {
                _sair();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'perfil',
                  child: Text('Alterar Perfil'),
                ),
                PopupMenuItem<String>(
                  value: 'sair',
                  child: Text('Sair'),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Card com informações do usuário
          _buildUserInfoCard(),

          // Lista de ônibus
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ônibus disponíveis hoje",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD81B60),
                    ),
                  ),
                  Text("Data: $dataAtual",
                      style: TextStyle(color: Colors.black54)),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: onibusDisponiveis.length,
                      itemBuilder: (context, index) {
                        final onibus = onibusDisponiveis[index];
                        final bool isAtivo = onibus['status'] == 'ativo';

                        return Card(
                          elevation: 3,
                          margin:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${onibus['onibus']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: isAtivo
                                            ? Colors.green
                                            : Colors.grey,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        isAtivo ? 'ATIVO' : 'INATIVO',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text("Placa: ${onibus['placa']}",
                                    style: TextStyle(color: Colors.black54)),
                                Text("Motorista: ${onibus['motorista']}",
                                    style: TextStyle(color: Colors.black54)),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 16, color: Colors.black54),
                                    SizedBox(width: 4),
                                    Text("Saída: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87)),
                                    Text(
                                      "${onibus['saida']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFD81B60),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 16, color: Colors.black54),
                                    SizedBox(width: 4),
                                    Text("Chegada: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87)),
                                    Text(
                                      "${onibus['chegada']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFD81B60),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: !isAtivo ||
                                              onibus['presencaConfirmada']
                                          ? null
                                          : () => confirmarPresenca(index),
                                      child: Text("Confirmar Presença"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFD81B60),
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: onibus['presencaConfirmada']
                                          ? () => cancelarPresenca(index)
                                          : null,
                                      child: Text("Cancelar"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
