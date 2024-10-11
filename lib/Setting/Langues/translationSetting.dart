import 'package:get/get.dart';

import 'AR.dart';
import 'EN.dart';
import 'FR.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'fr': fr,
        'ar': ar,
        'en': en,
      };
}
