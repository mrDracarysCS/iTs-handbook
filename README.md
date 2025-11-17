iTs Handbook — MVP (Flutter + Supabase)

Stack
- Frontend: Flutter (Android, iOS, Web)
- Backend: Supabase (Auth, Postgres, Storage) — planned for phase 2

Goal
A minimal cross-platform app to store SOPs, runbooks, checklists, and incident guides for IT teams.

What this commit provides
- Design docs: folder structure, route map
- Dart model stubs in `lib/models/`
- Route map in `lib/routes.dart`
- `assets/sample_data.json` with sample content for a local demo

Next steps
1. Create Flutter app skeleton (I'll start this next and wire routes + placeholder screens).
2. Implement local data service and sample UI for Home and Library screens.

Notes
- This repository currently contains design artifacts and model stubs to speed the Flutter skeleton work.
- Supabase integration will be added after the local demo is validated.
