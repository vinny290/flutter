import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music/model/user.dart';
import 'package:music/pages/user_info_page.dart';

class RegisterFormPage extends StatefulWidget {
  const RegisterFormPage({Key? key}) : super(key: key);

  @override
  State<RegisterFormPage> createState() => _RegisterFormPageState();
}

class _RegisterFormPageState extends State<RegisterFormPage> {
  bool _hidePass = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  List<String> _countries = ['Russia', 'Belarus', 'Moldova', 'China'];
  String _selectedCountry = 'Russia';

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passFocus = FocusNode();

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TextFormField(
              focusNode: _nameFocus,
              autofocus: true,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _nameFocus, _phoneFocus);
              },
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Full Name*',
                hintText: 'What people call you?',
                prefixIcon: Icon(Icons.person),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _nameController.clear();
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              validator: _validateName,
              onSaved: (value) => newUser.name = value!,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _phoneFocus,
              onFieldSubmitted: (_) {
                _fieldFocusChange(context, _phoneFocus, _passFocus);
              },
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone number*',
                hintText: 'Number your phone',
                helperText: 'Phone format: (XXX)XXX-XXXX',
                prefixIcon: Icon(Icons.call),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _phoneController.clear();
                  },
                  child: Icon(Icons.delete_outline, color: Colors.red),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.black, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                //FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                    allow: true)
              ],
              validator: (value) => _validatePhoneNumber(value),
              onSaved: (value) => newUser.phone = value!,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'email',
                hintText: 'Enter your E-mail',
                icon: Icon(Icons.mail),
              ),
              keyboardType: TextInputType.emailAddress,
              //validator: _validateEmail,
              onSaved: (value) => newUser.email = value!,
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.map),
                labelText: 'Country?',
              ),
              items: _countries.map((country) {
                return DropdownMenuItem(
                  child: Text(country),
                  value: country,
                );
              }).toList(),
              onChanged: (country) {
                print(country);
                setState(() {
                  _selectedCountry = country as String;
                  newUser.country = country;
                });
              },
              value: _selectedCountry,
              // Убеждаемся, что _selectedCountry не равно null
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _storyController,
              decoration: InputDecoration(
                labelText: 'Biography*',
                hintText: 'Tell about your self',
                helperText: 'Keep it short',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(100),
              ],
              onSaved: (value) => newUser.story = value!,
            ),
            SizedBox(height: 10),
            TextFormField(
              focusNode: _passFocus,
              controller: _passController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Password*',
                hintText: 'Enter the password',
                suffixIcon: IconButton(
                  icon:
                      Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _hidePass = !_hidePass;
                    });
                  },
                ),
                icon: Icon(Icons.security),
              ),
              validator: _validatePassword,
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _confirmPassController,
              obscureText: _hidePass,
              maxLength: 8,
              decoration: InputDecoration(
                labelText: 'Confirm Password*',
                hintText: 'Confirm the password',
                icon: Icon(Icons.border_color),
              ),
              validator: _validatePassword,
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _submitForm,
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green)),
              child: Text(
                'Submit Form',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('email: ${_emailController.text}');
      print('Country: ${_selectedCountry}');
      print('story: ${_storyController.text}');
    } else {
      _showMessage(message: 'form is not valid');
    }
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Name contains invalid characters';
    }
    return null; // Вернуть null для успешной валидации
  }

  String? _validatePhoneNumber(String? input) {
    final _phoneExp = RegExp(r'^\(\d{3}\)\d{3}-\d{4}$');
    if (input == null || !input.contains(_phoneExp)) {
      return 'Phone number is not format: (XXX)XXX-XX-XX';
    }
    return null; // Вернуть null для успешной валидации
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid Email adress';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || _passController.text.length != 8) {
      return '8 characters required for password';
    } else if (_confirmPassController.text != _passController.text) {
      return 'Password does not match';
    }

    return null;
  }

  void _showMessage({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
      ),
    ));
  }

  void _showDialog({required String name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Registration siccessful',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            content: Text(
              '$name is now a verified refister form',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserInfoPage(
                          userInfo: newUser,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Verified',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                    ),
                  ))
            ],
          );
        });
  }
}
