import 'package:flutter/material.dart';
import 'package:prathibha_web/switcher/switcher_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prathibha_web/switcher/bloc/calendar_day/calendar_day_bloc.dart';
import 'package:prathibha_web/switcher/bloc/left_tab_view/left_tab_view_bloc.dart';
import 'package:prathibha_web/switcher/bloc/add_event/add_event_bloc.dart';
import 'package:prathibha_web/switcher/bloc/drop_down_switch/drop_down_switch_bloc.dart';
import 'package:prathibha_web/fee/bloc/unpaid/unpaid_bloc.dart';
import 'package:prathibha_web/fee/bloc/paid/paid_bloc.dart';
import 'package:prathibha_web/fee/bloc/class/class_bloc.dart';
import 'package:prathibha_web/fee/bloc/division/division_bloc.dart';
import 'package:prathibha_web/fee/bloc/month/month_bloc.dart';

void main(List<String> args) {
  runApp(const PrathibhaWebApplication());
}

class PrathibhaWebApplication extends StatefulWidget {
  const PrathibhaWebApplication({super.key});

  @override
  State<PrathibhaWebApplication> createState() =>
      _PrathibhaWebApplicationState();
}

class _PrathibhaWebApplicationState extends State<PrathibhaWebApplication> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Prathibha",
      theme: ThemeData(
        fontFamily: "Poppins",
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            backgroundColor: const Color.fromRGBO(68, 97, 242, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Set border radius
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Color.fromRGBO(68, 97, 242, 1),
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: ((context) => CalendarDayBloc())),
          BlocProvider(create: ((context) => LeftTabViewBloc())),
          BlocProvider(create: ((context) => AddEventBloc())),
          BlocProvider(create: ((context) => DropDownSwitchBloc())),
          BlocProvider(create: ((context) => UnpaidBloc())),
          BlocProvider(create: ((context) => PaidBloc())),
          BlocProvider(create: ((context) => ClassBloc())),
          BlocProvider(create: ((context) => DivisionBloc())),
          BlocProvider(create: ((context) => MonthBloc())),
        ],
        child: const SwitcherScreen(),
      ),
    );
  }
}
