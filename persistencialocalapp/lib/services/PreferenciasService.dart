import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasService {

  SharedPreferences? _sharedPreferences = null;

  void Instanciar() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<SharedPreferences> GetPreferences() async {
    return SharedPreferences.getInstance();
  }

}
