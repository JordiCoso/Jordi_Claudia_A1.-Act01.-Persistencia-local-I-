import 'package:intl/intl.dart';
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

  //ponemos un nombre con el que identificamos la fecha guardada.
  static const String nombreDatoFecha = 'ultimaApertura';

  //creamos método para guardar la fecha de apertura.
  void guardarUltimaApertura(String fecha) { //es void porque el método no devuelve ningún valor.

    //obtenemos el acceso a las preferencias guardadas.
    final prefs = _preferencias; //usamos .getInstance() para obtener los datos guardados de las preferencias.

    //guardamos la fecha como string.
    prefs.setString(nombreDatoFecha, fecha);
  }

  //recuperamos la fecha de la ultima apertura.
  String? obtenerUltimaApertura() {

    //buscamos la fecha
    return _preferencias.getString(nombreDatoFecha);
  }

//creamos la variable con el nombre para guardar el número de aperturas.
  static const String nombreDatoAperturas = 'numeroAperturas';

  //creamos método para guardar el número de aperturas.
  void guardarNumeroAperturas(int numero) {
    final prefs = _preferencias;

    prefs.setInt(nombreDatoAperturas, numero);
  }

//recuperamos el número de aperturas.
  int obtenerNumeroAperturas() {
    final prefs = _preferencias;
    return prefs.getInt(nombreDatoAperturas) ?? 0;
  }

  void aumentarNumeroAperturar() {

    //recuperamos el número guardado.
    int aperturas = obtenerNumeroAperturas();

    //sumamos apertura cuando se abra.
    aperturas += 1;

    //guardamos el nuvo número de aperturas.
    guardarNumeroAperturas(aperturas);
  }

  //registramos la fecha actual.
void registrarApertura() {

    //obtenemos la fehca y hora actuales.
  DateTime ahora = DateTime.now();

  //indicamos el formato de fecha.
  DateFormat formato = DateFormat('dd-MM-yyyy HH:mm:ss');

  //convertimos la fecha en texto.
  String fecha = formato.format(ahora);

  //usamos el método anterior para guardar la fecha.
  guardarUltimaApertura(fecha);
}
  //nombre con el que guardaremos el tema oscuro.
  static const String nombreDatoTema = 'temaOscuro';

  //guardamos si el modo oscuro está activado o no.
  void guardarTemaOscuro(bool temaOscuro) {
    _preferencias.setBool(nombreDatoTema, temaOscuro);
  }

  //recuperamos el modo oscuro guardado.
  bool obtenerTemaOscuro() {
    return _preferencias.getBool(nombreDatoTema) ?? false;
  }

  //nombre con el que guardamos el tamaño de la letra que el usuario ha seleccionado.
  static const String nombreDatoTamanoLetra = 'tamanoLetra';

  //guardamos el tamaño de letra seleccionado.
  void guardarTamanoLetra(double tamano) {
    _preferencias.setDouble(nombreDatoTamanoLetra, tamano);
  }

  //recuperamos el tamaño de la letra guardado.
  double obtenerTamanoLetra() {
    return _preferencias.getDouble(nombreDatoTamanoLetra) ?? 14;
  }

  //nombre con el que guardamos la opcion para ocultar hábitos.
  static const String nombreDatoOcultar = 'ocultarCompletados';

  //guardamos si queremos ocultar los hábitos ocmpletados.
  void guardarOcultarCompletados(bool ocultar) {
    _preferencias.setBool(nombreDatoOcultar, ocultar);
  }

  //recuperamos la opción de ocultar hábitos.
  bool obtenerOcultarCompletados() {
    return _preferencias.getBool(nombreDatoOcultar) ?? false;
  }
}
