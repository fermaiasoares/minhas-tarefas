import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
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
              decoration: const InputDecoration(
                  icon: Icon(Icons.mail),
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  suffixIcon: Align(
                    widthFactor: 1.0,
                    heightFactor: 1.0,
                    child: Icon(Icons.remove_red_eye),
                  )),
            ),
            const SizedBox(
              height: 16.0,
            ),
            TextFormField(
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
                onPressed: () {},
                child: const Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    );
  }
}
