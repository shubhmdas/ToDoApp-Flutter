import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/loading.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Todos extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Todos({Key? key, required this.auth, required this.firestore}) : super(key: key);

  @override
  _TodosState createState() => _TodosState();
}

class _TodosState extends State<Todos> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Database(firestore: widget.firestore)
                  .streamTodos(widget.auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TodoModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'You don\'t have any unfinished todos',
                        style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Muli',
                            fontSize: 18.0,
                            fontWeight: FontWeight.w100),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return TodoCard(
                          firestore: widget.firestore,
                          todo: snapshot.data![index],
                          uid: widget.auth.currentUser!.uid,
                        );
                      });
                } else {
                  return const Center(
                    child: Text(
                      'Loading...',
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Muli',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w100),
                    ),
                  );
                }
              },
            ))],
      ),
      if (isLoading) const Loading(),
    ]);
  }
}
