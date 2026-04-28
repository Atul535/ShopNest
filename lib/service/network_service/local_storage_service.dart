import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<void> saveToken(String token) async {
    final prefs = await _getPrefs();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await _getPrefs();
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    final prefs = await _getPrefs();
    await prefs.remove(_tokenKey);
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
