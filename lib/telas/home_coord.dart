import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/user_data.dart';

class HomeCoordenador extends StatefulWidget {
  @override
  _HomeCoordenadorState createState() => _HomeCoordenadorState();
}

class _HomeCoordenadorState extends State<HomeCoordenador> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _reclamacoes = [
    {
      'id': 1,
      'aluno': 'João Silva',
      'onibus': 'ABC-1234',
      'data': '10/05/2023',
      'descricao': 'Ônibus atrasou 30 minutos',
      'status': 'Pendente'
    },
    {
      'id': 2,
      'aluno': 'Maria Souza',
      'onibus': 'XYZ-5678',
      'data': '11/05/2023',
      'descricao': 'Motorista muito rápido',
      'status': 'Resolvida'
    }
  ];

  final List<Map<String, dynamic>> _atrasos = [
    {
      'onibus': 'ABC-1234',
      'motorista': 'José da Silva',
      'data': '10/05/2023',
      'atraso': '25 minutos',
      'rota': 'Brasil Novo - Campus'
    },
    {
      'onibus': 'DEF-9012',
      'motorista': 'Ana Oliveira',
      'data': '11/05/2023',
      'atraso': '15 minutos',
      'rota': 'Vitória do Xingu - Campus'
    }
  ];

  final _formKey = GlobalKey<FormState>();
  String _tipoUsuario = 'Aluno';
  String _cidade = 'Brasil Novo';
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _abrirFormularioCadastro() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cadastrar Novo Usuário',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD81B60),
                      ),
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<String>(
                      value: _tipoUsuario,
                      decoration: InputDecoration(
                        labelText: 'Tipo de Usuário',
                        border: OutlineInputBorder(),
                      ),
                      items: ['Aluno', 'Motorista', 'Coordenador']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _tipoUsuario = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: _cidade,
                      decoration: InputDecoration(
                        labelText: 'Cidade',
                        border: OutlineInputBorder(),
                      ),
                      items: [
                        'Brasil Novo',
                        'Vitória do Xingu',
                        'Medicilândia',
                        'Anapú'
                      ].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _cidade = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _nomeController,
                      decoration: InputDecoration(
                        labelText: 'Nome Completo',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _cpfController,
                      decoration: InputDecoration(
                        labelText: 'CPF',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o CPF';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-mail',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o e-mail';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Lógica para cadastrar usuário
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Usuário cadastrado com sucesso!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                          _nomeController.clear();
                          _cpfController.clear();
                          _emailController.clear();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD81B60),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: Text(
                        'Cadastrar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _consultarUsuarios() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Consulta de Usuários'),
        content: Text('Não temos usuários cadastrados no momento.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: Color(0xFFD81B60))),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatorioCard(
      String title, IconData icon, String value, Color color) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAtrasoItem(Map<String, dynamic> atraso) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(Icons.access_time, color: Colors.red),
        title: Text('Ônibus ${atraso['onibus']} - ${atraso['rota']}'),
        subtitle: Text(
            'Motorista: ${atraso['motorista']}\nData: ${atraso['data']} - Atraso: ${atraso['atraso']}'),
      ),
    );
  }

  Widget _buildReclamacaoItem(Map<String, dynamic> reclamacao) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: ListTile(
        leading: Icon(
          reclamacao['status'] == 'Pendente'
              ? Icons.warning
              : Icons.check_circle,
          color:
              reclamacao['status'] == 'Pendente' ? Colors.orange : Colors.green,
        ),
        title: Text('Reclamação #${reclamacao['id']} - ${reclamacao['aluno']}'),
        subtitle: Text(
            'Ônibus ${reclamacao['onibus']}\nData: ${reclamacao['data']}\n${reclamacao['descricao']}'),
        trailing: Chip(
          label: Text(reclamacao['status']),
          backgroundColor: reclamacao['status'] == 'Pendente'
              ? Colors.orange.withOpacity(0.2)
              : Colors.green.withOpacity(0.2),
          labelStyle: TextStyle(
            color: reclamacao['status'] == 'Pendente'
                ? Colors.orange
                : Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _buildRelatorios() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Text(
              'Relatórios',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD81B60),
              ),
            ),
          ),
          _buildRelatorioCard(
            'Atrasos na Saída',
            Icons.access_time,
            _atrasos.length.toString(),
            Color(0xFFD81B60),
          ),
          _buildRelatorioCard(
            'Reclamações Pendentes',
            Icons.report_problem,
            _reclamacoes
                .where((r) => r['status'] == 'Pendente')
                .length
                .toString(),
            Colors.orange,
          ),
          _buildRelatorioCard(
            'Total de Usuários',
            Icons.people,
            '143',
            Colors.blue,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Últimos Atrasos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ..._atrasos
              .take(3)
              .map((atraso) => _buildAtrasoItem(atraso))
              .toList(),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Últimas Reclamações',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ..._reclamacoes
              .take(3)
              .map((reclamacao) => _buildReclamacaoItem(reclamacao))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildCadastroUsuarios() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_add,
            size: 80,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 20),
          Text(
            'Cadastre novos usuários',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _abrirFormularioCadastro,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFD81B60),
              minimumSize: Size(200, 50),
            ),
            child: Text(
              'Cadastrar Usuário',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD81B60),
        foregroundColor: Colors.white,
        title: Text('Painel do Coordenador'),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'perfil') {
                // Navegar para perfil
              } else if (value == 'consultar') {
                _consultarUsuarios();
              } else if (value == 'sair') {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'perfil',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Color(0xFFD81B60)),
                    SizedBox(width: 8),
                    Text('Perfil'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'consultar',
                child: Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFFD81B60)),
                    SizedBox(width: 8),
                    Text('Consultar Usuário'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'sair',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app, color: Color(0xFFD81B60)),
                    SizedBox(width: 8),
                    Text('Sair'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _selectedIndex == 0 ? _buildRelatorios() : _buildCadastroUsuarios(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Relatórios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Cadastros',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFD81B60),
        onTap: _onItemTapped,
      ),
      // Removido o FloatingActionButton conforme solicitado
    );
  }
}
