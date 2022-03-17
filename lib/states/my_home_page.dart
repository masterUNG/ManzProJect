import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myproject/mylocation.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy HH:mm');
    String formattedDate = formatter.format(now);
    return Scaffold(
      appBar: newAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, right: 10, left: 10, bottom: 10),
          width: double.infinity,
          child: Column(
            children: [
              Card(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.deepPurpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  "เวลาเข้างาน",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurpleAccent,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '08:00',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const VerticalDivider(
                              width: 20,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Column(
                              children: const [
                                Text(
                                  "เวลาออกงาน",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.deepPurpleAccent,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "17:00",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.red,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                elevation: 3,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  AppBar newAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: const Icon(Icons.fingerprint),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => GetlocationPage()));
          },
        ),
      ],
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(0)),
          // border: Border.all(width: 15, color: Colors.white),
          gradient: LinearGradient(
            colors: [
              Color(0xff6200EA),
              Colors.white,
            ],
            begin: FractionalOffset(0.0, 1.0),
            end: FractionalOffset(1.5, 1.5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurpleAccent,
              spreadRadius: 5,
              blurRadius: 30,
              offset: Offset(5, 3),
            ),
          ],
          // image: DecorationImage(image: NetworkImage('https://www.pngitem.com/pimgs/m/391-3918613_personal-service-platform-person-icon-circle-png-transparent.png'))
        ),
      ),
    );
  }
}
