Route map and screen responsibilities

Routes (named)
- /login                 -> LoginScreen (email/password; local stub)
- /home                  -> HomeScreen (search, pinned, recents, common runbooks)
- /library               -> LibraryScreen (categories + article list)
- /article/:id           -> ArticleScreen (view, checklist mode, favorite)
- /runbooks              -> RunbooksScreen (list + open runbook)
- /templates             -> TemplatesScreen (list of checklist templates)
- /checklist/:instanceId -> ChecklistInstanceScreen (live checklist instance)
- /admin                 -> AdminScreen (manage users, categories)

Screen contracts (short)
- ArticleScreen inputs: articleId -> loads `Article` model
- ChecklistInstanceScreen inputs: checklistInstanceId -> loads `ChecklistInstance`
- LibraryScreen filters: categoryId, tags, complexity, vendor, environment

Notes
- Navigation should use named routes and a central `routes.dart` to keep deep links simple.
