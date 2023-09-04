import 'package:flutter/material.dart';
import 'package:todo_app/components/layout/layout.dart';
import 'package:todo_app/components/todos/todos_list.dart';

class TODOSScreen extends StatelessWidget {
  const TODOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutScreen(
        body: const TODOSList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
