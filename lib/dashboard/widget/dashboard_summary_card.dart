import 'package:flutter/material.dart';

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard({
    super.key,
    required this.totalStudents,
    required this.totalExpenses,
    required this.totalDue,
    required this.ratioWidth,
    required this.ratioHeight,
  });

  final String totalStudents, totalExpenses, totalDue;
  final double ratioWidth, ratioHeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: 200 / ratioWidth,
          height: 100 * ratioHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: const Color.fromRGBO(234, 240, 247, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Students",
                style: TextStyle(
                  fontSize: 16 / ratioWidth,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                totalStudents,
                style: TextStyle(
                  fontSize: 28 / ratioWidth,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          width: 200 / ratioWidth,
          height: 100 * ratioHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: const Color.fromRGBO(248, 239, 226, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Expenses",
                style: TextStyle(
                  fontSize: 16 / ratioWidth,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                totalExpenses,
                style: TextStyle(
                  fontSize: 28 / ratioWidth,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Container(
          width: 200 / ratioWidth,
          height: 100 * ratioHeight,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromRGBO(234, 240, 247, 1),
            ),
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: const Color.fromRGBO(239, 247, 226, 1),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset:
                    const Offset(0, 3), // changes the position of the shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Fee Due",
                style: TextStyle(
                  fontSize: 16 / ratioWidth,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                totalDue,
                style: TextStyle(
                  fontSize: 28 / ratioWidth,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
