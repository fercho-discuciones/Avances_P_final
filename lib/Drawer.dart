// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('FerchoVaz'),
            accountEmail: Text('@Developer and owner permissions'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.black,
              child: Text(
                'F',
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
    );
  }
}