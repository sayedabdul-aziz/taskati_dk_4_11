import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:taskati_dk_4_11/core/utils/colors.dart';
import 'package:taskati_dk_4_11/core/utils/styles.dart';
import 'package:taskati_dk_4_11/feature/home/home_view.dart';
import 'package:taskati_dk_4_11/feature/home/model/task_model.dart';

class AddTaskView extends StatefulWidget {
  const AddTaskView({super.key});

  @override
  State<AddTaskView> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  var titleCon = TextEditingController();
  var noteCon = TextEditingController();
  var formKey = GlobalKey<FormState>();

  var _date = DateTime.now();
  var _startTime = DateFormat('hh:mm a').format(DateTime.now());
  var _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)));

  int _selectedColor = 0;

  late Box<Task> box;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    box = Hive.box<Task>('task');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --------- title ---------------
                Text(
                  'Title',
                  style: getTitleStyle(),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: titleCon,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Title musn\'t be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Title Here',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // --------- note ---------------
                Text(
                  'Note',
                  style: getTitleStyle(),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: noteCon,
                  maxLines: 5,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Note musn\'t be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter Note Here',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // --------- date ---------------

                Text(
                  'Date',
                  style: getTitleStyle(),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: DateFormat.yMd().format(_date),
                      hintStyle: getSubTitleStyle(),
                      suffixIcon: IconButton(
                        onPressed: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2050));
                          if (date != null) {
                            setState(() {
                              _date = date;
                            });
                          }
                        },
                        icon: const Icon(Icons.calendar_month_rounded),
                        color: AppColors.primaryColor,
                      )),
                ),
                // --------- start time ---------------
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Start Time',
                        style: getTitleStyle(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'End Time',
                        style: getTitleStyle(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: _startTime,
                            hintStyle: getSubTitleStyle(),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var timePicked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (timePicked != null) {
                                  setState(() {
                                    _startTime = timePicked.format(context);
                                    _endTime = timePicked
                                        .replacing(
                                            minute: timePicked.minute + 15)
                                        .format(context);
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_month_rounded),
                              color: AppColors.primaryColor,
                            )),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // --------- end time ---------------

                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: _endTime,
                            hintStyle: getSubTitleStyle(),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                var timePicked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (timePicked != null) {
                                  setState(() {
                                    _endTime = timePicked.format(context);
                                  });
                                }
                              },
                              icon: const Icon(Icons.calendar_month_rounded),
                              color: AppColors.primaryColor,
                            )),
                      ),
                    ),
                  ],
                ),

                // --------- color and btn " add task " ---------------
                const SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = 0;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.primaryColor,
                        child: (_selectedColor == 0)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = 1;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.orangeColor,
                        child: (_selectedColor == 1)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = 2;
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: AppColors.redColor,
                        child: (_selectedColor == 2)
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      text: 'Create Task',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await box
                              .put(
                                  '${titleCon.text}-${_date.toIso8601String()}',
                                  Task(
                                      id: '${titleCon.text}-${_date.toIso8601String()}',
                                      title: titleCon.text,
                                      note: noteCon.text,
                                      date: _date.toIso8601String(),
                                      startTime: _startTime,
                                      endTime: _endTime,
                                      color: _selectedColor,
                                      isComplete: false))
                              .then((value) {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const HomeView(),
                            ));
                          });
                          print(box
                              .get(
                                  '${titleCon.text}-${_date.toIso8601String()}')!
                              .date);
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
