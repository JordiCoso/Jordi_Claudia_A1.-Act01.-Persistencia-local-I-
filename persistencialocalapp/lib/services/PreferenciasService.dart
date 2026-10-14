import 'package:persistencialocalapp/models/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasService {
  // Variable de clase para no tener que llamar cada vez a getInstance().
  late SharedPreferences _preferencias;

  // Especifico un constructor privado para que no se pueda llamar a new.
  PreferenciasService._crear();

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
    var _inicializando = PreferenciasService._crear();

    _inicializando._preferencias = await SharedPreferences.getInstance();

    return _inicializando;
  }

  bool? getPrimerInicio() {
    return _preferencias.getBool("primerInicio");
  }

  void setPrimerInicio(bool valor) {
    _preferencias.setBool("primerInicio", valor);
  }

  void guardarUsuario(Usuario usuario) {
    _preferencias.setString("usuario", usuario.nombre);
    _preferencias.setInt("numeroHabitos", usuario.numeroHabitos);
  }

  Usuario cargarUsuario() {
    String _nombre = _preferencias.getString("usuario") ?? '';
    int _numeroHabitos = _preferencias.getInt("numeroHabitos") ?? 0;
    Usuario _usuario = new Usuario(nombre: _nombre, numeroHabitos: _numeroHabitos);

    return _usuario;
  }
}
