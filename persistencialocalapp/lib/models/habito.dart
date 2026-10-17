import 'dart:convert';
import 'dart:js_interop';
import 'dart:ui';

class Habito {
  late int identificador;
  late String nombre;
  late Color color;
  late DateTime fechaCompletado;
  bool completado = false;

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
  }

  String toJson() {
    final colorJsonable = _convertirAJsonCompatible();

    final data = {
      'identificador': identificador,
      'nombre': nombre,
      'color': colorJsonable,
      'fechaCompletado': fechaCompletado.toString(),
      'completado': completado,
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
}
