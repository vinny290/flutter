import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  final user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future nextButton() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //details

    //details
    await meroFirstDetails(
      _titleController.text.trim(),
      _shortDescriptionController.text.trim(),
      _fullDescriptionController.text.trim(),
      _locationController.text.trim(),
      [],
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddSecondScreen()),
    );
  }

  Future<void> meroFirstDetails(String title, String shortDesc, String fullDesc,
      String geo, List<dynamic> questions) async {
    String email = user.email!;
    CollectionReference meroCollection = FirebaseFirestore.instance
        .collection(
            email) // Замените 'users' на ваш путь к коллекции пользователей
        .doc('Созданные Меро')
        .collection(title);

    // Создаем новый документ
    await meroCollection.doc().set({
      'title': title,
      'shortDesc': shortDesc,
      'fullDesc': fullDesc,
      'location': geo,
      'Вопросы': questions,
    });
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
                    onTap: nextButton,
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
