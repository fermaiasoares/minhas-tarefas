import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:layout/core/messages/messages.dart';
import 'package:validatorless/validatorless.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _SingupPageState();
}

class _SingupPageState extends State<SingupPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final senhaEC = TextEditingController();
  final confirmarSenhaEC = TextEditingController();

  bool showPassword = false;

  @override
  void dispose() {
    emailEC.dispose();
    confirmarSenhaEC.dispose();
    senhaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldMessager = ScaffoldMessenger.of(context);

    Future<void> cadastrarUsuario({
      required String email,
      required String password,
    }) async {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (kDebugMode) {
          print(credential);
        }

        Messages.showMessage(
          scaffoldMessager,
          MessageType.success,
          'Conta registrada com sucesso',
        );
      } on FirebaseAuthException catch (e, s) {
        log('Firebase:cadastrarUsuario', error: e, stackTrace: s);

        if (e.code == 'weak-password') {
          Messages.showMessage(
            scaffoldMessager,
            MessageType.warning,
            'A senha fornecida é muito fraca',
          );
        } else if (e.code == 'email-already-in-use') {
          Messages.showMessage(
            scaffoldMessager,
            MessageType.warning,
            'Conta de e-mail já usada.',
          );
        } else {
          Messages.showMessage(
            scaffoldMessager,
            MessageType.error,
            'Não foi possível cadastra sua conta.',
          );
        }
      } on Exception catch (e, s) {
        log('Firebase:cadastrarUsuario', error: e, stackTrace: s);

        Messages.showMessage(
          scaffoldMessager,
          MessageType.error,
          'Não foi possível cadastrar sua conta.',
        );
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  width: 120,
                  height: 120,
                  child: const Icon(
                    Icons.home,
                    size: 90.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
                const Text('Faça seu cadastro'),
                const SizedBox(
                  height: 100.0,
                ),
                TextFormField(
                  controller: emailEC,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.email('Digite um e-mail válido'),
                    Validatorless.required('E-mail é obrigatório'),
                  ]),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: senhaEC,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.min(
                        8, 'Senha deve ter pelo menos 8 caracteres'),
                    Validatorless.required('Senha é obrigatória'),
                  ]),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: confirmarSenhaEC,
                  obscureText: showPassword,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    labelText: 'Confirmar senha',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        showPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirmar senha é obrigatório'),
                    Validatorless.compare(senhaEC, 'Senhas não conferem'),
                  ]),
                ),
                const SizedBox(
                  height: 56.0,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56.0)),
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        await cadastrarUsuario(
                          email: emailEC.text,
                          password: senhaEC.text,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
