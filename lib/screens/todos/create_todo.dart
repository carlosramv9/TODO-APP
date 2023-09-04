import 'package:flutter/material.dart';
import 'package:todo_app/components/layout/layout.dart';
import 'package:todo_app/components/todos/todo_form.dart';

class CreateTODO extends StatefulWidget {
  const CreateTODO({super.key});

  @override
  State<CreateTODO> createState() => _CreateTODOState();
}

class _CreateTODOState extends State<CreateTODO> {
  @override
  Widget build(BuildContext context) {
    return const LayoutScreen(
      body: TODOForm(),
    );
  }
}
