import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginfit/models/exercise.dart';

import '../widgets/exercise_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Map<String, dynamic>> exercises = [];

  // getExercises() {
  //   List<Map<String, dynamic>> list = [];
  //
  //   var db = FirebaseFirestore.instance;
  //   db.collection("exercises").get().then(
  //     (querySnapshot) {
  //       print("Successfully completed");
  //       for (var docSnapshot in querySnapshot.docs) {
  //         list.add(docSnapshot.data());
  //       }
  //       setState(() {
  //         exercises = list;
  //       });
  //     },
  //     onError: (e) => print("Error completing: $e"),
  //   );
  // }

  // @override
  // void initState() {
  //   // getExercises();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("exercises").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: [
              ...snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                return ExerciseWidget(
                  exercise: Exercise.fromMap(data),
                ); // 👈 Your valid data here
              }).toList()
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              TextEditingController nameController = TextEditingController();
              TextEditingController imageController = TextEditingController();
              TextEditingController countController = TextEditingController();
              TextEditingController descriptionController =
                  TextEditingController();
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(hintText: "Name"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: descriptionController,
                        decoration:
                            const InputDecoration(hintText: "description"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: countController,
                        decoration: const InputDecoration(hintText: "counts"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: imageController,
                        decoration: const InputDecoration(hintText: "image"),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          String name = nameController.text;
                          String image = imageController.text;
                          String count = countController.text;
                          String description = descriptionController.text;

                          var db = FirebaseFirestore.instance;

                          Exercise exercise = Exercise(
                              name: name,
                              count: int.parse(count),
                              image: image,
                              description: description);

                          // Map<String, dynamic> exercise = {
                          //   'name': name,
                          //   'description': description,
                          //   'image': image,
                          //   'count': int.parse(count)
                          // };

                          await db
                              .collection('exercises')
                              .doc(name)
                              .set(exercise.toMap());

                          Navigator.pop(context);
                        },
                        child: const Text('add exercise'))
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
