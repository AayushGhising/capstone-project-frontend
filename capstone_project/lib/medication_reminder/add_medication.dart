import "package:flutter/material.dart";
import 'package:capstone_project/components/medication_textfield.dart';
import 'package:capstone_project/components/schedule.dart';
import 'package:intl/intl.dart';
import 'package:capstone_project/components/my_button.dart';

class AddMedication extends StatefulWidget {
  const AddMedication({super.key});
  @override
  _AddMedicationState createState() => _AddMedicationState();
}

class _AddMedicationState extends State<AddMedication> {
  final TextEditingController _medicineNameController = TextEditingController();
  final TextEditingController _memoController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  //date picker
  DateTime? _startDate;
  DateTime? _endDate;

  //Dropdown list frequency
  final List<String> _frequencies = [
    'Every Day',
    'Every X Days',
    'Day of the Week',
    'Day of the Month'
  ];

  String _selectedFrequency = 'Every Day';
  int _selectedDays = 1;
  int _selectedWeek = DateTime.monday;
  int _selectedDayOfMonth = 1;

  final List<String> _dayOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            height: 1200,
            width: 500,
            color: const Color.fromARGB(255, 242, 247, 250),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Add Medicine',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontFamily: 'Lato',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
                //Medicine Name
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Medicine Name',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontFamily: 'Lato',
                        fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 15),
                //medicine Name textfield
                MedicationTextfield(
                  controller: _medicineNameController,
                  obscureText: false,
                  labelText: 'Medicine Name',
                  prefixIcon: Image.asset('assets/images/medicine_icon.png'),
                ),
                const SizedBox(height: 20),
                //Reason for medication
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Reason for Medication',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontFamily: 'Lato',
                        fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                //reason text field
                const SizedBox(height: 15),
                MedicationTextfield(
                  controller: _reasonController,
                  obscureText: false,
                  labelText: 'Reason for Medication',
                  prefixIcon: Image.asset('assets/images/reason.png'),
                ),
                const SizedBox(height: 20),
                //Frequency
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Frequency',
                    style: TextStyle(
                        color: Color.fromARGB(255, 48, 48, 48),
                        fontFamily: 'Lato',
                        fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedFrequency,
                      items: _frequencies.map((String frequency) {
                        return DropdownMenuItem<String>(
                          value: frequency,
                          child: Center(
                            child: Text(
                              frequency,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 48, 48, 48),
                                  fontFamily: 'Lato',
                                  fontSize: 16),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedFrequency = newValue!;
                          switch (_selectedFrequency) {
                            case 'Every X Days':
                              _selectedDays = 1;
                              break;
                            case 'Day of the Week':
                              _selectedWeek = DateTime.monday;
                              break;
                            case 'Day of the Month':
                              _selectedDayOfMonth = 1;
                              break;
                            default:
                              break;
                          }
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'assets/images/Frequency.png',
                            height: 8,
                            width: 8,
                          ),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (_selectedFrequency == 'Every X Days')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: DropdownButtonFormField(
                        value: _selectedDays,
                        items: List.generate(365, (index) => index + 1)
                            .map((int day) {
                          return DropdownMenuItem<int>(
                              value: day,
                              child: Center(
                                child: Text(
                                  'Every $day ${day == 1 ? 'day' : 'days'}',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      fontFamily: 'Lato',
                                      fontSize: 16),
                                ),
                              ));
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedDays = newValue!;
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12)),
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                      ),
                    ),
                  ),
                //Day of the Week
                const SizedBox(height: 5),
                if (_selectedFrequency == 'Day of the Week')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: DropdownButtonFormField(
                        value: _selectedWeek,
                        items: _dayOfWeek.asMap().entries.map((entry) {
                          return DropdownMenuItem<int>(
                            value: entry.key + 1,
                            child: Center(
                              child: Text(
                                entry.value,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 48, 48, 48),
                                  fontFamily: 'Lato',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedWeek = newValue!;
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12)),
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                      ),
                    ),
                  ),
                //Day of the Month
                const SizedBox(height: 5),
                if (_selectedFrequency == 'Day of the Month')
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3))
                        ],
                      ),
                      child: DropdownButtonFormField(
                        value: _selectedDayOfMonth,
                        items: List.generate(31, (index) => index + 1)
                            .map((int day) {
                          return DropdownMenuItem<int>(
                              value: day,
                              child: Center(
                                child: Text(
                                  '$day',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 48, 48, 48),
                                      fontFamily: 'Lato',
                                      fontSize: 16),
                                ),
                              ));
                        }).toList(),
                        onChanged: (int? newValue) {
                          setState(() {
                            _selectedDayOfMonth = newValue!;
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 12)),
                        icon: const Icon(Icons.arrow_drop_down),
                        isExpanded: true,
                      ),
                    ),
                  ),
                //Schedule Widget
                const SizedBox(height: 15),
                const Schedule(),
                //Start Date
                const SizedBox(height: 15),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Start Date',
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 48, 48),
                      fontFamily: 'Lato',
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: InkWell(
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _startDate == null
                                ? 'Select Start Date'
                                : DateFormat('yyy-MM-dd').format(_startDate!),
                            style: TextStyle(
                              color: _startDate == null
                                  ? Colors.grey
                                  : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //End Date
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'End Date',
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 48, 48),
                      fontFamily: 'Lato',
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: InkWell(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today, color: Colors.grey),
                          const SizedBox(width: 10),
                          Text(
                            _endDate == null
                                ? 'Select End Date'
                                : DateFormat('yyyy-MM-dd').format(_endDate!),
                            style: TextStyle(
                                color: _endDate == null
                                    ? Colors.grey
                                    : Colors.black,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //Memo
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Memo',
                    style: TextStyle(
                      color: Color.fromARGB(255, 48, 48, 48),
                      fontFamily: 'Lato',
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                MedicationTextfield(
                  controller: _memoController,
                  obscureText: false,
                  labelText: 'Add memo',
                  prefixIcon: Image.asset('assets/images/memo.png'),
                ),
                const SizedBox(height: 30),
                //save button
                Center(
                    child: IntrinsicWidth(
                        child: MyButton(onPressed: () {}, label: 'Save')))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? _startDate ?? DateTime.now()),
      firstDate: isStartDate ? DateTime.now() : (_startDate ?? DateTime.now()),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = null;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }
}
