import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/fee/fee_screen.dart';
import 'package:prathibha_web/switcher/widget/add_event_button.dart';
import 'package:prathibha_web/switcher/widget/left_tab_view.dart';
import 'package:prathibha_web/switcher/widget/show_calendar.dart';
import 'package:prathibha_web/switcher/widget/show_events.dart';

import '../attendance/attendance_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../report/report_screen.dart';
import '../student/student_screen.dart';
import 'bloc/drop_down_switch/drop_down_switch_bloc.dart';
import 'bloc/drop_down_switch/drop_down_switch_event.dart';
import 'bloc/drop_down_switch/drop_down_switch_state.dart';
import 'bloc/add_event/add_event_bloc.dart';
import 'bloc/left_tab_view/left_tab_view_bloc.dart';
import 'bloc/left_tab_view/left_tab_view_state.dart';

import 'bloc/calendar_day/calendar_day_bloc.dart';

// ignore: depend_on_referenced_packages

class SwitcherScreen extends StatefulWidget {
  const SwitcherScreen({super.key});

  @override
  State<SwitcherScreen> createState() => _SwitcherScreenState();
}

class _SwitcherScreenState extends State<SwitcherScreen> {
  final tabViewBloc = LeftTabViewBloc();
  final calendarDayBloc = CalendarDayBloc();
  final addEventBloc = AddEventBloc();

  final dateController = TextEditingController();

  String? selectedOption = 'All Branches';

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          LeftTabView(
            tabViewBloc: tabViewBloc,
            screenWidth: screenWidth,
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: const Text(
                          "Hello Maietry \u{1F44B}",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(234, 240, 247, 1),
                              ), // Customize the border color and other properties
                              borderRadius: BorderRadius.circular(
                                10.0,
                              ),
                              color: const Color.fromRGBO(234, 240, 247,
                                  1) // Customize the border radius if needed
                              ),
                          child: BlocBuilder<DropDownSwitchBloc,
                              DropDownSwitchState>(
                            bloc: dropDownSwitchBloc,
                            builder: (context, state) {
                              if (state is DropDownSwitchedState) {
                                selectedOption = state.newBranch;
                              }
                              return DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedOption,
                                  onChanged: (String? newValue) {
                                    dropDownSwitchBloc.add(
                                      DropDownSwitchEventChange(
                                        newBranch: newValue!,
                                      ),
                                    );
                                  },
                                  icon: const Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: HeroIcon(HeroIcons.chevronDown),
                                  ),
                                  items: <String>[
                                    'All Branches',
                                    'Branch 1',
                                    'Branch 2',
                                    'Branch 3'
                                  ].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
                        bloc: tabViewBloc,
                        builder: (context, state) {
                          if (state is DashBoardState) {
                            return const DashboardScreen();
                          } else if (state is AttendanceState) {
                            return const AttendanceScreen();
                          } else if (state is FeeState) {
                            return const FeeScreen();
                          } else if (state is StudentsState) {
                            return const StudentScreen();
                          } else if (state is ReportsState) {
                            return const ReportScreen();
                          }
                          return const DashboardScreen();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: screenWidth / 5,
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
                    children: [
                      const Text(
                        "Profile",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Logout"),
                                content: const Text(
                                    "Are you sure you want to logout?"),
                                actions: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        textStyle: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        backgroundColor: const Color.fromARGB(
                                            255, 255, 136, 67),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              20), // Set border radius
                                        ),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: const Text("Cancel"),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 10, right: 10),
                                    child: ElevatedButton(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: const Text("Logout"),
                                      ),
                                      onPressed: () {
                                        // Perform logout actions here
                                        Navigator.of(context)
                                            .pop(); // Close the dialog

                                        // Add your logout logic here
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Tooltip(
                          message: 'Logout from system',
                          child: HeroIcon(
                            HeroIcons.arrowRightOnRectangle,
                          ),
                        ),
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
                  ShowCalendar(
                    calendarDayBloc: calendarDayBloc,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AddEventButton(
                    calendarDayBloc: calendarDayBloc,
                    dateController: dateController,
                    addEventBloc: addEventBloc,
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
                      return const ShowEvents(eventName: "Event Name");
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: BlocBuilder<LeftTabViewBloc, LeftTabViewState>(
        bloc: tabViewBloc,
        builder: (context, state) {
          if (state is FeeState) {
            return Padding(
              padding: EdgeInsets.only(right: screenWidth / 5 + 10, bottom: 20),
              child: FloatingActionButton(
                onPressed: () {},
                elevation: 1,
                child: const HeroIcon(
                  HeroIcons.documentText,
                  size: 30,
                  style: HeroIconStyle.solid,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
