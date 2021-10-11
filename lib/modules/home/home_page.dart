import 'dart:io';

import 'package:contact_book/shared/helpers/contact_helper.dart';
import 'package:contact_book/shared/models/contact_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    helper.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: contacts.length,
          itemBuilder: _contactCard),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: contacts[index].image != null
                          ? FileImage(File(contacts[index].image))
                          : const AssetImage("assets/image/person.png")
                              as ImageProvider),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contacts[index].name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(contacts[index].email,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(contacts[index].phone,
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
