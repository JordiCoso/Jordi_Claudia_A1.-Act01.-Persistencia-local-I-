import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/ajustes.dart';
import 'package:persistencialocalapp/screens/estadisticas.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {

  //preparamos flutter para utilizar las preferencias.
  WidgetsFlutterBinding.ensureInitialized();

  //creamos un objeto de nuestro servicio.
  PreferenciasService preferencias = new PreferenciasService();

  //aumentamos el número de aperturas.
  await preferencias.aumentarNumeroAperturar();

  //guardamos la fecha de apertura.
  await preferencias.registrarApertura();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'HabitosApp',
      home: const PantallaInicio(),
    );
  }
}

//pantalla principal de prueba.
class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HabitosApp'),
      ),

      body: Center(
        child: Column(
          children: [

            //botón para estadísticas.
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaEstadisticas(),
              ),
              );
            },
              child: Text('Estadísticas.'),
            ),

            SizedBox(height: 24),

            //botón ajustes.
            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => PantallaAjustes(),
              ),
              );
            },

              child: Text('Ajustes'),
            ),
          ],
        ),
      ),
    );
  }
}