import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/home_aluno.dart';
import 'package:smartbusserra/telas/home_motorista.dart';
import 'package:smartbusserra/telas/home_coord.dart';
import 'package:smartbusserra/user_data.dart';

Map<String, Map<String, dynamic>> usuariosSimulados = {
  "aluno@email.com": {
    "senha": "123456",
    "tipo": "aluno",
  },
  "motorista@email.com": {
    "senha": "123456",
    "tipo": "motorista",
  },
  "coord@email.com": {
    "senha": "123456",
    "tipo": "coordenacao",
  },
};

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _cadastroEmailController = TextEditingController();
  String _tipoSelecionado = 'Aluno';
  String _cidadeSelecionada = 'Brasil Novo';

  final Map<String, String> cidadesEmail = {
    'Brasil Novo': 'coordbrasil@smartbus.com',
    'Vitória do Xingu': 'coordvitoria@smartbus.com',
    'Medicilândia': 'coordmedicilandia@smartbus.com',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "SMART BUS SERRA",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Viagem Segura!",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      DropdownButtonFormField<String>(
                        value: _tipoSelecionado,
                        items: ['Aluno', 'Motorista', 'Coordenação']
                            .map((tipo) => DropdownMenuItem(
                                  value: tipo,
                                  child: Text(tipo),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _tipoSelecionado = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Tipo de usuário',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildTextInput("Usuário (E-mail)",
                          controller: _emailController, isEmail: true),
                      _buildTextInput("Senha",
                          controller: _senhaController, obscureText: true),
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value!;
                              });
                            },
                          ),
                          Text("Lembrar-me"),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final email = _emailController.text.trim();
                            final senha = _senhaController.text.trim();

                            if (usuariosSimulados.containsKey(email) &&
                                usuariosSimulados[email]!['senha'] == senha) {
                              final tipo = usuariosSimulados[email]!['tipo'];
                              Widget destino;

                              if (tipo == 'aluno') {
                                destino = HomeAluno(cidadeAluno: 'Brasil Novo');
                              } else if (tipo == 'motorista') {
                                destino = HomeMotorista();
                              } else {
                                destino = HomeCoordenacao();
                              }

                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => destino),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Credenciais inválidas')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text("ENTRAR"),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: () => _mostrarFormularioCadastro(context),
                        child: Text(
                          "NÃO TENHO CADASTRO",
                          style: TextStyle(color: Colors.pinkAccent),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(
    String labelText, {
    bool obscureText = false,
    TextEditingController? controller,
    bool isEmail = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha este campo';
          }
          if (isEmail &&
              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Digite um e-mail válido';
          }
          if (labelText == "Senha" && value.length < 6) {
            return 'A senha deve ter pelo menos 6 caracteres';
          }
          return null;
        },
      ),
    );
  }

  void _mostrarFormularioCadastro(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cadastro",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  child: Text(
                    "Seus dados serão enviados para a Coordenação responsável da sua cidade e em breve retornarão com Login e sua Senha ao seu e-mail informado abaixo.",
                    style: TextStyle(color: Colors.black87, fontSize: 14),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _tipoSelecionado,
                  items: ['Aluno', 'Motorista', 'Coordenação']
                      .map((tipo) => DropdownMenuItem(
                            value: tipo,
                            child: Text(tipo),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _tipoSelecionado = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Tipo de usuário'),
                ),
                DropdownButtonFormField<String>(
                  value: _cidadeSelecionada,
                  items: cidadesEmail.keys
                      .map((cidade) => DropdownMenuItem(
                            value: cidade,
                            child: Text(cidade),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _cidadeSelecionada = value!;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Cidade'),
                ),
                TextField(
                  controller: _nomeController,
                  decoration: InputDecoration(labelText: 'Nome completo'),
                ),
                TextField(
                  controller: _cpfController,
                  decoration: InputDecoration(labelText: 'CPF'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _cadastroEmailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final nome = _nomeController.text.trim();
                    final cpf = _cpfController.text.trim();
                    final email = _cadastroEmailController.text.trim();
                    final cidade = _cidadeSelecionada;
                    final tipo = _tipoSelecionado;
                    final emailDestino = cidadesEmail[cidade] ?? '';

                    if (nome.isNotEmpty &&
                        cpf.isNotEmpty &&
                        email.isNotEmpty &&
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(email)) {
                      // Armazenar localmente
                      final novoCadastro = CadastroUsuario(
                        tipo: tipo,
                        cidade: cidade,
                        nome: nome,
                        cpf: cpf,
                        email: email,
                        emailDestino: emailDestino,
                      );

                      cadastrosRecebidos.add(novoCadastro);
                      print("Cadastro recebido: $novoCadastro");

                      // Fecha o formulário e notifica o usuário
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Cadastro enviado para $emailDestino com sucesso!'),
                        ),
                      );

                      // Limpa os campos
                      _nomeController.clear();
                      _cpfController.clear();
                      _cadastroEmailController.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Preencha todos os campos corretamente!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Enviar Cadastro"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
