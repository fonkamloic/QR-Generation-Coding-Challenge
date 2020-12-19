import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_SEED = "CACHED_SEED";

@lazySingleton
class Persistence {
  final SharedPreferences _preferences;

  Persistence(this._preferences);

  // set seed
  Future<void> setSeed(String value) async =>
      _preferences.setString(CACHED_SEED, value);
  // getSeed
  String get getCachedSeed => _preferences.getString(CACHED_SEED ?? "No value in Cache");
}
