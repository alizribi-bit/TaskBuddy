import 'package:get_storage/get_storage.dart';

class LocalStorage {
  ///Write
  void saveLonguage(String lang) async {
    await GetStorage().write('lang', lang);
  }

  ///Read
  Future<String> get getLanguageSelected async {
    return await GetStorage().read('lang') == null
        ? 'fr'
        : await GetStorage().read('lang');
  }
}
