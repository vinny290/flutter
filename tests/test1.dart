import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:meroio/widgets/widgets.dart';
import 'package:intl/intl.dart';
import '../addScreens.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});
  static const routeName = '/add';

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController shortDescriptionController = TextEditingController();
  TextEditingController fullDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool isOnlined = false;
  bool isOfflined = false;

  late String informName,
      informShortDescription,
      informFullDescription,
      informGeo;

  getInformName(name) {
    this.informName = name;
  }

  getInformShortDescription(shortDescription) {
    this.informShortDescription = shortDescription;
  }

  getInformFullDescription(fullDescription) {
    this.informFullDescription = fullDescription;
  }

  getInformGeo(geo) {
    this.informGeo = geo;
  }

  Future<void> createData() async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('My Mero')
          .doc(titleController.text);

      Map<String, dynamic> informData = {
        'name': titleController.text,
        'shortDescription': shortDescriptionController.text,
        'fullDescription': fullDescriptionController.text,
        'location': locationController.text,
      };

      await documentReference.set(informData);
      print("Data added successfully");
    } catch (error) {
      print("Failed to add data: $error");
    }
  }

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  // Новый контроллер для даты

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
                    controller: titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Название'),
                    onChanged: (String name) {
                      getInformName(name);
                    },
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: shortDescriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Краткое описание'),
                    onChanged: (String shortDescription) {
                      getInformShortDescription(shortDescription);
                    },
                    maxLines: 2,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: fullDescriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Полное описание'),
                    onChanged: (String fullDescription) {
                      getInformFullDescription(fullDescription);
                    },
                    maxLines: 4,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Место проведения'),
                    onChanged: (String geo) {
                      getInformGeo(geo);
                    },
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
                              isOnlined ? Colors.green : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isOnlined = !isOnlined;
                            isOfflined =
                                false; // Сбрасываем выбор для другой кнопки
                          });

                          // Логика для кнопки "Онлайн"
                        },
                        child: Text(
                          'Онлайн',
                          style: TextStyle(
                            color: isOnlined ? Colors.white : Colors.black,
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
                              isOfflined ? Colors.green : Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isOfflined = !isOfflined;
                            isOnlined =
                                false; // Сбрасываем выбор для другой кнопки
                          });

                          // Логика для кнопки "Онлайн"
                        },
                        child: Text(
                          'Офлайн',
                          style: TextStyle(
                            color: isOfflined ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: dateController,
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                        locale: const Locale(
                          'ru',
                          'RU',
                        ),
                      );

                      if (pickedDate != null) {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          pickedDate = DateTime(
                            pickedDate.year,
                            pickedDate.month,
                            pickedDate.day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );

                          setState(() {
                            selectedDate = pickedDate!;
                            dateController.text =
                                '${DateFormat('dd MMMM yyyy HH:mm', 'ru').format(selectedDate.toLocal())}';
                          });
                        }
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Дата и время',
                    ),
                    onChanged: (String date) {
                      // getInformDate(date);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        await createData();
                        // Создаем Map с данными

                        // Преобразуем Map в JSON

                        // Добавляем данные в базу данных
                        // try {
                        //   await _databaseReference
                        //       .child('events')
                        //       .push()
                        //       .set(jsonEventData);
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //           'Данные успешно добавлены в базу данных.'),
                        //     ),
                        //   );
                        // } catch (error) {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //           'Ошибка при добавлении данных в базу данных: $error'),
                        //     ),
                        //   );
                        // }

                        // Переход на следующий экран
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => AddSecondScreen()),
                        // );
                      },
                      child: Text('Далее')),
                ],
              ),
            ),
          ),
        ));
  }
}
