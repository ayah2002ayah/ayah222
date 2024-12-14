import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() => runApp(ayah());

class ayah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ayah',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String ayah_email;
  late String ayah_username;
  late String ayah_password;
  late String ayah_phone;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome to your page'),
        titleTextStyle: TextStyle(
          color: Color(0xBA60443D),
          fontSize: 30,
        ),
        backgroundColor: Color(0xFFBDA27F), // تغيير لون الشريط العلوي إلى البني
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/5.jpg'),
            fit: BoxFit.cover, // لجعل الصورة تغطي الخلفية بالكامل
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Color(0xFFBDA27F)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBDA27F)), // لون الحدود
                        borderRadius: BorderRadius.circular(10), // زوايا مستديرة
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onSaved: (value) => ayah_username = value!,
                  ),
                  SizedBox(height: 20), // إضافة مسافة بين الحقول
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Color(0xFFBDA27F)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBDA27F)), // لون الحدود
                        borderRadius: BorderRadius.circular(10), // زوايا مستديرة
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (!RegExp(r'^\d{9}$').hasMatch(value)) {
                        return 'Phone number must be 9 digits';
                      }
                      return null;
                    },
                    onSaved: (value) => ayah_phone = value!,
                  ),
                  SizedBox(height: 20), // إضافة مسافة بين الحقول
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xFFBDA27F)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBDA27F)), // لون الحدود
                        borderRadius: BorderRadius.circular(10), // زوايا مستديرة
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
                        return 'Password must be at least 8 characters long and include letters, numbers, and symbols';
                      }
                      return null;
                    },
                    obscureText: true,
                    onSaved: (value) => ayah_password = value!,
                  ),
                  SizedBox(height: 20), // إضافة مسافة بين الحقول
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Color(0xFFBDA27F)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFBDA27F)), // لون الحدود
                        borderRadius: BorderRadius.circular(10), // زوايا مستديرة
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) => ayah_email = value!,
                  ),

                  SizedBox(height: 20), // إضافة مسافة بين الحقول
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        // Implement your login logic here
                        print('Email: $ayah_email');
                        print('Username: $ayah_username');
                        print('Password: $ayah_password');
                        print('Phone Number: $ayah_phone');
                        // الانتقال إلى الصفحة الثانية مع البيانات
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SecondPage(email: ayah_email, username: ayah_username, password: ayah_password, phone: ayah_phone)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFBDA27F),
                      foregroundColor: Colors.brown,
                    ),
                    child: Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String email;
  final String username;
  final String password;
  final String phone;

  const SecondPage({required this.email, required this.username, required this.password, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("information of your account"),
        titleTextStyle: TextStyle(
          color: Color(0xFFBDA27F),
          fontSize: 30,
        ),
        backgroundColor: Colors.brown, // تغيير لون الشريط العلوي إلى البني
      ),
      body: Container(
        color: Color(0xFFBDA27F), // تغيير لون الخلفية إلى البني
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/5.jpg', // إضافة الصورة في أعلى الصفحة
                width: 200,
                height: 200,
              ),
              Text(
                "",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Username: $username",
                            style: TextStyle(fontSize: 24, color: Colors.brown, fontFamily: 'Roboto'),
                          ),
                          Text(
                            "Phone Number: $phone",

                            style: TextStyle(fontSize: 24, color: Colors.brown, fontFamily: 'Roboto'),
                          ),
                          Text(
                            "Password: $password",
                            style: TextStyle(fontSize: 24, color: Colors.brown, fontFamily: 'Roboto'),
                          ),
                          Text(
                            "Email: $email",
                            style: TextStyle(fontSize: 24, color: Colors.brown, fontFamily: 'Roboto'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
