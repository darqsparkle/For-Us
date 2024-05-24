

import 'package:forus/firebase_options.dart';
import 'package:forus/services/alert_service.dart';
import 'package:forus/services/auth_services.dart';
import 'package:forus/services/database_service.dart';
import 'package:forus/services/media_service.dart';
import 'package:forus/services/navigation_service.dart';
import 'package:forus/services/storage_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

Future<void> setUpFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthServices>(AuthServices());

  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );

  getIt.registerSingleton<AlertService>(
    AlertService(),
  );

  getIt.registerSingleton<MediaService>(
    MediaService(),
  );

  getIt.registerSingleton<StorageService>(
    StorageService(),
  );

  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
}

String generateChatID({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];
  uids.sort();
  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}
