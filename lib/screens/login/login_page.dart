import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:layout/core/messages/messages.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  bool showPasswod = false;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessager = ScaffoldMessenger.of(context);

    Future<void> logar({
      required String email,
      required String password,
    }) async {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        if (kDebugMode) {
          print(credential);
        }
      } on FirebaseAuthException catch (e, s) {
        log('Firebase:logar', error: e, stackTrace: s);

        Messages.showMessage(
          scaffoldMessager,
          MessageType.warning,
          'Não foi possível acessar sua conta',
        );
      } on Exception catch (e, s) {
        log('Firebase:logar', error: e, stackTrace: s);

        Messages.showMessage(
          scaffoldMessager,
          MessageType.warning,
          'Não foi possível acessar sua conta',
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
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
                TextFormField(
                  controller: emailEC,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.mail),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail é obrigatório'),
                    Validatorless.email('Digite um e-mail válido'),
                  ]),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                  controller: passwordEC,
                  obscureText: showPasswod,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPasswod = !showPasswod;
                        });
                      },
                      icon: Icon(
                        showPasswod ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha é obrigatório'),
                  ]),
                ),
                const SizedBox(
                  height: 56.0,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56.0),
                  ),
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await logar(
                        email: emailEC.text,
                        password: passwordEC.text,
                      );
                    }
                  },
                  child: const Text('Entrar'),
                ),
                const Divider(
                  height: 56.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/cadastrar-login');
                  },
                  child: const Text('Cadastrar sua conta'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
