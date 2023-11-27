//First Screen
// ignore_for_file: use_build_context_synchronously

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
  List<Question> questions = [];

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _fullDescriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> nextButton() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    await meroFirstDetails(
      _titleController.text,
      _shortDescriptionController.text,
      _fullDescriptionController.text,
      _locationController.text,
      questions,
    );

    Navigator.pushNamed(
      context,
      AddSecondScreen.routeName,
      arguments:
          ScreenArguments(email: user.email!, title: _titleController.text),
    );
  }

  Future<void> meroFirstDetails(String title, String shortDesc, String fullDesc,
      String geo, List<Question> questions) async {
    String email = user.email!;
    DocumentReference<Map<String, dynamic>> meroCollection = FirebaseFirestore
        .instance
        .collection(email)
        .doc(email)
        .collection('Созданные Меро')
        .doc(title);

    // Создаем новый документ
    await meroCollection.set({
      'title': title,
      'shortDesc': shortDesc,
      'fullDesc': fullDesc,
      'location': geo,
      // 'Вопросы': questions,
    });

    // Add 'Информация о мероприятии' document
    await meroCollection.collection('Информация о мероприятии').add({
      'title': title,
      'shortDesc': shortDesc,
      'fullDesc': fullDesc,
      'location': geo,
    });

    // Add 'Вопросы к мероприятию' document
    // await meroCollection.collection('Вопросы к мероприятию').add({
    //   'questions': questions.map((question) => question.toMap()).toList(),
    // });
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

class ScreenArguments {
  final String email;
  final String title;

  ScreenArguments({required this.email, required this.title});
}
//SecondScreen
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meroio/screens/add_screens.dart/first_screen.dart';
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
  final _questionsController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    _questionsController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    questions.add(Question(titleSec: 'ФИО', isRequired: true));
    questions.add(Question(titleSec: 'Email', isRequired: true));
    questions.add(Question(titleSec: 'Телефон', isRequired: true));
  }

  Future<void> nextSecondButton(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Explicitly cast the arguments to ScreenArguments
    ScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    // Use the title from the ScreenArguments
    await meroSecondDetails(
      FirebaseAuth.instance.currentUser!.email!,
      args.title,
      questions,
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddThirdScreen()),
    );
  }

  Future<void> meroSecondDetails(
      String email, String title, List<Question> questions) async {
    CollectionReference questionsCollection = FirebaseFirestore.instance
        .collection(email)
        .doc(email)
        .collection('Созданные Меро')
        .doc(title)
        .collection('Вопросы к мероприятию');

    // Add each question to the questions collection
    for (Question question in questions) {
      await questionsCollection.add(question.toMap());
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
//main.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meroio/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/addScreens.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  checkIfLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      setState(() {
        isLogin = true;
      });
    }

    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        prefs.setBool('isLoggedIn', true);
        setState(() {
          isLogin = true;
        });
      } else {
        prefs.setBool('isLoggedIn', false);
      }
    });
  }

  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('ru', 'RU'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
          useMaterial3: true,
        ),
        initialRoute: isLogin ? HomeScreen.routeName : SignInScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => const HomeScreen(),
          QrScreen.routeName: (context) => const QrScreen(),
          UserScreen.routeName: (context) => const UserScreen(),
          SignInScreen.routeName: (context) => const SignInScreen(),
          SignUpScreen.routeName: (context) => const SignUpScreen(),
          AddScreen.routeName: (context) => const AddScreen(),
          AddSecondScreen.routeName: (context) => AddSecondScreen(),
          ForgotPasswordPage.routeName: (context) => ForgotPasswordPage(),
        });
  }
}
//homeScreen
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meroio/detailScreen.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});
  static const routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late List<String> eventTitles = [];

  @override
  void initState() {
    super.initState();
    _loadEventTitles();
  }

  Future<void> _loadEventTitles() async {
    String email = user.email!;

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection(email)
          .doc(email)
          .collection('Созданные Меро')
          .get();

      eventTitles = snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('Error loading event titles: $e');
    }

    setState(
        () {}); // Trigger a rebuild to update the UI with the loaded titles
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: const BottomNavBar(index: 2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Привет: ' + user.email!,
              style: TextStyle(fontSize: 20),
            ),
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              child: Text('Sign Out'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: eventTitles.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(eventTitles[index]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailedEventScreen(
                            title: eventTitles[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
