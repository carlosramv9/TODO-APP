import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/providers/states_provider.dart';

import '../../generated/l10n.dart';

class LayoutScreen extends ConsumerStatefulWidget {
  final Widget body;
  final FloatingActionButton? floatingActionButton;
  const LayoutScreen({super.key, required this.body, this.floatingActionButton});

  @override
  LayoutScreenState createState() => LayoutScreenState();
}

class LayoutScreenState extends ConsumerState<LayoutScreen> {
  bool isLoading = false;
  var supabase = Supabase.instance.client;
  Session? session;

  void onChangeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ref.read(isDarkModeProvider.notifier).update((state) {
      prefs.setBool('darkMode', !state);
      return !state;
    });
  }

  Future initialize() async {
    final prefs = await SharedPreferences.getInstance();

    S.load(Locale(prefs.getString('language') ?? 'en'));
    ref.read(isDarkModeProvider.notifier).state = prefs.getBool('darkMode') ?? false;
  }

  //logout from supabase
  void logout() async {
    var router = GoRouter.of(context);
    var snackbar = ScaffoldMessenger.of(context);
    try {
      setState(() {
        isLoading = true;
      });
      await supabase.auth.signOut();
      session = null;

      snackbar.showSnackBar(
        const SnackBar(
          content: Text('Logout success'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      router.go('/login');
    } catch (e) {
      //Snackbar error
      snackbar.showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red, behavior: SnackBarBehavior.floating),
      );
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isDarkTheme = ref.watch(isDarkModeProvider);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
            onPressed: onChangeTheme,
            icon: isDarkTheme ? const Icon(Icons.light_mode, color: Colors.white) : const Icon(Icons.dark_mode, color: Colors.white),
          ),
          TextButton(
              onPressed: logout,
              child: const Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ))
        ]),
        body: widget.body,
        floatingActionButton: widget.floatingActionButton,
      ),
    );
  }
}
