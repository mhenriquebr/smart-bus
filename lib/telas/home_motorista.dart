import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/user_data.dart';
import 'package:smartbusserra/telas/perfil_page.dart';
import 'dart:math';

class HomeMotorista extends StatefulWidget {
  const HomeMotorista({Key? key}) : super(key: key);

  @override
  _HomeMotoristaState createState() => _HomeMotoristaState();
}

class _HomeMotoristaState extends State<HomeMotorista> {
  // Lista de ônibus disponíveis
  final List<Map<String, dynamic>> onibusDisponiveis = [
    {
      'onibus': 'Ônibus 1',
      'placa': 'ABC-1234',
      'motorista': 'José da Silva',
      'saida': '07:00',
      'chegada': '08:30',
      'status': 'inativo',
      'alunosConfirmados': [],
    },
    {
      'onibus': 'Ônibus 2',
      'placa': 'XYZ-5678',
      'motorista': 'Maria Oliveira',
      'saida': '12:00',
      'chegada': '13:30',
      'status': 'inativo',
      'alunosConfirmados': [],
    },
    {
      'onibus': 'Ônibus 3',
      'placa': 'DEF-9012',
      'motorista': 'Carlos Souza',
      'saida': '09:00',
      'chegada': '10:30',
      'status': 'inativo',
      'alunosConfirmados': [],
    },
    {
      'onibus': 'Ônibus 4',
      'placa': 'GHI-3456',
      'motorista': 'Ana Paula',
      'saida': '14:00',
      'chegada': '15:30',
      'status': 'inativo',
      'alunosConfirmados': [],
    },
    {
      'onibus': 'Ônibus 5',
      'placa': 'JKL-7890',
      'motorista': 'Roberto Alves',
      'saida': '16:00',
      'chegada': '17:30',
      'status': 'inativo',
      'alunosConfirmados': [],
    },
    {
      'onibus': 'Ônibus 6',
      'placa': 'MNO-1234',
      'motorista': 'Fernanda Lima',
      'saida': '18:00',
      'chegada': '19:30',
      'status': 'inativo',
      'alunosConfirmados': [],
    },
  ];

  int? onibusAtivoIndex;

  @override
  void initState() {
    super.initState();
    _carregarDadosUsuario();
  }

  void _carregarDadosUsuario() {
    if (UserData.cidade == null) {
      final cadastro = cadastrosRecebidos.firstWhere(
        (cadastro) => cadastro.email == UserData.email,
        orElse: () => CadastroUsuario(
          tipo: '',
          cidade: 'Não informada',
          nome: UserData.nome ?? 'Motorista',
          cpf: '',
          email: UserData.email ?? '',
          emailDestino: '',
        ),
      );
      UserData.cidade = cadastro.cidade;
    }
  }

  void _alternarStatusOnibus(int index) {
    if (onibusAtivoIndex != null && onibusAtivoIndex != index) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Você já ativou um ônibus. Desative-o para ativar outro.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      if (onibusDisponiveis[index]['status'] == 'ativo') {
        onibusDisponiveis[index]['status'] = 'inativo';
        onibusAtivoIndex = null;
      } else {
        onibusDisponiveis[index]['status'] = 'ativo';
        onibusAtivoIndex = index;
      }
    });
  }

  Future<void> _abrirPerfil() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PerfilPage()),
    );
    setState(() {});
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
                    UserData.nome ?? 'Nome do Motorista',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    UserData.email ?? 'email@motorista.com',
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

  List<Map<String, String>> _gerarAlunosFicticios() {
    final nomes = [
      'Ana',
      'Bruno',
      'Carlos',
      'Daniela',
      'Eduardo',
      'Fernanda',
      'Gustavo',
      'Helena',
      'Igor',
      'Julia'
    ];
    final sobrenomes = [
      'Silva',
      'Oliveira',
      'Souza',
      'Lima',
      'Costa',
      'Pereira',
      'Santos',
      'Almeida',
      'Rodrigues',
      'Ferreira'
    ];

    final random = Random();
    final quantidade = random.nextInt(5) + 3;

    return List.generate(quantidade, (index) {
      final nome = nomes[random.nextInt(nomes.length)];
      final sobrenome = sobrenomes[random.nextInt(sobrenomes.length)];
      return {
        'nome': '$nome $sobrenome',
        'email': '${nome.toLowerCase()}.${sobrenome.toLowerCase()}@gmail.com'
      };
    });
  }

  void _mostrarAlunosConfirmados(int index) {
    final alunos = onibusDisponiveis[index]['alunosConfirmados'].isEmpty
        ? _gerarAlunosFicticios()
        : onibusDisponiveis[index]['alunosConfirmados'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text("Alunos Confirmados - ${onibusDisponiveis[index]['onibus']}"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (alunos.isEmpty)
                Text("Nenhum aluno confirmado ainda")
              else
                ...alunos
                    .map((aluno) => ListTile(
                          leading: Icon(Icons.person, color: Colors.pinkAccent),
                          title: Text(aluno['nome']),
                          subtitle: Text(aluno['email']),
                        ))
                    .toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fechar", style: TextStyle(color: Colors.pinkAccent)),
          ),
        ],
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
        title: Text('Painel do Motorista'),
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
          _buildUserInfoCard(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Selecione seu ônibus",
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
                          color: isAtivo ? Colors.grey[100] : Colors.white,
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
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
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: isAtivo
                                                ? Colors.green
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            isAtivo ? 'ATIVO' : 'INATIVO',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "${onibus['alunosConfirmados'].length} alunos",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                Text("Placa: ${onibus['placa']}"),
                                Text("Motorista: ${onibus['motorista']}"),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 16, color: Colors.black54),
                                    SizedBox(width: 4),
                                    Text("Saída: ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${onibus['saida']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pinkAccent,
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
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "${onibus['chegada']}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pinkAccent,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          _mostrarAlunosConfirmados(index),
                                      child: Text("Ver Alunos"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueGrey,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () =>
                                          _alternarStatusOnibus(index),
                                      child: Text(
                                          isAtivo ? "Desativar" : "Ativar"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: isAtivo
                                            ? Color(0xFFD81B60)
                                            : Colors.green,
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
