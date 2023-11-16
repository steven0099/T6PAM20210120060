import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
final String uname;
HomePage({Key? key, required this.uname}) : super(key: key);
@override
Widget build(BuildContext context) {
return Scaffold(
body: Padding(
padding: const EdgeInsets.all(8.0),
child: Column(
mainAxisAlignment: MainAxisAlignment.center,
children: [
Center(
child: Text(
"Selamat Datang: " + uname,
style: TextStyle(
color: Colors.green,
fontSize: 25.0,
fontWeight: FontWeight.bold,
),
),
)
],
),
),
);
}
}