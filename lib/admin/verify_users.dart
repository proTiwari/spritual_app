import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class VerifyUsers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: UsersList(),
    );
  }
}

class UsersList extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('users')
          .orderBy('registrationDate')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final registrationDate =
                documents[index].get('registrationDate') as Timestamp;
            final formattedDate = registrationDate.toDate().toString();

            return ListTile(
              title: Text(documents[index].get('name') ?? ''),
              subtitle: Text('Registration Date: $formattedDate'),
              trailing: GestureDetector(
                  onTap: () {
                    _firestore
                        .collection('users')
                        .doc(documents[index].id)
                        .update({'verified': true});
                  },
                  child: Text(
                      "Verified: ${documents[index].get('verified')}" ?? '', style:documents[index].get('verified')==true? TextStyle(color: Colors.green):TextStyle(color: Colors.red) ,)),
              // Add more user information as needed.
            );
          },
        );
      },
    );
  }
}
