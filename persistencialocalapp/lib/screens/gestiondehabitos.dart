import 'package:flutter/material.dart';
import 'package:persistencialocalapp/screens/bienvenida.dart';
import 'package:persistencialocalapp/screens/principal.dart';
import 'package:persistencialocalapp/services/PreferenciasService.dart';

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
  List<String> mylist = [];

  _GestiondehabitosState() {
    for (int i = 0; i < 5; i++) {
      mylist.add('item $i');
    }
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
                itemCount: mylist.length,
                prototypeItem: ListTile(title: Text(mylist.first)),
                itemBuilder: (context, index) {
                  return ListTile(title: Text(mylist[index]));
                },
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (context) => Bienvenida(
                        preferenciasService: widget._preferenciasService,
                      ),
                    ),
                  );
                },
                child: const Text('Go back!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
