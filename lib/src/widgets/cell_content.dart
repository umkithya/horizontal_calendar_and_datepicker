import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;
  final isfuturedaydisable;
  final Widget? dowCell;
  const CellContent({
    Key? key,
    required this.day,
    required this.focusedDay,
    required this.calendarStyle,
    required this.calendarBuilders,
    required this.isTodayHighlighted,
    required this.isSelected,
    required this.isRangeStart,
    required this.isRangeEnd,
    required this.isWithinRange,
    required this.isOutside,
    required this.isDisabled,
    required this.isHoliday,
    required this.isWeekend,
    this.locale,
    required this.isfuturedaydisable,
    this.dowCell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell =
        calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    final text = '${day.day}';
    final margin = calendarStyle.cellMargin;
    final padding = calendarStyle.cellPadding;
    final alignment = calendarStyle.cellAlignment;
    final duration = const Duration(milliseconds: 250);

    if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          AnimatedContainer(
            height: 40,
            width: 40,
            duration: duration,
            margin: margin,
            padding: padding,
            decoration: this.isfuturedaydisable == true
                ? day.isBefore(DateTime.now())
                    ? calendarStyle.defaultDecoration
                    : BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xfff4f8f6))
                : calendarStyle.defaultDecoration,
            alignment: alignment,
            child: Text(
              text,
              style: this.isfuturedaydisable == true
                  ? day.isBefore(DateTime.now())
                      ? calendarStyle.defaultTextStyle
                      : calendarStyle.disabledTextStyle
                  : calendarStyle.defaultTextStyle,
            ),
          );
    } else if (isSelected) {
      cell = Text(text, style: calendarStyle.selectedTextStyle);
    } else if (isRangeStart) {
      cell =
          calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
              Text(text, style: calendarStyle.rangeStartTextStyle);
    } else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          Text(
            text,
            style: this.isfuturedaydisable == true
                ? day.isBefore(DateTime.now())
                    ? calendarStyle.defaultTextStyle
                    : calendarStyle.disabledTextStyle
                : calendarStyle.defaultTextStyle,
          );
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          Text(
            text,
            style: this.isfuturedaydisable == true
                ? day.isBefore(DateTime.now())
                    ? calendarStyle.defaultTextStyle
                    : calendarStyle.disabledTextStyle
                : calendarStyle.defaultTextStyle,
          );
    } else if (isWithinRange) {
      debugPrint("7 is : ${this.isfuturedaydisable}");
      cell =
          calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
              Text(
                text,
                style: this.isfuturedaydisable == true
                    ? day.isBefore(DateTime.now())
                        ? calendarStyle.defaultTextStyle
                        : calendarStyle.disabledTextStyle
                    : calendarStyle.defaultTextStyle,
              );
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          Text(
            text,
            style: this.isfuturedaydisable == true
                ? day.isBefore(DateTime.now())
                    ? calendarStyle.defaultTextStyle
                    : TextStyle(color: Color.fromARGB(255, 184, 180, 180))
                : calendarStyle.defaultTextStyle,
          );
    } else {
      cell = Text(
        text,
        style: this.isfuturedaydisable == true
            ? day.isBefore(DateTime.now())
                ? calendarStyle.defaultTextStyle
                : TextStyle(color: Color.fromARGB(255, 184, 180, 180))
            : calendarStyle.defaultTextStyle,
      );
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}
