import 'package:flutter/material.dart';
import 'routes.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/article_screen.dart';
import 'screens/runbooks_screen.dart';
import 'screens/templates_screen.dart';
import 'screens/checklist_instance_screen.dart';
import 'screens/admin_screen.dart';

void main() {
  runApp(ItshandbookApp());
}

class ItshandbookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iTs Handbook',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: Routes.home,
      routes: {
        Routes.login: (ctx) => LoginScreen(),
        Routes.home: (ctx) => HomeScreen(),
        Routes.library: (ctx) => LibraryScreen(),
        Routes.runbooks: (ctx) => RunbooksScreen(),
        Routes.templates: (ctx) => TemplatesScreen(),
        Routes.admin: (ctx) => AdminScreen(),
      },
      onGenerateRoute: (settings) {
        // simple generator for article and checklist detail routes
        if (settings.name == Routes.article) {
          final args = settings.arguments as Map<String, dynamic>?;
          final id = args != null ? args['id'] as String? : null;
          return MaterialPageRoute(builder: (_) => ArticleScreen(articleId: id));
        }
        if (settings.name == Routes.checklist) {
          final args = settings.arguments as Map<String, dynamic>?;
          final id = args != null ? args['id'] as String? : null;
          return MaterialPageRoute(builder: (_) => ChecklistInstanceScreen(instanceId: id));
        }
        return null;
      },
    );
  }
}
