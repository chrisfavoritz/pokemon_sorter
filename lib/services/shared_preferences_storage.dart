import 'package:shared_preferences/shared_preferences.dart';

import 'storage_service.dart';

class SharedPreferencesStorage extends StorageService {

  static const lcn_key = 'lcn';
  static const rcn_key = 'rcn';

  @override
  Future<int?> getLeftCardNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(lcn_key);
  }

  @override
  Future<void> saveLeftCardNumber(int lcn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(lcn_key, lcn);
  }

  @override
  Future<int?> getRightCardNumber() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(lcn_key);
  }

  @override
  Future<void> saveRightCardNumber(int lcn) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(lcn_key, lcn);
  }
}