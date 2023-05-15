import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/attendance/attendance_screen.dart';
import 'package:prathibha_web/dashboard/dashboard_screen.dart';
import 'package:prathibha_web/finance/finance_screen.dart';
import 'package:prathibha_web/switcher/bloc/add_event/add_event_event.dart';
import 'package:prathibha_web/switcher/widget/add_event.dart';
import 'package:table_calendar/table_calendar.dart';

import 'bloc/add_event/add_event_bloc.dart';
import 'bloc/left_tab_view/left_tab_view_bloc.dart';
import 'bloc/left_tab_view/left_tab_view_event.dart';
import 'bloc/left_tab_view/left_tab_view_state.dart';

import 'bloc/calendar_day/calendar_day_bloc.dart';
import 'bloc/calendar_day/calendar_day_event.dart';
import 'bloc/calendar_day/calendar_day_state.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class SwitcherScreen extends StatefulWidget {
  const SwitcherScreen({super.key});

  @override
  State<SwitcherScreen> createState() => _SwitcherScreenState();
}

final kToday = DateTime.now();

final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class _SwitcherScreenState extends State<SwitcherScreen> {
  final List<String> _tabs = [
    'Dashboard',
    'Attedance',
    'Finance',
  ];

  final CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();

  final tabViewBloc = LeftTabViewBloc();
  final calendarDayBloc = CalendarDayBloc();
  final addEventBloc = AddEventBloc();

  final dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
            bloc: tabViewBloc,
            builder: (context, state) {
              int selectedIndex = 0;
              if (state is DashBoardState) {
                selectedIndex = 0;
              } else if (state is AttendanceState) {
                selectedIndex = 1;
              } else if (state is FinanceState) {
                selectedIndex = 2;
              }
              return Container(
                width: 250.0,
                color: const Color.fromRGBO(245, 247, 249, 1),
                padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 70,
                        width: 70,
                        child: Image.asset("assets/images/logo.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        tabViewBloc.add(LeftTabViewSwitch(0));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == 0
                              ? const Color.fromRGBO(68, 97, 242, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            HeroIcon(
                              HeroIcons.squares2x2,
                              color: selectedIndex == 0
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              _tabs[0],
                              style: TextStyle(
                                color: selectedIndex == 0
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tabViewBloc.add(LeftTabViewSwitch(1));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == 1
                              ? const Color.fromRGBO(68, 97, 242, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            HeroIcon(
                              HeroIcons.userPlus,
                              color: selectedIndex == 1
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              _tabs[1],
                              style: TextStyle(
                                color: selectedIndex == 1
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tabViewBloc.add(LeftTabViewSwitch(2));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedIndex == 2
                              ? const Color.fromRGBO(68, 97, 242, 1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            HeroIcon(
                              HeroIcons.currencyDollar,
                              color: selectedIndex == 2
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              _tabs[2],
                              style: TextStyle(
                                color: selectedIndex == 2
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // center view
          Expanded(
            child: BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
              bloc: tabViewBloc,
              builder: (context, state) {
                if (state is DashBoardState) {
                  return const DashboardScreen();
                }
                if (state is AttendanceState) {
                  return const AttendanceScreen();
                }
                if (state is FinanceState) {
                  return const FinanceScreen();
                }
                return const DashboardScreen();
              },
            ),
          ),

          SingleChildScrollView(
            child: Container(
              width: 300,
              padding: const EdgeInsets.only(
                top: 50,
                left: 5,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      HeroIcon(
                        HeroIcons.pencilSquare,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 75,
                  ),
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Maietry Prajapati",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "Main Adminstrator",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BlocBuilder<CalendarDayBloc, CalendarDayState>(
                    bloc: calendarDayBloc,
                    builder: (context, state) {
                      return TableCalendar(
                        firstDay: kFirstDay,
                        lastDay: kLastDay,
                        focusedDay: _focusedDay,
                        calendarFormat: _calendarFormat,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(state.selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(state.selectedDay, selectedDay)) {
                            calendarDayBloc.add(
                              SelectedDayEvent(selectedDay, focusedDay),
                            );
                          }
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                      );
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Events",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      BlocBuilder<CalendarDayBloc, CalendarDayState>(
                        bloc: calendarDayBloc,
                        builder: (context, state) {
                          dateController.text = DateFormat('MMMM d, y').format(
                            state.selectedDay,
                          );
                          return GestureDetector(
                            onTap: () {
                              if (state.selectedDay
                                  .add(const Duration(days: 1))
                                  .isBefore(DateTime.now())) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.red,
                                    width: 700,
                                    content: Row(
                                      children: const [
                                        HeroIcon(
                                          HeroIcons.exclamationCircle,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Can\'t add event for dates before today. Select Valid Date in Calendar',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                return;
                              }
                              addEvent(
                                context: context,
                                dateController: dateController,
                                addEventBloc: addEventBloc,
                                onDatePickerTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: state.selectedDay,
                                    firstDate: DateTime(2022),
                                    lastDate: DateTime(2100),
                                  );
                                  if (pickedDate != null) {
                                    addEventBloc
                                        .add(ChangeEventDate(pickedDate));
                                  }
                                },
                              );
                            },
                            child: const HeroIcon(
                              HeroIcons.plus,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 10,
                    scrollDirection: Axis.vertical,
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 15,
                      );
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(245, 247, 249, 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Event Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
