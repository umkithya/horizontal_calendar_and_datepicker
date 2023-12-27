// ignore_for_file: unnecessary_null_comparison, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import '../../horizontal_calendar_and_datepicker.dart';

class CalendarHeader extends StatefulWidget {
  final dynamic locale;
  final DateTime focusedMonth;
  final CalendarFormat calendarFormat;
  final HeaderStyle headerStyle;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onHeaderTap;
  final VoidCallback onHeaderLongPress;
  final ValueChanged<CalendarFormat> onFormatButtonTap;
  final Map<CalendarFormat, String> availableCalendarFormats;
  final DayBuilder? headerTitleBuilder;
  final double leftchevronsize;
  final double rightchevronsize;
  final Widget? LeftIcon;
  final Widget? RightIcon;
  const CalendarHeader({
    Key? key,
    this.locale,
    required this.focusedMonth,
    required this.calendarFormat,
    required this.headerStyle,
    required this.onLeftChevronTap,
    required this.onRightChevronTap,
    required this.onHeaderTap,
    required this.onHeaderLongPress,
    required this.onFormatButtonTap,
    required this.availableCalendarFormats,
    this.headerTitleBuilder,
    required this.leftchevronsize,
    required this.rightchevronsize,
    required this.LeftIcon,
    required this.RightIcon,
  }) : super(key: key);

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  @override
  Widget build(BuildContext context) {
    final text = widget.headerStyle.titleTextFormatter
            ?.call(widget.focusedMonth, widget.locale) ??
        DateFormat.yMMMM(widget.locale).format(widget.focusedMonth);

    DValue[0]["Month"] =
        Jiffy(widget.focusedMonth, "yyyy-mm-dd hh:mm:ssZ").format("MMMM");
    DValue[0]["Year"] = Jiffy(widget.focusedMonth, "yyyy-mm-dd hh:mm:ssZ")
        .format("yyyy")
        .toString();
    // _focusedDay= ValueNotifier(DateTime.utc(2015, 3, 3));

    return Container(
      // decoration: widget.headerStyle.decoration,
      // margin:  EdgeInsets.only(top: 10),
      padding: widget.headerStyle.headerPadding,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.headerTitleBuilder?.call(context, widget.focusedMonth) ??
              GestureDetector(
                onTap: widget.onHeaderTap,
                onLongPress: widget.onHeaderLongPress,
                child: Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Text(
                    "${DValue[0]["Month"]}  ${DValue[0]["Year"]}",
                    style: widget.headerStyle.titleTextStyle,
                    textAlign: widget.headerStyle.titleCentered
                        ? TextAlign.center
                        : TextAlign.start,
                  ),
                ),
              ),
          Container(
            // margin: EdgeInsets.only(right: ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.headerStyle.leftChevronVisible)
                  IconButton(
                    onPressed: () {
                      widget.onLeftChevronTap();
                    },
                    splashRadius: 20,
                    iconSize: 4,
                    icon: SizedBox(
                      height: 15,
                      width: 6,
                      child: Container(
                        height: 8,
                        width: 4.3,
                        child: widget.LeftIcon,
                      ),
                    ),
                  ),
                if (widget.headerStyle.rightChevronVisible)
                  IconButton(
                    onPressed: () {
                      widget.onRightChevronTap();
                    },
                    splashRadius: 20,
                    iconSize: 4,
                    icon: SizedBox(
                      height: 15,
                      width: 6,
                      child: Container(
                        height: 15,
                        width: 6,
                        // margin: const EdgeInsets.only(right: 16 ),
                        child: widget.RightIcon,
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
