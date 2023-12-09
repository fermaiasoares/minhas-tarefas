import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  Future<void> logar({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              TextFormField(
                controller: emailEC,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  suffixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(Icons.remove_red_eye),
                  ),
                ),
                validator: (String? value) {
                  if (value != null) {
                    return 'E-mail é obrigatório';
                  }
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: passwordEC,
                decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    suffixIcon: Align(
                        widthFactor: 1.0,
                        heightFactor: 1.0,
                        child: Icon(Icons.remove_red_eye))),
              ),
              const SizedBox(
                height: 56.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56.0)),
                onPressed: () async {
                  // TODO: Pesquisar sobre formKey e como faz para recuperar as informoções dos controllers
                  // emailEC.value || emailEC.text;

                  // if (!formKey.currentState!.validate()) {
                  //   return;
                  // }
                  if (formKey.currentState!.validate()) {
                    await logar(
                      email: 'fermaiasoares@aol.com',
                      password: '123456',
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
    );
  }
}
