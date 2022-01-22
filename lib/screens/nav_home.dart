import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screens/nav_calendar.dart';
import 'package:todo_app/screens/nav_settings.dart';
import 'package:todo_app/screens/nav_todos.dart';
import 'package:todo_app/services/auth.dart';

class Home extends StatefulWidget {

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String title = 'Home';

  const Home({ Key? key, required this.auth, required this.firestore }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _currentIndex = 0;
  late String _title;
  bool isLoading = false;
  late final List<Widget> navPages;

  @override
  void initState() {
    super.initState();
    navPages = [
      Todos(auth: widget.auth, firestore: widget.firestore),
      const Calendar(),
      const NavSettings(),
    ];
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(204, 205, 236, 1.0),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromRGBO(80, 87, 222, 0.7),
        title: Text(
          _title,
          style: const TextStyle(fontFamily: 'Muli'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                setState( () => isLoading = true );
                var result = await Auth(auth: widget.auth).signOut();
                if (result == 'Success') {

                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          result!,
                          style: const TextStyle(
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.black,
                        elevation: 2,
                      ));
                }
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: navPages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sticky_note_2_sharp), label: 'Todos'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor.withOpacity(.8),
        child: const Icon(Icons.add),
      ),
    );
  }

  onTap(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        switch (_currentIndex) {
          case 0: _title = 'Home';
            break;
          case 1: _title = 'Calendar';
            break;
          case 2: _title = 'Settings';
            break;
        }
      });
    }
  }

}
