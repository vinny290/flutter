import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meroio/DB/database.dart';
import 'package:meroio/screens/home_screen.dart';
import 'package:meroio/widgets/widgets.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});
  static const routeName = '/add';

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

   
  // uploadData() async {
  //   Map<String, dynamic> uploaddata = {
  //     'title': _titleController.text,
  //     'shortDesc': _shortDescriptionController.text,
  //     'fullDesc': _fullDescriptionController.text,
  //     'location': _locationController.text,
  //   };

  //   await DatabaseMethods().addMeroDetails(uploaddata);
  //   Fluttertoast.showToast(
  //       msg: "Сохранено",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

  final _titleController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _fullDescriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _selectedDate = DateTime.now();
  final _dateController = TextEditingController();
  bool _isOnlined = false;
  bool _isOfflined = false;

  //Добавляем документ с данными мероприятия


  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future next() async {
    meroInfo(
      _titleController.text.trim(),
      _shortDescriptionController.text.trim(),
      _fullDescriptionController.text.trim(),
      _locationController.text.trim(),
    );
  }

  Future meroInfo(
      String title, String shortDesc, String feullDesc, String geo) async {
        
    await FirebaseFirestore.instance.collection('mero').add({
      'Название': title,
      'Краткое Описание': shortDesc,
      'Полное Описание': feullDesc,
      'Место': geo,
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
                      border: OutlineInputBorder(), labelText: 'Название'),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _shortDescriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Краткое описание'),
                  maxLines: 2,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _fullDescriptionController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Полное описание'),
                  maxLines: 4,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Место проведения'),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor:
                            _isOnlined ? Colors.green : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isOnlined = !_isOnlined;
                          _isOfflined =
                              false; // Сбрасываем выбор для другой кнопки
                        });
                      },
                      child: Text(
                        'Онлайн',
                        style: TextStyle(
                          color: _isOnlined ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor:
                            _isOfflined ? Colors.green : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _isOfflined = !_isOfflined;
                          _isOnlined =
                              false; // Сбрасываем выбор для другой кнопки
                        });
                      },
                      child: Text(
                        'Офлайн',
                        style: TextStyle(
                          color: _isOfflined ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                // Кнопка далее
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

  // Future createMero(Mero mero) async {
  //   final docMero = FirebaseFirestore.instance.collection('mero').doc();
  //   mero.id = docMero.id;

  //   final json = mero.toJson();

  //   await docMero.set(json);
  // }
}
