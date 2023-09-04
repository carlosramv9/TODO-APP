import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/helpers/theme.dart';
import 'package:todo_app/providers/states_provider.dart';
import 'package:todo_app/router/app_router.dart';

Future<void> main() async {
  await dotenv.load(fileName: kReleaseMode ? 'env/env.production' : 'env/env.development');
  await Supabase.initialize(
    url: dotenv.env['API_URL']!,
    anonKey: dotenv.env['API_KEY']!,
  );

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(isDarkModeProvider);
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: dotenv.env['APP_TITLE']!,
      theme: AppTheme(isDarkmode: isDarkMode).getTheme(),
    );
  }
}
