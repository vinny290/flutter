import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meroio/screens/add_screens.dart/third_screen.dart';
import 'package:meroio/widgets/question_widget.dart';

class Question {
  String titleSec;
  bool isRequired;

  Question({required this.titleSec, required this.isRequired});

  Map<String, dynamic> toMap() {
    return {
      'titleSec': titleSec,
      'isRequired': isRequired,
    };
  }
}

class AddSecondScreen extends StatefulWidget {
  const AddSecondScreen({Key? key}) : super(key: key);

  static const routeName = '/add_sec';

  @override
  State<AddSecondScreen> createState() => _AddSecondScreenState();
}

class _AddSecondScreenState extends State<AddSecondScreen> {
  final TextEditingController titleController = TextEditingController();
  List<Question> questions = [];

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    questions.add(Question(titleSec: 'ФИО', isRequired: true));
    questions.add(Question(titleSec: 'Email', isRequired: true));
    questions.add(Question(titleSec: 'Телефон', isRequired: true));
  }

  Future nextSecondButton(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //questions
    await meroSecondDetails(
      titleController.text.trim(),
      questions,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddThirdScreen()),
    );
  }

  Future<void> meroSecondDetails(String title, List<Question> questions) async {
    String email = FirebaseAuth.instance.currentUser!.email!;
    // Replace this with your actual document ID

    // Create a reference to the questions collection
    CollectionReference questionsCollection = FirebaseFirestore.instance
        .collection(email)
        .doc('Созданные Меро')
        .collection(title)
        .doc()
        .collection('Вопросы');

    // Add each question to the questions collection
    for (Question question in questions) {
      await questionsCollection.doc().set(question
          .toMap()); // Replace with your actual sub-collection document ID
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'МЕРО Информация',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Текст перед анкетой регистрации',
              ),
            ),
            SizedBox(height: 20),
            Text('Вопросы анкеты'),
            SizedBox(height: 10),
            Column(
              children: questions.map((question) {
                return QuestionWidget(
                  question: question,
                  onDelete: () {
                    setState(() {
                      questions.remove(question);
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      questions.add(Question(
                        titleSec: '',
                        isRequired: true,
                      ));
                    });
                  },
                  icon: Icon(Icons.add),
                  label: Text('Добавить вопрос'),
                ),
                SizedBox(height: 20),
                // Next button
                Padding(
                  padding:
                      const EdgeInsetsDirectional.symmetric(horizontal: 25),
                  child: GestureDetector(
                    onTap: () => nextSecondButton(context),
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
          ],
        ),
      ),
    );
  }
}
