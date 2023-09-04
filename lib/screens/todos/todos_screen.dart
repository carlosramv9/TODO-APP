import 'package:flutter/material.dart';
import 'package:todo_app/components/layout/layout.dart';
import 'package:todo_app/components/todos/todos_list.dart';
import 'package:todo_app/screens/todos/create_todo.dart';

class TODOSScreen extends StatelessWidget {
  const TODOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigation = Navigator.of(context);
    return LayoutScreen(
        body: const TODOSList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigation.push(MaterialPageRoute(builder: (_) => const CreateTODO()));
          },
          child: const Icon(Icons.add),
        ));
  }
}
