import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  void onClickedAdd() {
    setState(() {
      counter++;
    });
  }

  void onClickedSub() {
    setState(() {
      counter--;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.indigo,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click Counter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              Text(
                '$counter',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: onClickedAdd,
                      icon: const Icon(
                        Icons.add_box,
                        color: Colors.white,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: onClickedSub,
                      icon: const Icon(
                        Icons.indeterminate_check_box,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
