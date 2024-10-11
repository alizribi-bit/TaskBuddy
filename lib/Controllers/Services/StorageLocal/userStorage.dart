import 'package:get_storage/get_storage.dart';

class LocalStorageUser {
  ///Write
  void saveUserOnStorage(String user) async {
    await GetStorage().write('user', user);
  }

  ///Read
  ///le String peut fait des errers
  Future<String> get getUserFromStorage async {
    return await GetStorage().read('user') ?? '';
  }
}
