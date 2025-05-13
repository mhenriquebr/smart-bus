import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/user_data.dart';
import 'package:intl/intl.dart';

class HomeAluno extends StatefulWidget {
  final String cidadeAluno;

  HomeAluno({required this.cidadeAluno});

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
      'presencaConfirmada': false,
    },
    {
      'onibus': 'Ônibus 2',
      'placa': 'XYZ-5678',
      'motorista': 'Maria Oliveira',
      'saida': '12:00',
      'chegada': '13:30',
      'presencaConfirmada': false,
    },
  ];

  void confirmarPresenca(int index) {
    setState(() {
      onibusDisponiveis[index]['presencaConfirmada'] = true;
    });
  }

  void cancelarPresenca(int index) {
    setState(() {
      onibusDisponiveis[index]['presencaConfirmada'] = false;
    });
  }

  void abrirPerfil() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Editar Perfil"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: InputDecoration(labelText: "Telefone")),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // lógica para selecionar imagem
              },
              child: Text("Alterar Foto de Perfil"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fechar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String dataAtual = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Center(child: Text('Smart Bus Serra')),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'perfil') abrirPerfil();
              if (value == 'sair') Navigator.pop(context);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'perfil',
                child: Text('Perfil'),
              ),
              PopupMenuItem(
                value: 'sair',
                child: Text('Sair'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ônibus disponíveis hoje",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Data: $dataAtual"),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: onibusDisponiveis.length,
                itemBuilder: (context, index) {
                  final onibus = onibusDisponiveis[index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${onibus['onibus']}",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Placa: ${onibus['placa']}"),
                          Text("Motorista: ${onibus['motorista']}"),
                          Text("Horário de saída: ${onibus['saida']}"),
                          Text("Previsão de chegada: ${onibus['chegada']}"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: onibus['presencaConfirmada']
                                    ? null
                                    : () => confirmarPresenca(index),
                                child: Text("Confirmar Presença"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: onibus['presencaConfirmada']
                                    ? () => cancelarPresenca(index)
                                    : null,
                                child: Text("Cancelar Presença"),
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
    );
  }
}
