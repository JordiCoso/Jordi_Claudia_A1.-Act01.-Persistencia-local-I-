import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasService {

  Future<SharedPreferences> GetPreferences() async {
    return SharedPreferences.getInstance();
  }

}
