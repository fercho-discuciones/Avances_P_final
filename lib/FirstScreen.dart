// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, dead_code, unused_label, import_of_legacy_library_into_null_safe, avoid_print, prefer_final_fields, override_on_non_overriding_member, unused_field, annotate_overrides, must_be_immutable, non_constant_identifier_names, unused_element, prefer_equal_for_default_values, deprecated_member_use, prefer_const_constructors_in_immutables, unused_local_variable, await_only_futures, unnecessary_null_comparison, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:proyectofinal001/CreateNote.dart';
import 'package:proyectofinal001/Theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String _texto = '';
  List<Nota> notas=[];
  void addNote() async {
    var data = await Navigator.push(context, MaterialPageRoute(builder: (context) => Import()));
    if (data != null){
      Nota nota = Nota(data['title'], data['cont'], data['them']);
      setState(() => notas.add(nota));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agenda")),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('JOSE'),
              accountEmail: Text('@EQUIPO DE PROGRAMACION'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text(
                  'J',
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('AMAZON'),
              leading: Icon(Icons.car_rental),
              onTap: () {
                launch("https://www.amazon.com.mx/");
              }
            ),
            ListTile(
              title: Text('STEREN'),
              leading: Icon(Icons.phone_android),
              onTap: () {
                launch("https://www.steren.com.mx/");
              },
            ),
            ListTile(
              title: Text('GOGLE DRIVE'),
              leading: Icon(Icons.book_online),
              onTap: () {
                launch("https://drive.google.com/");
              },
            ),
            Divider(),
            ListTile(
              title: Text('GOGLE MAPS'),
              leading: Icon(Icons.book_online),
              onTap: () {
                launch("https://www.google.com.mx/maps");
              },
            ),
            Divider(),
            ListTile(
              title: Text('INGRESAR'),
              leading: Icon(Icons.one_k_plus),
              onTap: () {
                //   _onSelectItem(1);
              },
            ),
            ListTile(
              title: Text('SALIR'),
              leading: Icon(Icons.book_online),
              onTap: () {
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNote(),
        child: Icon(Icons.add, color: Colors.blueGrey),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.start,
          children:<Widget>[
            TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: selectedDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
              onDaySelected: (DateTime selectDay, DateTime focusDay){
                setState((){
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusDay);
              },
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format){
                setState((){
                  format = _format;
                });
              },
              calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: blueCharcoal,
                  shape: BoxShape.circle
                ),
                todayDecoration: BoxDecoration(
                  color: blueSaphire,
                  shape: BoxShape.circle
                ),
                selectedTextStyle: TextStyle(color: Colors.white),
              ),
              selectedDayPredicate: (DateTime date){
                return isSameDay(selectedDay, date);
              },
              headerStyle: HeaderStyle(
                titleCentered: true,
                titleTextStyle: TextStyle(fontSize: 17.5)
              ),
            ),

            /*Text(_texto),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Editar'),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => EditScreen(_texto),
                ))
                    .then((result) {
                  if (result != null) {
                    setState(() {
                      _texto = result;
                    });
                  }
                });
              },
            )*/
            ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: notas.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10.0),
                  color: notas[index].color,
                  child: Column(
                    children: <Widget>[
                      Text(notas[index].titulo,style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 20),
                      Text(notas[index].descripcion ,style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.left,),
                    ]
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider()
            )
      ]))
    );
  }
}

class Nota{
  String titulo = "";
  String descripcion = "";
  Color color = Color(0xffF90A0A);

  Nota(this.titulo, this.descripcion, this.color);

}

class EditScreen extends StatefulWidget {
  final String texto;
  EditScreen(this.texto);
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.texto);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EDITA EL TEXTO'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
            child: Column(
          children: <Widget>[
            TextField(controller: _controller),
            RaisedButton(
              child: Text('GUARDAR'),
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
            )
          ],
        )),
      ),
    );
  }
}