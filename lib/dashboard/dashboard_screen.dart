import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:prathibha_web/dashboard/widget/dashboard_summary_card.dart';
import 'package:prathibha_web/dashboard/widget/income_expense_graph.dart';

import 'bloc/drop_down_switch/drop_down_switch_bloc.dart';
import 'bloc/drop_down_switch/drop_down_switch_event.dart';
import 'bloc/drop_down_switch/drop_down_switch_state.dart';
import 'model/bar_char_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? selectedOption = 'All Branches';

  String formatNumber(int number) {
    return NumberFormat.compactCurrency(
      decimalDigits: 2,
      symbol: '',
    ).format(number);
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    List<BarChartModel> barChartModelData = [
      BarChartModel(
        monthName: "Jan",
        income: 100000,
        expense: 50000,
      ),
      BarChartModel(
        monthName: "Feb",
        income: 200000,
        expense: 100000,
      ),
      BarChartModel(
        monthName: "Mar",
        income: 300000,
        expense: 150000,
      ),
      BarChartModel(
        monthName: "Apr",
        income: 400000,
        expense: 200000,
      ),
      BarChartModel(
        monthName: "May",
        income: 500000,
        expense: 250000,
      ),
      BarChartModel(
        monthName: "Jun",
        income: 600000,
        expense: 300000,
      ),
      BarChartModel(
        monthName: "Jul",
        income: 700000,
        expense: 350000,
      ),
      BarChartModel(
        monthName: "Aug",
        income: 800000,
        expense: 400000,
      ),
      BarChartModel(
        monthName: "Sep",
        income: 900000,
        expense: 450000,
      ),
      BarChartModel(
        monthName: "Oct",
        income: 1000000,
        expense: 500000,
      ),
      BarChartModel(
        monthName: "Nov",
        income: 1100000,
        expense: 550000,
      ),
      BarChartModel(
        monthName: "Dec",
        income: 1200000,
        expense: 600000,
      ),
    ];

    double screenWidth = MediaQuery.of(context).size.width;
    double ratioHeight = 900 / MediaQuery.of(context).size.height;

    final dropDownSwitchBloc = DropDownSwitchBloc();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hello Maietry \u{1F44B}",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
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
                    child: BlocBuilder<DropDownSwitchBloc, DropDownSwitchState>(
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
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    value,
                                    style: TextStyle(
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
                  )
                ],
              ),
              const SizedBox(height: 30),
              DashboardSummaryCard(
                totalStudents: "100",
                totalExpenses: "345678",
                totalDue: "23000",
                ratioWidth: screenWidth,
                ratioHeight: ratioHeight,
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Income vs Expense",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              IncomeExpenseGraph(
                barChartModelData: barChartModelData,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Today's Attendance Overview",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(
                            label: Text(
                              'Sl No',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Branch',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Class & Division',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Percentage',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Actions',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          DataRow(
                            cells: [
                              const DataCell(Text('1')),
                              const DataCell(Text('Branch 1')),
                              const DataCell(Text('10 A')),
                              const DataCell(Text('90%')),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 37, 6, 217),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ), // Set border radius
                                    ),
                                  ),
                                  child: const Text(
                                    "View",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('2')),
                              const DataCell(Text('Branch 2')),
                              const DataCell(Text('9 B')),
                              const DataCell(Text('87%')),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 37, 6, 217),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ), // Set border radius
                                    ),
                                  ),
                                  child: const Text(
                                    "View",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          DataRow(
                            cells: [
                              const DataCell(Text('3')),
                              const DataCell(Text('Branch 3')),
                              const DataCell(Text('10 D')),
                              const DataCell(Text('84%')),
                              DataCell(
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 37, 6, 217),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ), // Set border radius
                                    ),
                                  ),
                                  child: const Text(
                                    "View",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
