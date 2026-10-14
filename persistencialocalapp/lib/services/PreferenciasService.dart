import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasService {
  // variable de clase para no tener que llamar cada vez a GetInstance().
  late SharedPreferences _preferencias;

  //Especifico un constructor privado para que no se pueda llamar a new.
  PreferenciasService._crear() {}

  /*
  * Constructor publico, usa el privado para obtener el objeto donde luego
  * podemos utilizar un await para poder esperar a definir la variable.
  * Tambien al ser el unico constructor y ser privado obliga a usar
  * nuestro constructor publico.
  * Hay que hacer esto porque el constructor normal no puede ser async.
  *
  * Codigo sacado de
  * Source - https://stackoverflow.com/a/59304510
  * Posted by Kankaristo
  * Retrieved 2026-10-14, License - CC BY-SA 4.0
  */

  static Future<PreferenciasService> crear() async {
    var inicializando = PreferenciasService._crear();

    inicializando._preferencias = await SharedPreferences.getInstance();

    return inicializando;
  }

  SharedPreferences getPreferencias() {
    return _preferencias;
  }
}
