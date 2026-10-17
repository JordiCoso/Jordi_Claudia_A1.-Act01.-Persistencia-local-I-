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
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _darControllador(index),
                            enabled: _darEditable(index),
                            onEditingComplete: () {
                              setState(() {
                                editables[index] = !editables[index]!;
                                _editarHabito(index);
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _cambiarColorHabito(index, Color(0xFFFFC067));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFFFC067),
                          ),
                          child: Text(''),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _cambiarColorHabito(index, Color(0xFF6CCCC4));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6CCCC4),
                          ),
                          child: Text(''),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _cambiarColorHabito(index, Color(0xFF807B44));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF807B44),
                          ),
                          child: Text(''),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          child: Text('Edit'),
                          onPressed: () {
                            setState(() {
                              editables[index] = !editables[index]!;
                              if (!editables[index]!) _editarHabito(index);
                            });
                          },
                        ),
                        SizedBox(width: 10),
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
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Crear'),
                onPressed: () {
                  setState(() {
                    listaHabitos.add(
                      Habito(
                        listaHabitos.length,
                        'Habito nuevo #${listaHabitos.length}',
                        Color(0xFF0000FF),
                        DateTime(0),
                      ),
                    );
                  });
                },
              ),
              SizedBox(height: 30),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () {
                  widget._preferenciasService.guardarHabitos(listaHabitos);
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

    controllador.text = listaHabitos[index].nombre;

    textEditingControllers[index] = controllador;
    return controllador;
  }

  bool _darEditable(int index) {
    bool editable = editables[index] ?? false;

    editables[index] = editable;

    return editable;
  }

  void _editarHabito(int index) {
    Habito habito = listaHabitos[index];

    habito.nombre = textEditingControllers[index]?.text ?? '';

    habito = Habito(index, habito.nombre, habito.color, habito.fechaCompletado);
  }

  void _cambiarColorHabito(int index, Color color) {
    listaHabitos[index].color = color;
  }
}
