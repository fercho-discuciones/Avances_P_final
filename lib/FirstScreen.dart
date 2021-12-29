// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, dead_code, unused_label, import_of_legacy_library_into_null_safe, avoid_print, prefer_final_fields, override_on_non_overriding_member, unused_field, annotate_overrides, must_be_immutable, non_constant_identifier_names, unused_element, prefer_equal_for_default_values, deprecated_member_use, prefer_const_constructors_in_immutables, unused_local_variable, await_only_futures, unnecessary_null_comparison, prefer_const_literals_to_create_immutables, unused_import, prefer_adjacent_string_concatenation

import 'package:flutter/material.dart';
import 'package:proyectofinal001/CreateNote.dart';
import 'package:proyectofinal001/Theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Drawer.dart';

class FirstScreen extends StatefulWidget {

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void initState() {
    super.initState();
    mostrar_datos();
  }

  int indexa = 0;
  changevalue() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(()=>indexa++);
    prefs.setInt('value',indexa);
  }

  CalendarFormat format = CalendarFormat.week;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  String _texto = '';

  List<Nota> notas = [
    //Nota("Nota guardada","contenido guardado",Color(0xffAED581)),
  ];

  List<String> nums=[];

  void addNote() async {
    var data = await Navigator.push(context, MaterialPageRoute(builder: (context) => Import()));
    if (data != null){
      Nota nota = Nota(data['title'], data['cont'], data['them'],indexa);
      setState(()=> notas.add(nota));
      setState(()=> nums.add('$indexa'));
      guardar_datos(data['title'], data['cont'], data['them'], indexa);
      guardar_lista(nums);
      changevalue();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agenda")),
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addNote(),
        child: Icon(Icons.add, color: blueSaphire),
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
            ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: notas.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index){
                //guardar_index(index);
                return Dismissible(
                  key: ObjectKey(nums[index]),
                  child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(10.0),
                  color: notas[index].color,
                  child: Column(
                    children: <Widget>[
                      Text(notas[index].titulo,style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 20),
                      Text(notas[index].descripcion ,style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.left,),
                      SizedBox(height: 20),
                      ElevatedButton(onPressed: ()=> print(notas[index].llave), child: Text('$index'))
                    ]
                    ),
                  ),
                onDismissed: (direction){
                  setState(() {
                    notas.removeAt(index);
                    nums.removeAt(index);
                    guardar_lista(nums);
                  });
                },
                );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider()
            )
      ]))
    );
  }

  mostrar_datos() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    indexa = prefs.getInt('value') ?? 0;

    //int inde = await prefs.getInt('index')??0;
    nums = await prefs.getStringList('list')??[];
    for(String i in nums){
      String tit = await prefs.getString('titulo'+i)??"";
      String not = await prefs.getString('contenido'+i)??"";
      String colstr = await prefs.getString('testcolor'+i)??"";
      int val = await prefs.getInt('intcolor'+i)??0;
      int borrar = await prefs.getInt('value'+i)??0;

      Color otherColor = Color(val);

      Nota nota = Nota(tit, not, otherColor, indexa);
      setState(()=> notas.add(nota)
      );
    }
  }

  Future guardar_datos(String titulo, String contenido, Color color, int inde) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Color colors = color;
    String colorString = colors.toString();
    String valueString = colorString.split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);

    await prefs.setString('titulo'+'$inde', titulo);
    await prefs.setString('contenido'+'$inde', contenido);
    await prefs.setString('testcolor'+'$inde', valueString);
    await prefs.setInt('intcolor'+'$inde',value);
    //indexa++;
  }

  /*guardar_index(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setInt('index',index);
  }*/

  guardar_lista(List<String> list) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('list', list);
  }

}

class Nota{
  String titulo = "";
  String descripcion = "";
  Color color = Color(0xffF90A0A);
  int llave = 0;

  Nota(this.titulo, this.descripcion, this.color, this.llave);
}


