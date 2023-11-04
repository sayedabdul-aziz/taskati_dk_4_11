import 'package:hive/hive.dart';

class AppLocal {
  //keys
  static String Image_Key = 'Image_Key';
  static String Name_Key = 'Name_Key';
  static String IS_UPLOAD = 'IS_UPLOAD';
  static String DARK_MODE = 'IS_DARK';

  // cacheData

  static cacheData(String key, dynamic value) async {
    var box = Hive.box('user');
    await box.put(key, value);
  }

  // getCachedData

  static Future<dynamic> getData(String key) async {
    var box = Hive.box('user');
    return await box.get(key);
  }
}
