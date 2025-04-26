import 'package:flutter/material.dart';
import 'package:smartbusserra/user_data.dart';
import 'tela_login.dart';
import 'package:validators/validators.dart'; // Adicionar isso para validar o e-mail
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart'; // Para máscara

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignupScreen(),
    );
  }
}

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String? userType;
  String? city;
  final _formKey = GlobalKey<FormState>();

  // Controllers para capturar os textos digitados
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarSenhaController =
      TextEditingController();
  // Máscaras para CPF e Telefone
  final cpfFormatter = MaskTextInputFormatter(
      mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});
  final telefoneFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  @override
  void dispose() {
    // Liberar memória dos controllers quando não forem mais usados
    nomeController.dispose();
    cpfController.dispose();
    telefoneController.dispose();
    emailController.dispose();
    senhaController.dispose();
    confirmarSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.zero,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Column(
                      children: [
                        _buildHeader(),
                        SizedBox(height: 20),
                        _buildForm(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Cabeçalho do app
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
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
    );
  }

  /// Formulário de Cadastro
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Crie sua conta",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          _buildDropdown(
            "Tipo de usuário",
            ["Aluno", "Motorista", "Coordenação"],
            userType,
            (value) => setState(() => userType = value),
          ),
          _buildDropdown(
            "Cidade onde mora",
            ["Brasil Novo", "Vitória do Xingu", "Medicilândia", "Anapú"],
            city,
            (value) => setState(() => city = value),
          ),
          _buildTextInput("Nome Completo", controller: nomeController),
          _buildTextInput("CPF", controller: cpfController),
          _buildTextInput("Telefone", controller: telefoneController),
          _buildTextInput(
            "Email",
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          _buildTextInput(
            "Senha",
            controller: senhaController,
            obscureText: true,
          ),
          _buildTextInput(
            "Confirmar Senha",
            controller: confirmarSenhaController,
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Aqui você pode adicionar uma verificação para senha e confirmação de senha

                if (senhaController.text != confirmarSenhaController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("As senhas não coincidem!"),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Salva os dados do usuário
                UserData.cadastrarUsuario(
                  nomeUsuario: nomeController.text,
                  emailUsuario: emailController.text,
                  senhaUsuario: senhaController.text,
                );

                // Volta para a tela de login
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
              minimumSize: Size(double.infinity, 50),
            ),
            child: Text("CADASTRAR"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  /// Dropdown personalizado
  Widget _buildDropdown(
    String hint,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        value: value,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
        hint: Text(hint),
      ),
    );
  }

  /// Campo de texto personalizado
  Widget _buildTextInput(
    String labelText, {
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Preencha este campo';
          }
          return null;
        },
      ),
    );
  }
}
