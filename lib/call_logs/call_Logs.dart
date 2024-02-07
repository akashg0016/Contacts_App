import 'package:call_log/call_log.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:call_log_access_app/call_log_model.dart';

class CallLogsService {
  // Function to make a phone call
  Future<void> call(String phoneNumber) async {
    bool res = await FlutterPhoneDirectCaller.callNumber(phoneNumber);
  }

  // Function to get avatar based on call type
  Widget getAvatar(CallType callType) {
    switch (callType) {
      case CallType.outgoing:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.green,
          backgroundColor: Colors.greenAccent,
        );
      case CallType.missed:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.red[400],
          backgroundColor: Colors.red[400],
        );
      default:
        return CircleAvatar(
          maxRadius: 30,
          foregroundColor: Colors.indigo[700],
          backgroundColor: Colors.indigo[700],
        );
    }
  }

  // Function to retrieve call logs
  Future<List<CallLogEntry>> getCallLogs() async {
    List<CallLogEntry> callLogs = [];
    try {
      Iterable<CallLogEntry> entries = await CallLog.get();
      callLogs = entries.toList();
    } catch (e) {
      print("Error fetching call logs: $e");
    }
    return callLogs;
  }

  // Function to format date
  String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y H:m:s').format(dt);
  }

  // Function to get title for call log entry
  Widget getTitle(CallLogEntry entry) {
    if (entry.name == null) return Text(entry.number);
    if (entry.name.isEmpty)
      return Text(entry.number);
    else
      return Text(entry.name);
  }

  // Function to get formatted time duration
  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formattedDuration = "";
    if (d1.inHours > 0) {
      formattedDuration += d1.inHours.toString() + "h ";
    }
    if (d1.inMinutes > 0) {
      formattedDuration += d1.inMinutes.toString() + "m ";
    }
    if (d1.inSeconds > 0) {
      formattedDuration += d1.inSeconds.toString() + "s";
    }
    if (formattedDuration.isEmpty) return "0s";
    return formattedDuration;
  }
}
