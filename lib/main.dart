import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:layout/screens/minhas_tarefas/minhas_tarefas_page.dart';
import 'firebase_options.dart';

import 'package:layout/screens/login/login_page.dart';
import 'package:layout/screens/signup/singup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minhas Tarefas APP',
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/login': (_) => const LoginPage(),
        '/cadastrar-login': (_) => const SingupPage(),
        '/minhas-tarefas': (_) => const MinhasTarefasPage(),
      },
    );
  }
}
