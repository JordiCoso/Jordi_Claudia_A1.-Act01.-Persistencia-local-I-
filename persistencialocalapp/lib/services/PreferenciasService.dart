import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasService {
  late SharedPreferences _sharedPreferences;

  factory PreferenciasService() { // TODO
    return CreateInstancePreferences();
  }

  void CreateInstancePreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    print(await _sharedPreferences);
  }

}
