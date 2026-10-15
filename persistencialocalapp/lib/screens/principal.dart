import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

import '../models/habito.dart';
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
  late List<Habito> listaHabitos = widget._preferenciasService.cargarHabitos();

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
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: listaHabitos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      '${listaHabitos[index].identificador} ${listaHabitos[index].nombre} ${listaHabitos[index].fechaCompletado}',
                      style: TextStyle(color: listaHabitos[index].color),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),

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
            ],
          ),
        ),
      ),
    );
  }
}
