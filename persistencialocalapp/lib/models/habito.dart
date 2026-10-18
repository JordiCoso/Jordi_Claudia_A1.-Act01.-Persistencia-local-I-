import 'dart:convert';
import 'dart:ui';

class Habito {
  late int identificador;
  late String nombre;
  late Color color;
  late DateTime fechaCompletado;
  bool completado = false;
  int rachaActual = 0;
  int diasCompletados = 0;

  Habito(this.identificador, this.nombre, this.color, this.fechaCompletado);

  /* Esto es un constructor ya que queremos crear un habito del json.
   * Asi evitamos que se pueda crear un habito vacio.
   * Siempre deberiamos querer crear uno de un json
   * o con el constructor de arriba.
   */
  Habito.fromJson(String json) {
    // El json devuelve un dynamic que en este caso es una lista con llaves string.
    final data = jsonDecode(json);

    identificador = data['identificador'];
    nombre = data['nombre'];
    /* Json no puede guardar un tipo color asi que hicimos una lista.
     * El orden es 0 = alpha, 1 = rojo, 2 = verde, 3 = azul.
     */
    color = Color.from(
      alpha: data['color'][0],
      red: data['color'][1],
      green: data['color'][2],
      blue: data['color'][3],
      colorSpace: ColorSpace.sRGB, // Es el que Color() tiene predeterminado.
    );

    // Tenemos que usar DateTime para pasar el string a un DateTime.
    fechaCompletado = DateTime.parse(data['fechaCompletado']);

    completado = data['completado'];
    rachaActual = data['rachaActual'] ?? 0;
    diasCompletados = data['diasCompletados'] ?? 0;
  }

  String toJson() {
    // Tenemos que convertir el color a una lista de valores.
    final colorJsonable = _convertirAJsonCompatible();

    final data = {
      'identificador': identificador,
      'nombre': nombre,
      'color': colorJsonable,
      'fechaCompletado': fechaCompletado.toString(),
      'completado': completado,
      'rachaActual': rachaActual,
      'diasCompletados': diasCompletados,
    };

    return jsonEncode(data);
  }

  // Para convertirlo a una lista añadimos cada parametro de color uno a uno.
  List<double> _convertirAJsonCompatible() {
    List<double> colorJsonable = [];
    // Hay que recordar el orden cuando lo extraigamos.
    colorJsonable.add(color.a);
    colorJsonable.add(color.r);
    colorJsonable.add(color.g);
    colorJsonable.add(color.b);

    return colorJsonable;
  }

  void actualizarRacha() {
    DateTime hoy = DateTime.now();

    //comprobamos si se ha completado hoy
    if (fechaCompletado.year == hoy.year &&
        fechaCompletado.month == hoy.month &&
        fechaCompletado.day == hoy.day) {
      return;
    }

    diasCompletados++;

    //creamos variable para la fecha de ayer para hacer la comprobacion
    DateTime ayer = DateTime(hoy.year, hoy.month, hoy.day - 1);

    //comprobamos tambien si se completó ayer
    if (fechaCompletado.year == ayer.year &&
        fechaCompletado.month == ayer.month &&
        fechaCompletado.day == ayer.day) {
      rachaActual++;
    } else {
      rachaActual =
          1; //si no se completó el dia anterior se crea una racha nueva.
    }

    fechaCompletado = hoy; //actualizamos para que quede la ultima fecha.
  }

  int obtenerRacha() {
    DateTime hoy = DateTime.now();
    DateTime ayer = DateTime(hoy.year, hoy.month, hoy.day - 1);

    if ((fechaCompletado.year == hoy.year &&
            fechaCompletado.month == hoy.month &&
            fechaCompletado.day == hoy.day) ||
        (fechaCompletado.year == ayer.year &&
            fechaCompletado.month == ayer.month &&
            fechaCompletado.day == ayer.day)) {
      return rachaActual;
    }
    return 0; //si han pasado mas dias, la racha vuelve a 0.
  }
}
