import 'package:flutter/material.dart';
import 'package:layout/core/constants/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> verificaUsuarioLogado() async {
    await Future.delayed(const Duration(seconds: 1));

    final sharedPreferences = await SharedPreferences.getInstance();

    if (!sharedPreferences.containsKey(SharedPreferencesKey.email) &&
        !sharedPreferences.containsKey(SharedPreferencesKey.uid)) {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (route) => false,
        );
      }
    } else {
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/minhas-tarefas',
          (route) => false,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    verificaUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
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
      ),
    );
  }
}
