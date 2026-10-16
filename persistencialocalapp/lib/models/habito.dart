import 'dart:convert';
import 'dart:js_interop';
import 'dart:ui';

class Habito {
  late int identificador;
  late String nombre;
  late Color color;
  late DateTime fechaCompletado;

  List<double> _colorJsonable = [];

  Habito(this.identificador, this.nombre, this.color, this.fechaCompletado);

  Habito.fromJson(String json) {
    print(json);
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
  }

  String toJson() {
    _colorJsonable.add(color.a);
    _colorJsonable.add(color.r);
    _colorJsonable.add(color.g);
    _colorJsonable.add(color.b);

    final data = {
      'identificador': identificador,
      'nombre': nombre,
      'color': _colorJsonable,
      'fechaCompletado': fechaCompletado.toString(),
    };

    return jsonEncode(data);
  }
}
