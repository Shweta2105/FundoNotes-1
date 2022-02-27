import 'package:flutter/material.dart';
import 'package:fundonotes/models/common/constants.dart';
import 'package:intl/intl.dart';
import 'package:fundonotes/resources/notificationplugins.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({Key? key}) : super(key: key);

  @override
  _AddReminderState createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  DateTime selectDateTime = DateTime.now();

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd- HH:mm');

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.white70,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "Add Reminder",
              style: TextStyle(fontSize: 30, color: textcolor),
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              title: Text("Select Date and Time"),
              onTap: () {
                _showDialog(context);
              },
            ),
          ],
        ));
  }

  void _showDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton(
                          onPressed: () async {
                            final selectDate =
                                await _selectDate(selectDateTime);
                            if (selectDate == null) return;
                            print(selectDate);

                            setState(() {
                              selectDateTime = DateTime(
                                  selectDate.year,
                                  selectDate.month,
                                  selectDate.day,
                                  selectDateTime.hour,
                                  selectDateTime.minute);
                            });
                          },
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(selectDateTime),
                            style: TextStyle(
                                fontSize: 20,
                                color: textcolor,
                                fontWeight: FontWeight.normal),
                          )),
                      FlatButton(
                          onPressed: () async {
                            final selectTime =
                                await _selectTime(selectDateTime);
                            if (selectTime == null) return;
                            print(selectTime);

                            setState(() {
                              selectDateTime = DateTime(
                                  selectDateTime.year,
                                  selectDateTime.month,
                                  selectDateTime.day,
                                  selectTime.hour,
                                  selectTime.minute);
                            });
                          },
                          child: Text(
                            DateFormat('HH-mm').format(selectDateTime),
                            style: TextStyle(
                                fontSize: 20,
                                color: textcolor,
                                fontWeight: FontWeight.normal),
                          )),
                    ],
                  ),
                  RaisedButton(
                      child: Text('Save reminder'),
                      onPressed: () {
                        notificationPlugins
                            .scheduleNotification(selectDateTime);
                        Navigator.pop(context);
                      })
                ],
              ),
            ),
          );
        });
  }

  Future<DateTime?> _selectDate(DateTime initialdate) {
    return showDatePicker(
      context: context,
      initialDate: initialdate.add(Duration(seconds: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _selectTime(DateTime initialTime) {
    return showTimePicker(
        context: context,
        initialTime:
            TimeOfDay(hour: initialTime.hour, minute: initialTime.minute));
  }
}
