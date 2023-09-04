import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utilities/util.dart';
import 'package:uuid/uuid.dart';

class TODOForm extends StatefulWidget {
  const TODOForm({super.key});

  @override
  State<TODOForm> createState() => _TODOFormState();
}

class _TODOFormState extends State<TODOForm> {
  final supabase = Supabase.instance.client;
  final _estimatedDateController = TextEditingController();
  final _taskNameDateController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _estimatedDateController.text = formatDateTimeAMPM(DateTime.now().toIso8601String()) ?? '';
    super.initState();
  }

  void saveTODO() async {
    final navigation = Navigator.of(context);
    final snackbar = ScaffoldMessenger.of(context);
    var uuid = const Uuid();
    try {
      var todo = Task(
        id: uuid.v4(),
        taskName: _taskNameDateController.text,
        createdAt: DateTime.now().toIso8601String(),
        description: _descriptionController.text,
        estimatedDate: _estimatedDateController.text,
        createdBy: supabase.auth.currentUser!.id,
      );

      await supabase.from('tasks').insert(todo.toJson()).select();
      snackbar.showSnackBar(const SnackBar(content: Text('Task created successfully')));
      navigation.pop();
    } catch (e) {
      snackbar.showSnackBar(const SnackBar(content: Text('Error creating Task')));
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _taskNameDateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Task Name',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      //multiline
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              // DateTime picker
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _estimatedDateController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Estimated Date',
                      ),
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2015, 8),
                          lastDate: DateTime(2101),
                        );
                        if (picked != null) _estimatedDateController.text = formatDateTimeAMPM(picked.toIso8601String()) ?? '';
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              //Save button
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: saveTODO,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
