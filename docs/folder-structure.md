Recommended folder structure for the iTs Handbook Flutter app

lib/
  main.dart                # App entry
  routes.dart              # Named routes and navigation helper
  screens/                 # Screen widgets (login, home, library, article, runbooks, templates, admin)
  widgets/                 # Reusable UI components (search, cards, checklist view)
  models/                  # Dart models and (de)serialization
  services/                # Local data service, auth stub, supabase service (later)
  utils/                   # Helpers, constants
assets/
  sample_data.json        # Seed data for local demo
  images/                 # Placeholder screenshots and icons

Notes
- Keep models lightweight and serializable (fromJson/toJson) to ease Supabase mapping later.
- `services/local_data_service.dart` will be the single source of truth for the MVP local demo.
