import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/telas/tela_cadastro.dart';
import 'package:smartbusserra/user_data.dart';
import 'package:intl/intl.dart';

class HomeAluno extends StatefulWidget {
  final String cidadeAluno;

  const HomeAluno({super.key, required this.cidadeAluno});

  @override
  _HomeAlunoState createState() => _HomeAlunoState();
}

class _HomeAlunoState extends State<HomeAluno> {
  late String dataAtual;
  int onibusSelecionado = -1;

  final List<Map<String, String>> listaOnibus = [
    {'rota': 'Brasil Novo', 'hora': '06:30'},
    {'rota': 'Brasil Novo', 'hora': '07:00'},
    {'rota': 'Vitória do Xingu', 'hora': '06:40'},
    {'rota': 'Medicilândia', 'hora': '06:20'},
  ];

  @override
  void initState() {
    super.initState();
    dataAtual = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    final onibusFiltrados = listaOnibus
        .where((onibus) => onibus['rota'] == widget.cidadeAluno)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home - Aluno'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data de hoje: $dataAtual',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Ônibus disponíveis para ${widget.cidadeAluno}:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Expanded(
              child: onibusFiltrados.isEmpty
                  ? Center(child: Text('Nenhum ônibus disponível para hoje.'))
                  : ListView.builder(
                      itemCount: onibusFiltrados.length,
                      itemBuilder: (context, index) {
                        final onibus = onibusFiltrados[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              onibusSelecionado = index;
                            });
                          },
                          child: Card(
                            color: onibusSelecionado == index
                                ? Colors.pink[50]
                                : Colors.white,
                            elevation: 4,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Text('Ônibus - ${onibus['rota']}'),
                              subtitle:
                                  Text('Horário de saída: ${onibus['hora']}'),
                              trailing: Icon(Icons.directions_bus),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            if (onibusSelecionado != -1) ...[
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Presença marcada com sucesso!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Marcar minha presença"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (onibusSelecionado < onibusFiltrados.length - 1) {
                      onibusSelecionado++;
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Não há mais ônibus disponíveis.')),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text("Pular para o próximo ônibus"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
