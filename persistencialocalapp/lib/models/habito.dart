import 'dart:convert';
import 'dart:js_interop';
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

  Habito.fromJson(String json) {
    final data = jsonDecode(json);

    identificador = data['identificador'];
    nombre = data['nombre'];
    color = Color.from(
      alpha: data['color'][0],
      red: data['color'][1],
      green: data['color'][2],
      blue: data['color'][3],
      colorSpace: ColorSpace.sRGB,
    );
    fechaCompletado = DateTime.parse(data['fechaCompletado']);

    completado = data['completado'];
    rachaActual = data['rachaActual'] ?? 0;
    diasCompletados = data['diasCompletados'] ?? 0;
  }

  String toJson() {
    final colorJsonable = _convertirAJsonCompatible();

    final data = {
      'identificador': identificador,
      'nombre': nombre,
      'color': colorJsonable,
      'fechaCompletado': fechaCompletado.toString(),
      'completado': completado,
      'rachaActual' : rachaActual,
      'diasCompletados': diasCompletados,
    };

    return jsonEncode(data);
  }

  List<double> _convertirAJsonCompatible() {
    List<double> colorJsonable = [];

    colorJsonable.add(color.a);
    colorJsonable.add(color.r);
    colorJsonable.add(color.g);
    colorJsonable.add(color.b);

    return colorJsonable;
  }

  void actualizarRacha() {
    DateTime hoy = DateTime.now();

    //comprobamos si se ha completado hoy
    if(fechaCompletado.year == hoy.year && fechaCompletado.month == hoy.month && fechaCompletado.day == hoy.day) {
      return;
    }

    diasCompletados++;

    //creamos variable para la fecha de ayer para hacer la comprobacion
    DateTime ayer = DateTime(hoy.year, hoy.month, hoy.day - 1);

    //comprobamos tambien si se completó ayer
    if(fechaCompletado.year == ayer.year && fechaCompletado.month == ayer.month && fechaCompletado.day == ayer.day) {
      rachaActual++;
    } else {
      rachaActual = 1; //si no se completó el dia anterior se crea una racha nueva.
    }

    fechaCompletado = hoy; //actualizamos para que quede la ultima fecha.
  }

  int obtenerRacha() {
    DateTime hoy = DateTime.now();
    DateTime ayer = DateTime(hoy.year, hoy.month, hoy.day - 1);

    if((fechaCompletado.year == hoy.year && fechaCompletado.month == hoy.month && fechaCompletado.day == hoy.day) ||
        (fechaCompletado.year == ayer.year && fechaCompletado.month == ayer.month && fechaCompletado.day == ayer.day)) {
      return rachaActual;
    }
    return 0; //si han pasado mas dias, la racha vuelve a 0.
  }
}
