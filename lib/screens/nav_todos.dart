import 'dart:ffi';

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
      StreamBuilder(
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
            List<TodoModel> unfinished = snapshot.data!.where((element) => element.done == false).toList();
            List<TodoModel> finished = snapshot.data!.where((element) => element.done == true).toList();
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                      itemCount: unfinished.length,
                      itemBuilder: (context, index) {
                        return TodoCard(
                          firestore: widget.firestore,
                          todo: unfinished[index],
                          uid: widget.auth.currentUser!.uid,
                          status: 'finished',
                        );
                      }),
                  const SizedBox(height: 20,),
                  if (finished.isNotEmpty) Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 14),
                        child: const Text(
                          'Finished',
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Muli',
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(14, 10, 0, 0),
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: finished.length,
                          itemBuilder: (context, index) {
                            return TodoCard(
                              firestore: widget.firestore,
                              todo: finished[index],
                              uid: widget.auth.currentUser!.uid,
                              status: 'unfinished',
                            );
                          }),
                    ],
                  )
                ],
              ),
            );
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
      ),
      if (isLoading) const Loading(),
    ]);
  }
}
