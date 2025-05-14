import 'package:flutter/material.dart';
import 'package:smartbusserra/telas/tela_login.dart';
import 'package:smartbusserra/user_data.dart';

class HomeCoordenador extends StatefulWidget {
  @override
  _HomeCoordenadorState createState() => _HomeCoordenadorState();
}

class _HomeCoordenadorState extends State<HomeCoordenador> {
  void CadastroUsuario() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Cadastrar Novo Usuário"),
        content: Text("Aqui o coordenador poderá ver ou editar seu perfil."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void abrirPerfil() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Perfil do Coordenador"),
        content: Text("Aqui o coordenador poderá ver ou editar seu perfil."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Fechar"),
          ),
        ],
      ),
    );
  }

  void alterarSenha() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Alterar Senha"),
        content: TextField(
          decoration: InputDecoration(labelText: "Nova senha"),
          obscureText: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              // lógica de salvar senha
              Navigator.pop(context);
            },
            child: Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent, // Cor padrão
        foregroundColor: Colors.white, // Cor padrão
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pinkAccent, // Cor padrão
              ),
              child: Text(
                'Bem-vindo, Coordenador',
                style:
                    TextStyle(color: Colors.white, fontSize: 20), // Cor padrão
              ),
            ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.pinkAccent),
              title: Text('Perfil'),
              onTap: () {
                Navigator.pop(context);
                abrirPerfil();
              },
            ),
            ListTile(
              leading: Icon(Icons.lock, color: Colors.pinkAccent),
              title: Text('Senha'),
              onTap: () {
                Navigator.pop(context);
                alterarSenha();
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'Tela do Coordenador - funcionalidades futuras aqui',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
