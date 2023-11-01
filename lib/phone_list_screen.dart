import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_app/db_helper.dart';
import 'package:phone_app/phone.dart';

class PhoneListScreen extends StatefulWidget {
  const PhoneListScreen({super.key});

  @override
  State<PhoneListScreen> createState() => _PhoneListScreenState();
}

class _PhoneListScreenState extends State<PhoneListScreen> {
  late Phone _deletedPhone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DbHelper.getPhones(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final phone = snapshot.data?[index];
                return ListTile(
                  title: Text(phone?.phoneName ?? "",style: TextStyle(fontSize: 30),),
                  leading: Text((index + 1).toString(),style: TextStyle(fontSize: 30)),
                  onTap: () {
                    _showPhoneDetails(phone!);
                  },
                  trailing: IconButton(
                    onPressed: () {
                      _deletedPhone = phone!;
                      DbHelper.delete(phone.id).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Deleted"), action: SnackBarAction(
                            onPressed: () async {
                              await DbHelper.savePhone(_deletedPhone);
                              setState(() {

                              });
                            },
                            label: "Undo",
                          ),)
                        );
                        setState(() {});
                      });
                    },
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          } else {
            return Center(child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator());
          }
        },
      ),
    );
  }
  void _showPhoneDetails(Phone phone) {
    final name = TextEditingController(text: phone.phoneName);
    final detail = TextEditingController(text: phone.phoneDetail);
    showModalBottomSheet(context: context, builder: (context) => SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
          TextField(
            controller: name,
          ) ,
          const SizedBox(height: 20),
            TextField(
              controller: detail,
            ) ,
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              DbHelper.update(phone.id, Phone(null, name.text, detail.text)).then((value)  {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Updated$value")));
                Navigator.of(context).pop();
                setState(() {

                });
              });
            }, child: Text("Update"))
        ],),
      ),
    ));
  }
}
