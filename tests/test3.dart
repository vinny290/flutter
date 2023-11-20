import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meroio/screens/add_screens.dart/second_screen.dart';
import 'package:meroio/widgets/widgets.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);
  static const routeName = '/add';

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _titleController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _fullDescriptionController = TextEditingController();
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<String?> getCurrentUserUID() async {
    final user = FirebaseAuth.instance.currentUser;
    return user?.email;
  }

  Future<void> next() async {
    String title = _titleController.text.trim();
    String shortDesc = _shortDescriptionController.text.trim();
    String fullDesc = _fullDescriptionController.text.trim();
    String location = _locationController.text.trim();

    if (title.isEmpty ||
        shortDesc.isEmpty ||
        fullDesc.isEmpty ||
        location.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in all fields');
      return;
    }

    final userUID = await getCurrentUserUID();

    if (userUID != null) {
      await meroInfo(userUID, title, shortDesc, fullDesc, location, []);

      Navigator.pushReplacementNamed(
        context,
        AddSecondScreen.routeName,
        arguments: FirstPageData(
          title: title,
          shortDescription: shortDesc,
          fullDescription: fullDesc,
          location: location,
        ),
      );
    } else {
      Fluttertoast.showToast(msg: 'User not logged in');
    }
  }

  Future<void> meroInfo(
    String email,
    String title,
    String shortDesc,
    String fullDesc,
    String geo,
    List<Map<String, dynamic>> firestoreQuestions,
  ) async {
    try {
       String email = FirebaseAuth.instance.currentUser!.email!;
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection(email);


      await FirebaseFirestore.instance
          .collection(email)
          .doc('созданные мероприятия')
          .collection(title)
          .doc(title)
          .set({
        'Название': title,
        'Краткое Описание': shortDesc,
        'Полное Описание': fullDesc,
        'Место': geo,
        'Вопросы': firestoreQuestions,
      });
      Fluttertoast.showToast(msg: 'Data added to Firestore successfully');
    } catch (e) {
      print('Error adding document to Firestore: $e');
      Fluttertoast.showToast(msg: 'Error adding document to Firestore');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(index: 2),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'МЕРО Информация',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Название',
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _shortDescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Краткое описание',
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _fullDescriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Полное описание',
                  ),
                  maxLines: 4,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Место проведения',
                  ),
                ),
                SizedBox(height: 20),
                // Row with online/offline buttons
                // ... (your existing code for online/offline buttons)
                SizedBox(height: 20),
                // Next button
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: next,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text(
                          'Далее',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstPageData {
  String title;
  String shortDescription;
  String fullDescription;
  String location;

  FirstPageData({
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.location,
  });
}
