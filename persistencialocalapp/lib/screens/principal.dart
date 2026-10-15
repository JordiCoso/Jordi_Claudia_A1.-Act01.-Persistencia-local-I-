import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';
import 'package:persistencialocalapp/screens/ajustes.dart';
import 'package:persistencialocalapp/screens/estadisticas.dart';

import '../models/usuario.dart';
import 'gestiondehabitos.dart';

class Principal extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Usuario _usuario;

  const Principal({
    super.key,
    required this._preferenciasService,
    required this._usuario,
  });

  @override
  State<Principal> createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  List<String> mylist = [];

  _PrincipalState() {
    for (int i = 0; i < 5; i++) {
      mylist.add('item $i');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menú principal')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hola ${widget._usuario.nombre}',
                style: TextStyle(fontSize: 50),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: mylist.length,
                prototypeItem: ListTile(title: Text(mylist.first)),
                itemBuilder: (context, index) {
                  return ListTile(title: Text(mylist[index]));
                },
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => Gestiondehabitos(
                        preferenciasService: widget._preferenciasService,
                        usuario: widget._usuario,
                      ),
                    ),
                  );
                },
                child: const Text('Gestionar habitos'),
              ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () async {
                  bool? temaOscuro = await Navigator.push<bool> (
                    context, MaterialPageRoute(
                    builder: (context) => PantallaAjustes(preferenciasService: widget._preferenciasService,
                    ),
                  ),
                  );
                },
                child: Text('Ajustes'),
              ),

              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => PantallaEstadisticas(preferenciasService: widget._preferenciasService,
                    ),
                  ),
                  );
                },
                child: Text('Estadísticas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
