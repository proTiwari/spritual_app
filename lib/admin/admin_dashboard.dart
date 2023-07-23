import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore/admin/verify_users.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../enumerations.dart';
import 'create_calender_event.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
      ),
      body: EventList(),
    );
  }
}

class EventList extends StatefulWidget {
  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  CalendarView _selectedView = CalendarView.month;

  void _setView(CalendarView view) {
    if (view != _selectedView && mounted) {
      setState(() {
        _selectedView = view;
      });
    }
  }

  List eventlist = ['Verify Users', 'Create Events', 'Add Into Gallery'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: eventlist.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (eventlist[index] == 'Verify Users') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => VerifyUsers()),
              );
            }
            if (eventlist[index] == 'Create Events') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => CalendarConfig(
                          onViewChange: _setView,
                          currentView: _selectedView,
                        )),
              );
            }
            if (eventlist[index] == 'Add Info Gallery') {}
          },
          child: ListTile(
            title: Text('${eventlist[index]}'),
          ),
        );
      },
    );
  }
}
