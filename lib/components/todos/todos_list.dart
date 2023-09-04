import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/api/tasks.dart';
import 'package:todo_app/models/index.dart';
import 'package:todo_app/utilities/util.dart';

class TODOSList extends ConsumerStatefulWidget {
  const TODOSList({super.key});

  @override
  TODOSListState createState() => TODOSListState();
}

class TODOSListState extends ConsumerState<TODOSList> {
  List<Task> tasks = [];
  void intialize() async {
    final tasks = await getTasks();
    if (tasks != null) {
      setState(() {
        this.tasks = tasks;
      });
    }
  }

  @override
  void initState() {
    intialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...tasks
            .map(
              (e) => ListTile(
                onTap: () {},
                leading: Icon(e.status == TaskStatus.completed ? Icons.check : Icons.calendar_month),
                title: Text(e.taskName ?? ''),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatDateTimeAMPM(e.createdAt ?? '')!),
                    const SizedBox(height: 5),
                    Text('${e.userCreated?.firstName ?? ''} ${e.userCreated?.lastName ?? ''}'),
                  ],
                ),
                //isThreeLine: true,
                trailing: const Icon(Icons.chevron_right),
              ),
            )
            .toList(),
      ],
    );
  }
}
