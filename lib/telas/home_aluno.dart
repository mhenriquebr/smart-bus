import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/user_data.dart';
import 'package:smartbusserra/telas/perfil_page.dart';

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

  final TextEditingController _telefoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _telefoneController.text = UserData.telefone ?? '';
  }

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
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (UserData.imagemPerfil != null)
                CircleAvatar(
                  backgroundImage: FileImage(File(UserData.imagemPerfil!)),
                  radius: 40,
                ),
              SizedBox(height: 10),
              TextField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: "Telefone"),
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _alterarFotoPerfil,
                child: Text("Alterar Foto de Perfil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                UserData.telefone = _telefoneController.text;
              });
              Navigator.pop(context);
            },
            child: Text("Salvar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void _alterarFotoPerfil() async {
    final picker = ImagePicker();
    final XFile? imagemSelecionada =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        UserData.imagemPerfil = imagemSelecionada.path;
      });
    }
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
              if (value == 'perfil') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PerfilPage()),
                );
              }
              if (value == 'sair') Navigator.pop(context);
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'perfil', child: Text('Perfil')),
              PopupMenuItem(value: 'sair', child: Text('Sair')),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (UserData.imagemPerfil != null || UserData.telefone != null)
              Row(
                children: [
                  if (UserData.imagemPerfil != null)
                    CircleAvatar(
                      backgroundImage: FileImage(File(UserData.imagemPerfil!)),
                      radius: 25,
                    ),
                  if (UserData.telefone != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Telefone: ${UserData.telefone}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                ],
              ),
            SizedBox(height: 20),
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
