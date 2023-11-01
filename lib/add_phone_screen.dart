import 'package:flutter/material.dart';
import 'package:phone_app/db_helper.dart';
import 'package:phone_app/phone.dart';

class AddPhoneScreen extends StatefulWidget {
  const AddPhoneScreen({super.key});

  @override
  State<AddPhoneScreen> createState() => _AddPhoneScreenState();
}

class _AddPhoneScreenState extends State<AddPhoneScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _detail = TextEditingController();

  void _savePhone() {
    final phone = Phone(null, _name.text, _detail.text);
    DbHelper.savePhone(phone).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved")));
    });
    _name.text = "";
    _detail.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: _savePhone, icon: const Icon(Icons.check))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _name,
              decoration: InputDecoration(
                hintText: 'Phone Name'
              ),
            ),
            Expanded(
              child: TextField(
                controller: _detail,
                decoration: InputDecoration(
                    hintText: 'Phone Detail'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
