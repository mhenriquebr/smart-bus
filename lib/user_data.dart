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
}
