import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

import '../models/habito.dart';
import '../models/usuario.dart';

class Gestiondehabitos extends StatefulWidget {
  final PreferenciasService _preferenciasService;
  final Usuario _usuario;

  const Gestiondehabitos({
    super.key,
    required this._preferenciasService,
    required this._usuario,
  });

  @override
  State<Gestiondehabitos> createState() => _GestiondehabitosState();
}

class _GestiondehabitosState extends State<Gestiondehabitos> {
  late List<Habito> listaHabitos = widget._preferenciasService.cargarHabitos();
  Map<int, TextEditingController> textEditingControllers = {};
  Map<int, bool> editables = {};

  @override
  void dispose() {
    textEditingControllers.forEach((index, controller) => controller.dispose());
    textEditingControllers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctxt) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestionar habitos')),
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
                itemCount: listaHabitos.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    margin: EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            controller: _darControllador(index),
                            enabled: _darEditable(index),
                            onEditingComplete: () {
                              setState(() {
                                editables[index] = !editables[index]!;
                              });
                            },
                          ),
                        ),

                        ElevatedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            setState(() {
                              editables[index] = !editables[index]!;
                            });
                          },
                        ),
                        ElevatedButton(
                          child: Text('Remove'),
                          onPressed: () {
                            setState(() {
                              textEditingControllers[index]?.dispose();
                              textEditingControllers.remove(index);
                              listaHabitos.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: Text('Crear'),
                onPressed: () {
                  setState(() {
                    listaHabitos.add(''); // TODO lista separada o null??
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController _darControllador(int index) {
    TextEditingController controllador =
        textEditingControllers[index] ?? TextEditingController();

    textEditingControllers[index] = controllador;

    return controllador;
  }

  bool _darEditable(int index) {

    bool editable = editables[index] ?? false;

    editables[index] = editable;

    return editable;
  }
}
