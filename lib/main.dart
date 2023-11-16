// ignore_for_file: no_leading_underscores_for_local_identifiers,use_key_in_widget_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'home.dart';
void main() {
runApp(MyApp());
}
class MyApp extends StatelessWidget {
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Demo Login',
debugShowCheckedModeBanner: false,
theme: ThemeData(
primarySwatch: Colors.blue,
primaryColor: Color.fromRGBO(9, 255, 0, 1),
hintColor: Colors.orange[600],
visualDensity: VisualDensity.adaptivePlatformDensity,
),
home: MyHomePage(title: 'Demo Login'),
);
}
}
class MyHomePage extends StatefulWidget {
MyHomePage({Key? key, required this.title}) : super(key: key);
final String title;
@override
_MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
//For LinearProgressIndicator.
bool _visible = false;
//Controller untuk Pengeditan Teks dalam Input Nama Pengguna dan Kata Sandi
final userController = TextEditingController();
final pwdController = TextEditingController();
Future userLogin() async {
//Login API URL
//dan gunakan alamat IP lokal atau localhost atau gunakan API Web
String url = "http://192.168.27.121/restapi/login/flutterlogin/user_login.php";
setState(() {
_visible = true;
});
// Mendapatkan nama pengguna dan kata sandi dari Controller
var data = {
'username': userController.text,
'password': pwdController.text,
};
//Memulai Panggilan WEB API.
var response = await http.post(Uri.parse(url), body: json.encode(data));
if (response.statusCode == 200) {
//Server response into variable
print(response.body);
var msg = jsonDecode(response.body);
//Cek Status Login
if (msg['loginStatus'] == true) {
setState(() {
//Menghide seluruh progress indicator
_visible = false;
});
// Navigate ke Tampilan Home Screen
Navigator.push(
context,
MaterialPageRoute(
builder: (context) =>
HomePage(uname: msg['userInfo']['NAME'])));
} else {
setState(() {
//Menghide progress indicator
_visible = false;
//Tampilkan jika ada Error Message Dialog
showMessage(msg["message"]);
});
}
} else {
setState(() {
//Menghide progress indicator
_visible = false;
//Tampilkan Error Message Dialog
showMessage("Error during connecting to Server.");
});
}
}
Future<dynamic> showMessage(String _msg) async {
showDialog(
context: context,
builder: (BuildContext context) {
return AlertDialog(
title: new Text(_msg),
actions: <Widget>[
TextButton(
child: new Text("OK"),
onPressed: () {
Navigator.of(context).pop();
},
),
],
);
},
);
}
final _formKey = GlobalKey<FormState>();
@override
Widget build(BuildContext context) {
return SafeArea(
child: Scaffold(
body: SingleChildScrollView(
scrollDirection: Axis.vertical,
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.center,
children: [
Visibility(
visible: _visible,
child: Container(
margin: EdgeInsets.only(bottom: 10.0),
child: LinearProgressIndicator(),
),
),
Container(
height: 100.0,
),
Icon(
Icons.group,
color: Theme.of(context).primaryColor,
size: 80.0,
),
SizedBox(
height: 10.0,
),
Text(
'Login Here',
style: TextStyle(
color: Theme.of(context).primaryColor,
fontSize: 25.0,
fontWeight: FontWeight.bold),
),
SizedBox(
height: 40.0,
),
Form(
key: _formKey,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
children: [
Theme(
data: new ThemeData(
primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
hintColor:
Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
),
child: TextFormField(
controller: userController,
decoration: InputDecoration(
focusedBorder: new OutlineInputBorder(
borderSide: BorderSide(
color: Color.fromRGBO(84, 87, 90, 0.5),
style: BorderStyle.solid,
),
),
enabledBorder: new OutlineInputBorder(
borderSide: BorderSide(
color: Color.fromRGBO(84, 87, 90, 0.5),
style: BorderStyle.solid,
),
),
errorBorder: new OutlineInputBorder(
borderSide: BorderSide(
color: Colors.red,
width: 1.0,
style: BorderStyle.solid,
),
),
labelText: 'Enter User Name',
prefixIcon: const Icon(
Icons.person,
color: Color.fromRGBO(84, 87, 90, 0.5),
),
border: new OutlineInputBorder(
borderSide: BorderSide(
color: Color.fromRGBO(84, 87, 90, 0.5),
style: BorderStyle.solid,
),
),
hintText: 'User Name',
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please Enter User Name';
}
return null;
},
),
),
SizedBox(
height: 20.0,
),
Theme(
data: new ThemeData(
primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
hintColor:
Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
),
child: TextFormField(
controller: pwdController,
obscureText: true,
decoration: InputDecoration(
focusedBorder: new OutlineInputBorder(
borderSide: BorderSide(
color: Color.fromRGBO(84, 87, 90, 0.5),
style: BorderStyle.solid,
),
),
enabledBorder: new OutlineInputBorder(
borderSide: BorderSide(
color: Color.fromRGBO(84, 87, 90, 0.5),
style: BorderStyle.solid,
),
),
errorBorder: new OutlineInputBorder(
borderSide: BorderSide(
color: Colors.red,
width: 1.0,
style: BorderStyle.solid,
),
),
border: new OutlineInputBorder(
borderSide: BorderSide(
color: Color.fromRGBO(84, 87, 90, 0.5),
style: BorderStyle.solid,
),
),
labelText: 'Enter Password',
prefixIcon: const Icon(
Icons.lock,
color: Color.fromRGBO(84, 87, 90, 0.5),
),
hintText: 'Password',
),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please Enter Password';
}
return null;
},
),
),
SizedBox(
height: 20.0,
),
Padding(
padding: const EdgeInsets.all(8.0),
child: ElevatedButton(
onPressed: () => {
// Validate returns true if the form is valid, or false otherwise.
if (_formKey.currentState!.validate())
{userLogin()}
},
child: Padding(
padding: EdgeInsets.all(16.0),
child: Text(
'Submit',
style: TextStyle(fontSize: 18.0),
),
),
style: ButtonStyle(
backgroundColor: MaterialStateProperty.all<Color>(
Theme.of(context).primaryColor),
),
),
),
],
),
),
),
],
),
),
));
}
}