import 'package:flutter/material.dart';
import 'package:meroio/screens/add_screens.dart/second_screen.dart';

class AnswerScreen extends StatefulWidget {
  final List<Question> questions;

  const AnswerScreen({Key? key, required this.questions}) : super(key: key);

  @override
  _AnswerScreenState createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  final List<TextEditingController> answerControllers = [];

  @override
  void initState() {
    super.initState();
    // Initialize text controllers for each question
    for (int i = 0; i < widget.questions.length; i++) {
      answerControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    // Dispose of the text controllers
    for (var controller in answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ответы на вопросы'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: widget.questions.length,
          itemBuilder: (context, index) {
            Question question = widget.questions[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Вопрос ${index + 1}: ${question.titleSec}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: answerControllers[index],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ответ',
                  ),
                ),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
