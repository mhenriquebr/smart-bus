import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/home_aluno.dart';
import 'package:smartbusserra/telas/home_motorista.dart';
import 'package:smartbusserra/telas/home_coord.dart';
import 'tela_cadastro.dart'; // Importa a tela de cadastro
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
                            // Ação após o login ser validado
                            // Você pode só mostrar uma mensagem, por exemplo:
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Login realizado com sucesso!')),
                            );
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
                      OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String email = _emailController.text.trim();
                            String senha = _senhaController.text;

                            if (usuariosSimulados.containsKey(email) &&
                                usuariosSimulados[email]!['senha'] == senha) {
                              String tipo = usuariosSimulados[email]!['tipo'];

                              Widget proximaTela;
                              switch (tipo) {
                                case 'aluno':
                                  proximaTela = HomeAluno(
                                      cidadeAluno: UserData.cidadeAluno ??
                                          'Cidade desconhecida');
                                  break;
                                case 'motorista':
                                  proximaTela = HomeMotorista();
                                  break;
                                case 'coordenacao':
                                  proximaTela = HomeCoordenacao();
                                  break;
                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Tipo de usuário desconhecido')),
                                  );
                                  return;
                              }

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => proximaTela),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('E-mail ou senha inválidos')),
                              );
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.pinkAccent,
                          side: BorderSide(color: Colors.pinkAccent),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: Text("CADASTRAR USUÁRIO"),
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
}
