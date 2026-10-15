import 'dart:convert';
import 'dart:ui';

class Habito {
  late int identificador;
  late String nombre;
  late Color color;
  late DateTime fechaCompletado;

  Habito(this.identificador, this.nombre, this.color, this.fechaCompletado);

  Habito.fromJson(String json) {
    final data = jsonDecode(json);

    identificador = data['identificador'];
    nombre = data['nombre'];
    color = data['color'];
    fechaCompletado = data['fechaCompletado'];
  }

  String toJson() {
    final data = {
      'identificador': identificador,
      'nombre': nombre,
      'color': color,
      'fechaCompletado': fechaCompletado,
    };
    return jsonEncode(data);
  }
}
