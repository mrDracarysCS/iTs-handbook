import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_dashboard.dart';
import 'screens/playbook_library.dart';
import 'screens/article_view.dart';
import 'screens/runbooks_view.dart';
import 'screens/checklist_templates.dart';
import 'screens/admin_settings.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "IT's Handbook",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeDashboard(),
        '/library': (context) => const PlaybookLibrary(),
        '/article': (context) => const ArticleView(),
        '/runbooks': (context) => const RunbooksView(),
        '/checklists': (context) => const ChecklistTemplates(),
        '/admin': (context) => const AdminSettings(),
      },
    );
  }
}
