import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/models/task.dart';

// Get task data from supabase api
Future<List<Task>?> getTasks() async {
  try {
    final supabase = Supabase.instance.client;
    final response = await supabase.from('tasks').select('*,user_created:users!created_by(*)');
    List<Task> tasks = (response as List).map((e) => Task.fromJson(e)).toList();

    return tasks;
  } catch (e) {
    log(e.toString());
  }
  return null;
}
