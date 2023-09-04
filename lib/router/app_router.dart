import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/screens/login/login.dart';
import 'package:todo_app/screens/todos/todos_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/login'),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/todos', builder: (context, state) => const TODOSScreen()),
    ],
  );
});
