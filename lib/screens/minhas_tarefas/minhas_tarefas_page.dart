import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MinhasTarefasPage extends StatefulWidget {
  const MinhasTarefasPage({super.key});

  @override
  State<MinhasTarefasPage> createState() => _MinhasTarefasPageState();
}

class _MinhasTarefasPageState extends State<MinhasTarefasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Tarefas'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blueAccent,
        onPressed: () {},
        isExtended: false,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: const Text(
          'Adicionar tarefa',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (_, index) => const Divider(),
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) => ListTile(
          leading: Image.network('https://source.unsplash.com/200x200/?tasks'),
          title: Text("Minha tarefa ${index + 1}"),
          subtitle: Text(
              "Data: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now())}"),
          trailing: IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
