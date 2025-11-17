import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/user.dart';
import '../models/category.dart';
import '../models/tag.dart';
import '../models/article.dart';
import '../models/checklist_template.dart';

class LocalDataService {
  LocalDataService._privateConstructor();
  static final LocalDataService instance = LocalDataService._privateConstructor();

  List<User> users = [];
  List<Category> categories = [];
  List<Tag> tags = [];
  List<Article> articles = [];
  List<ChecklistTemplate> checklistTemplates = [];

  Future<void> load() async {
    final raw = await rootBundle.loadString('assets/sample_data.json');
    final map = json.decode(raw) as Map<String, dynamic>;

    users = (map['users'] as List<dynamic>? ?? []).map((e) => User.fromJson(e as Map<String, dynamic>)).toList();
    categories = (map['categories'] as List<dynamic>? ?? []).map((e) => Category.fromJson(e as Map<String, dynamic>)).toList();
    tags = (map['tags'] as List<dynamic>? ?? []).map((e) => Tag.fromJson(e as Map<String, dynamic>)).toList();
    articles = (map['articles'] as List<dynamic>? ?? []).map((e) => Article.fromJson(e as Map<String, dynamic>)).toList();
    checklistTemplates = (map['checklistTemplates'] as List<dynamic>? ?? []).map((e) => ChecklistTemplate.fromJson(e as Map<String, dynamic>)).toList();
  }
}
