import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartbusserra/user_data.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({Key? key}) : super(key: key);

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _nomeCtl = TextEditingController(text: UserData.nome);
  final _emailCtl = TextEditingController(text: UserData.email);
  final _foneCtl = TextEditingController(text: UserData.telefone);
  final _senhaCtl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> _trocarFoto() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => UserData.imagemPerfil = img.path);
    }
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      UserData.nome = _nomeCtl.text;
      UserData.email = _emailCtl.text;
      UserData.telefone = _foneCtl.text;
      UserData.senha = _senhaCtl.text;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil salvo com sucesso!'),
        backgroundColor: Colors.pinkAccent,
      ),
    );
    Navigator.pop(context);
  }

  Widget _campo(String rotulo, TextEditingController ctl,
      {bool obrigatorio = false, TextInputType? tipo}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: ctl,
        keyboardType: tipo,
        obscureText: rotulo.toLowerCase().contains('senha'),
        validator: (value) {
          if (obrigatorio && (value == null || value.trim().isEmpty)) {
            return 'Preencha este campo';
          }
          if (rotulo.toLowerCase().contains('senha') && value!.length < 6) {
            return 'A senha deve ter pelo menos 6 caracteres';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: obrigatorio ? '$rotulo *' : rotulo,
          filled: true,
          fillColor: Colors.white,
          floatingLabelStyle: const TextStyle(color: Colors.pinkAccent),
          labelStyle: const TextStyle(color: Colors.pinkAccent),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.pinkAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.pinkAccent, width: 2),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Card com imagem e nome
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: UserData.imagemPerfil != null
                        ? FileImage(File(UserData.imagemPerfil!))
                        : null,
                    child: UserData.imagemPerfil == null
                        ? const Icon(Icons.person,
                            size: 60, color: Colors.pinkAccent)
                        : null,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    UserData.nome ?? 'Seu nome',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const Text(
                    'Graduação presencial',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _trocarFoto,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: const Text('EDITAR FOTO'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Formulário
            Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _campo('Nome', _nomeCtl, obrigatorio: true),
                    _campo('E-mail', _emailCtl,
                        obrigatorio: true, tipo: TextInputType.emailAddress),
                    _campo('Telefone', _foneCtl,
                        obrigatorio: true, tipo: TextInputType.phone),
                    _campo('Nova Senha', _senhaCtl,
                        obrigatorio: true, tipo: TextInputType.visiblePassword),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _salvar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: const Text('SALVAR'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
