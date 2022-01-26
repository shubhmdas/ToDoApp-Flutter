import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screens/nav_calendar.dart';
import 'package:todo_app/screens/nav_settings.dart';
import 'package:todo_app/screens/nav_todos.dart';
import 'package:todo_app/services/database.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final String title = 'Home';

  const Home({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final List<Widget> _navPages;
  final _todoController = TextEditingController();
  late String _title;
  late double _width;
  late double _height;
  int _currentIndex = 0;
  bool _isLoading = false;
  bool enableButton = false;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String getDateString() {
    if (_selectedDate == null) {
      return 'SELECT DATE';
    } else {
      String month = _selectedDate!.month < 10
          ? '0${_selectedDate!.month}'
          : _selectedDate!.month.toString();
      String day = _selectedDate!.day < 10
          ? '0${_selectedDate!.day}'
          : _selectedDate!.day.toString();
      return '${_selectedDate!.year}-$month-$day';
    }
  }

  String getTimeString() {
    if (_selectedTime == null) {
      String hour = TimeOfDay.now().hour < 10
          ? '0${TimeOfDay.now().hour}'
          : TimeOfDay.now().hour.toString();
      String minute = TimeOfDay.now().minute + 5 < 10
          ? '0${TimeOfDay.now().minute + 5}'
          : (TimeOfDay.now().minute + 5).toString();
      return '$hour:$minute';
    } else {
      String hour = _selectedTime!.hour < 10
          ? '0${_selectedTime!.hour}'
          : _selectedTime!.hour.toString();
      String minute = _selectedTime!.minute < 10
          ? '0${_selectedTime!.minute}'
          : _selectedTime!.minute.toString();
      return '$hour:$minute';
    }
  }

  @override
  void initState() {
    super.initState();
    _navPages = [
      Todos(auth: widget.auth, firestore: widget.firestore),
      const Calendar(),
      const NavSettings(),
    ];
    _title = widget.title;
  }

  @override
  Widget build(BuildContext context) {
    _width = getConstraints(context).width;
    _height = getConstraints(context).height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(207, 210, 239, 1.0),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(207, 210, 239, 1.0),
          title: Text(
            _title,
            style: const TextStyle(fontFamily: 'Muli', color: Colors.black87, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: _navPages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(207, 210, 239, 1.0),
          currentIndex: _currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color.fromRGBO(167, 168, 172, 1.0),
          elevation: 0,
          onTap: onNavigationItemClick,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.sticky_note_2_sharp), label: 'Todos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Calendar'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => customTodoInputDialog(context),
          backgroundColor: primaryColor.withOpacity(.8),
          splashColor: primaryColor.withOpacity(.8),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  onNavigationItemClick(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        switch (_currentIndex) {
          case 0:
            _title = 'Home';
            break;
          case 1:
            _title = 'Calendar';
            break;
          case 2:
            _title = 'Settings';
            break;
        }
      });
    }
  }

  customTodoInputDialog(context) {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                alignment: Alignment.bottomCenter,
                insetPadding: EdgeInsets.zero,
                titlePadding: EdgeInsets.zero,
                title: Container(
                  width: _width,
                ),
                contentPadding: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(6), topLeft: Radius.circular(6))
                ),
                content: SizedBox(
                  height: _height * .18,
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() => enableButton = true);
                          } else {
                            setState(() => enableButton = false);
                          }
                        },
                        controller: _todoController,
                        autofocus: true,
                        style: const TextStyle(
                            color: Colors.black87, fontFamily: 'Muli'),
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(14, 14, 14, 2),
                            hintText: 'What would you like to do?',
                            filled: false,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Muli',
                                fontWeight: FontWeight.w400)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.pop(context);
                                  showTodoDatePicker(context);
                                },
                                icon: const Icon(
                                  Icons.calendar_today_outlined,
                                  color: primaryColor,
                                ),
                                label: Text(
                                  getDateString(),
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Muli',
                                      fontWeight: FontWeight.w400),
                                ),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(left: 10))),
                              ),
                              TextButton.icon(
                                onPressed: () => showTodoTimePicker(context),
                                icon: const Icon(
                                  Icons.access_time,
                                  color: primaryColor,
                                ),
                                label: Text(
                                  getTimeString(),
                                  style: const TextStyle(
                                      color: primaryColor,
                                      fontFamily: 'Muli',
                                      fontWeight: FontWeight.w400),
                                ),
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.only(left: 10))),
                              ),
                            ],
                          ),
                          IconButton(
                            // disabledColor: primaryColor.withOpacity(.8),
                            onPressed: enableButton ? () async {
                              if (_todoController.text.isNotEmpty) {
                                await Database(firestore: widget.firestore).addTodo(
                                    uid: widget.auth.currentUser!.uid,
                                    content: _todoController.text);
                                setState(() => _todoController.clear());
                              }
                            } : null,
                            icon: const Icon(Icons.send),
                            color: primaryColor,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void showTodoDatePicker(BuildContext context) async {
    // Navigator.of(context).pop();
    _selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 10),
      helpText: 'PICK DATE',
      confirmText: 'SET',
      cancelText: 'CANCEL',
    );
    customTodoInputDialog(context);
  }

  void showTodoTimePicker(BuildContext context) async {
    _selectedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    // customTodoInputDialog(context);
  }
}
