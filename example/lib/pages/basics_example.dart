import 'package:flutter/material.dart';
import 'package:horizontal_calendar_and_datepicker/horizontal_calendar_and_datepicker.dart';
import 'package:intl/intl.dart';
import "package:jiffy/jiffy.dart";

class BasicCalender extends StatefulWidget {
  @override
  _BasicCalenderState createState() => _BasicCalenderState();
}

class _BasicCalenderState extends State<BasicCalender> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  bool doff = true;
  int day = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ValueNotifier(_focusedDay);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                day += 1;
                _focusedDay = DateTime.now().subtract(Duration(days: day));
                _selectedDay = _focusedDay;

                ValueNotifier(_focusedDay);
                setState(() {});
              },
              icon: Icon(Icons.arrow_back)),
          title: Text('TableCalendar - Basics'),
          actions: [
            IconButton(
                onPressed: () {
                  day += 1;
                  _focusedDay = DateTime.now().add(Duration(days: day));
                  ValueNotifier(_focusedDay);
                },
                icon: Icon(Icons.arrow_forward))
          ],
        ),
        // body: CustomCalender(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Card(
                child: TableCalendar(
                  LeftIcon: Image(image: AssetImage("assets/left_chevron.png")),
                  RightIcon: Image(
                    image: AssetImage("assets/right_chevron.png"),
                  ),
                  rowHeight: 60,
                  firstDay: DateTime.utc(2000, 01, 01),
                  lastDay: DateTime.utc(2100, 01, 01),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  leftchevronsize: 12,
                  rightchevronsize: 12,
                  isfuturedaydisable: false,
                  calendarStyle: CalendarStyle(
                      dayPadding: 4,
                      confirmButtonStyle: TextStyle(),
                      cancelButtonStyle: TextStyle(),
                      selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: "Gordita",
                          fontWeight: FontWeight.w500),
                      defaultTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: "Gordita",
                          fontWeight: FontWeight.w500),
                      // defaultTextStyle: TextStyle(color: Color(0xffa5a5a5)),
                      disabledTextStyle: const TextStyle(
                          color: Color(0xff555555),
                          fontSize: 14.0,
                          fontFamily: "Gordita",
                          fontWeight: FontWeight.w500),
                      weekendTextStyle: TextStyle(
                          color: Color(0xff555555),
                          fontSize: 14.0,
                          fontFamily: "Gordita",
                          fontWeight: FontWeight.w500),
                      selectedDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.991, -0.253),
                          end: const Alignment(-1.8, 0.55),
                          colors: <Color>[
                            const Color(0xffac0860),
                            const Color(0xff791162),
                            const Color(0xce49004b).withOpacity(.95)
                          ],
                          stops: const <double>[0, 0.316, 1],
                          tileMode: TileMode.mirror,
                        ),
                        border: Border.all(
                          color: Colors.deepPurple,
                        ),
                        shape: BoxShape.circle,
                      ),
                      isTodayHighlighted: doff,
                      todayDecoration: BoxDecoration(
                          color: Color(0xff007fbb), shape: BoxShape.circle)),
                  headerStyle: HeaderStyle(
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      headerMargin: EdgeInsets.only(left: 10),
                      formatButtonVisible: false,
                      leftChevronPadding: EdgeInsets.all(0),
                      rightChevronPadding: EdgeInsets.all(0)),
                  selectedDayPredicate: (day) {
                    debugPrint("_selectedDay: $_selectedDay day: $day, ");
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    debugPrint("Hello, " + selectedDay.day.toString());
                    debugPrint("Hello1, " + focusedDay.day.toString());
                    // if (context.mounted) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      doff = false;
                    });
                    // }
                  },
                  availableGestures: AvailableGestures.horizontalSwipe,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(
                          color: Color(0xffa5a5a5), fontFamily: "Gordita"),
                      weekdayStyle:
                          TextStyle(color: Colors.black, fontFamily: "Gordita"),
                      dowTextFormatter: ((date, locale) {
                        return "${(DateFormat('E').format(date).toUpperCase())}";
                      })),
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onHeaderTapped: (focusedDay) {
                    setState(() {
                      DValue[0]["Month"] =
                          Jiffy(focusedDay, "yyyy-mm-dd mm:hh:ssZ")
                              .format("MMMM");
                      DValue[0]["Year"] =
                          Jiffy(focusedDay, "yyyy-mm-dd mm:hh:ssZ")
                              .format("yyyy")
                              .toString();
                    });
                  },
                  onPageChanged: (focusedDay) {
                    setState(() {
                      _focusedDay = focusedDay;
                    });

                    ValueNotifier(_focusedDay);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class CustomCalender extends StatefulWidget {
//   const CustomCalender({Key? key}) : super(key: key);

//   @override
//   State<CustomCalender> createState() => _CustomCalenderState();
// }

// class _CustomCalenderState extends State<CustomCalender> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [],
//     );
//   }
// }
