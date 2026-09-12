import 'main_mobile.dart' if (dart.library.html) 'web/main_web.dart' as app_entry;

Future<void> main() => app_entry.main();
