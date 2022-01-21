import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/loading.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Home extends StatefulWidget {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  bool isLoading = false;

  Home({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToDo App',
          style: TextStyle(fontFamily: 'Muli'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                setState( () => widget.isLoading = true );
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
      body: Stack(children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Add your todos here',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Muli',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Muli',
                                fontWeight: FontWeight.w200),
                            controller: _controller,
                            decoration: const InputDecoration(
                                border: InputBorder.none))),
                    IconButton(
                        onPressed: () async {
                          if (_controller.text.isEmpty) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              'A todo can\'t be empty!',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontFamily: 'Muli',
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold),
                            )));
                          } else {
                            await Database(firestore: widget.firestore).addTodo(
                                uid: widget.auth.currentUser!.uid,
                                content: _controller.text.trim());
                            _controller.clear();
                          }
                        },
                        icon: const Icon(Icons.add)),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            const Text(
              'Your Todos',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Muli',
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
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
                            color: Colors.white,
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
                          color: Colors.white,
                          fontFamily: 'Muli',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w100),
                    ),
                  );
                }
              },
            ))
          ],
        ),
        if (widget.isLoading) const Loading(),
      ]),
    );
  }
}
