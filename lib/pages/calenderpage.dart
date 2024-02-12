import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ScreenCalendar(),
    );
  }
}

class ScreenCalendar extends StatefulWidget {
  const ScreenCalendar({Key? key}) : super(key: key);

  @override
  _ScreenCalendarState createState() => _ScreenCalendarState();
}

class _ScreenCalendarState extends State<ScreenCalendar> {
  late DateTime _selectedDate;
  List<Map<String, dynamic>> _events = []; // List to store events

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  void _addEvent(
      String title, DateTime date, TimeOfDay startTime, TimeOfDay endTime) {
    setState(() {
      _events.add({
        'title': title,
        'date': date,
        'startTime': startTime,
        'endTime': endTime,
      });
    });
  }

  void _deleteEvent(int index) {
    setState(() {
      _events.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Expanded(
                  child: CalendarPage(
                    selectedDate: _selectedDate,
                    onDateSelected: (DateTime date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 410.0),
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task',
                      style: GoogleFonts.lato(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    ..._events.asMap().entries.map((entry) {
                      final index = entry.key;
                      final event = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: EventItem(
                          event: event,
                          onDelete: () => _deleteEvent(index),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0, bottom: 250),
              child: MyCustomButton(onEventAdded: _addEvent),
            ),
          ),
        ],
      ),
    );
  }
}

class EventItem extends StatelessWidget {
  final Map<String, dynamic> event;
  final VoidCallback onDelete;

  const EventItem({
    Key? key,
    required this.event,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey, // Warna latar belakang box event
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                event['title'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            'Date: ${event['date'].toLocal()}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 4),
          Text(
            'Time: ${event['startTime'].format(context)} - ${event['endTime'].format(context)}',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class MyCustomButton extends StatelessWidget {
  final Function(String, DateTime, TimeOfDay, TimeOfDay) onEventAdded;

  const MyCustomButton({Key? key, required this.onEventAdded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 82, 109, 71),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(0.5),
      child: IconButton(
        icon: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 24,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEventPage(
                onEventAdded: onEventAdded,
              ),
            ),
          ).then((result) {
            if (result != null) {
              final title = result['title'];
              final date = result['date'];
              final startTime = result['startTime'];
              final endTime = result['endTime'];
              onEventAdded(title, date, startTime, endTime);
            }
          });
        },
      ),
    );
  }
}

class CalendarPage extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const CalendarPage({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 1),
            child: TableCalendar(
              focusedDay: selectedDate,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              calendarFormat: CalendarFormat.month,
              onFormatChanged: (format) {},
              startingDayOfWeek: StartingDayOfWeek.sunday,
              daysOfWeekVisible: true,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                  color: Color.fromARGB(255, 61, 95, 54),
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: const Color.fromARGB(255, 116, 138, 108),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 99, 124, 90),
                    width: 2.0,
                  ),
                ),
              ),
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                onDateSelected(selectedDay);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewEventPage extends StatefulWidget {
  final Function(String, DateTime, TimeOfDay, TimeOfDay) onEventAdded;

  const NewEventPage({Key? key, required this.onEventAdded}) : super(key: key);

  @override
  _NewEventPageState createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  DateTime _date = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime =
      TimeOfDay.now().replacing(hour: TimeOfDay.now().hour + 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              onSaved: (value) {
                _title = value ?? '';
              },
            ),
            ListTile(
              title: const Text('Date'),
              trailing: TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2030),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _date = pickedDate;
                    });
                  }
                },
                child: Text(
                  '${_date.day}/${_date.month}/${_date.year}',
                ),
              ),
            ),
            ListTile(
              title: const Text('Start Time'),
              trailing: ElevatedButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _startTime,
                  );
                  if (picked != null && picked != _startTime) {
                    setState(() {
                      _startTime = picked;
                    });
                  }
                },
                child: Text(_startTime.format(context)),
              ),
            ),
            ListTile(
              title: const Text('End Time'),
              trailing: ElevatedButton(
                onPressed: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: _endTime,
                  );
                  if (picked != null && picked != _endTime) {
                    setState(() {
                      _endTime = picked;
                    });
                  }
                },
                child: Text(_endTime.format(context)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.pop(context, {
                    'title': _title,
                    'date': _date,
                    'startTime': _startTime,
                    'endTime': _endTime,
                  });
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
