class CadastroUsuario {
  final String tipo;
  final String cidade;
  final String nome;
  final String cpf;
  final String email;
  final String emailDestino;

  CadastroUsuario({
    required this.tipo,
    required this.cidade,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.emailDestino,
  });

  @override
  String toString() {
    return 'CadastroUsuario(tipo: $tipo, cidade: $cidade, nome: $nome, cpf: $cpf, email: $email, emailDestino: $emailDestino)';
  }
}

// Lista simulando um banco de dados temporário em memória
List<CadastroUsuario> cadastrosRecebidos = [];



/*
// lib/user_data.dart
class UserData {
  static String? nomeUsuario;
  static String? emailUsuario;
  static String? senhaUsuario;
  static String? tipoUsuario;
  static String? cidadeAluno;

  static void login(String nome, String tipo, String cidade) {
    nomeUsuario = nome;
    tipoUsuario = tipo;
    cidadeAluno = cidade;
  }

  static void logout() {
    nomeUsuario = null;
    emailUsuario = null;
    senhaUsuario = null;
    tipoUsuario = null;
    cidadeAluno = null;
  }

  // 👉 Método para cadastrar o usuário
  static void cadastrarUsuario({
    required String nomeUsuario,
    required String emailUsuario,
    required String senhaUsuario,
  }) {
    UserData.nomeUsuario = nomeUsuario;
    UserData.emailUsuario = emailUsuario;
    UserData.senhaUsuario = senhaUsuario;
  }
}  */
