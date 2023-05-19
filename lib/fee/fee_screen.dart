import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:prathibha_web/fee/widget/fee_table_row.dart';

class FeeScreen extends StatefulWidget {
  const FeeScreen({super.key});

  @override
  State<FeeScreen> createState() => _FeeScreenState();
}

class _FeeScreenState extends State<FeeScreen> {
  String? selectedClass = 'Class';
  String? selectedDivision = 'Division';

  bool isUnpaidChecked = false;
  bool isPaidChecked = false;

  void handleUnpaidCheck(bool? value) {
    setState(() {
      isUnpaidChecked = value!;
      if (value) {
        isPaidChecked =
            false; // Set Paid checkbox to false when Unpaid is checked
      }
    });
  }

  void handlePaidCheck(bool? value) {
    setState(() {
      isPaidChecked = value!;
      if (value) {
        isUnpaidChecked =
            false; // Set Unpaid checkbox to false when Paid is checked
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Fee Details",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: "Search by Student Name, Class, Section, Roll No.",
              filled: true,
              fillColor: Color.fromRGBO(234, 240, 247, 1),
              border: InputBorder.none,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isUnpaidChecked,
                onChanged: handleUnpaidCheck,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: const Color.fromRGBO(68, 97, 242, 1),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Unpaid",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: isPaidChecked,
                onChanged: handlePaidCheck,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: const Color.fromRGBO(68, 97, 242, 1),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Paid",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedClass,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedClass = newValue;
                    });
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: HeroIcon(HeroIcons.chevronDown),
                  ),
                  items: <String>[
                    'Class',
                    '10',
                    '9',
                    '8',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
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
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromRGBO(234, 240, 247, 1),
                  ), // Customize the border color and other properties
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: const Color.fromRGBO(
                      234, 240, 247, 1) // Customize the border radius if needed
                  ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedDivision,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDivision = newValue;
                    });
                  },
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: HeroIcon(HeroIcons.chevronDown),
                  ),
                  items: <String>[
                    'Division',
                    'A',
                    'B',
                    'C',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
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
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.95,
              child: Column(
                children: [
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Student Name',
                      'Branch Name',
                      'Class Division',
                      'Status',
                      'Date of Payment',
                    ],
                    isHeader: true,
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Unpaid',
                      '--------',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Paid',
                      'May 11, 2023',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Paid',
                      'May 11, 2023',
                    ],
                  ),
                  const Divider(),
                  FeeTableRow(
                    rowData: [
                      Checkbox(value: true, onChanged: (value) {}),
                      'Akhil',
                      'Branch 1',
                      '10 B',
                      'Paid',
                      'May 11, 2023',
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
