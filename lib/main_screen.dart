import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_app/add_phone_screen.dart';
import 'package:phone_app/phone_list_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => PhoneListScreen()));
          }, child: const Text("Phone List")),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: () {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => AddPhoneScreen()));
          }, child: const Text("Add New Phone")),
        ],
      ),
    );
  }
}
