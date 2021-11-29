// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:proyectofinal001/Theme.dart';

class Import extends StatefulWidget {
  @override
  State<Import> createState() => _ImportState();
}

class _ImportState extends State<Import> {
  String titulo = "",nota = "";
  Color? _color=Color(0xffF90A0A),selectedColor = Color(0xffF90A0A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Crea nueva nota")),
      body:Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //height: 300,
      color: whitee,
      child: Form(
        child: Column(
          children: <Widget>[
            Text('Titulo'),
            TextFormField(
              onChanged: (value){
                setState(() {
                  titulo = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Titulo'),
            ),
            Text('Nota'),
            TextFormField(
              onChanged: (value){
                setState(() {
                  nota = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Nota',
              )
            ),
            Text('Color'),
            DropdownButton<Color>(
              hint: Text("Hola"),
              value: selectedColor,
              onChanged: (color) {
                setState(() {
                  selectedColor = color;
                  _color = selectedColor;
                });
              },
              // ignore: prefer_const_literals_to_create_immutables
              items: [
                DropdownMenuItem(
                  value: Color(0xffF90A0A),
                  child: Text("Rojo")
                ),
                DropdownMenuItem(
                  value: Color(0xffF9F32F),
                  child: Text("Amarillo"),
                ),
                DropdownMenuItem(
                  value: Color(0xff6FF71D),
                  child: Text("Verde"),
                ),
                DropdownMenuItem(
                  value: Color(0xff19D6D8),
                  child: Text("Azul"),
                ),
                DropdownMenuItem(
                  value: Color(0xffBF65EB),
                  child: Text("Morado"),
                ),
                DropdownMenuItem(
                  value: Color(0xffE77ECD),
                  child: Text("Rosa"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:[
                ElevatedButton(onPressed: (){
                  print(titulo);
                  print(nota);
                  var data = {'title': titulo,'cont': nota, 'them':_color};
                  Navigator.pop(context, data);},
                child: Text("Aceptar",style: TextStyle(color: whitee)),
                style: ElevatedButton.styleFrom(primary: blueSaphire)
                ),
                SizedBox(width: 10),
                ElevatedButton(onPressed: (){Navigator.pop(context);},
                child: Text("Cancelar",style: TextStyle(color: whitee)),
                style: ElevatedButton.styleFrom(primary: blueSaphire)
                )
              ]
            )
          ],)
          ),
    ));
  }
}
