import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:taskati_dk_4_11/core/utils/colors.dart';
import 'package:taskati_dk_4_11/core/utils/styles.dart';
import 'package:taskati_dk_4_11/feature/add_task/add_task_view.dart';
import 'package:taskati_dk_4_11/feature/home/model/task_model.dart';
import 'package:taskati_dk_4_11/feature/home/widgets/home_header.dart';
import 'package:taskati_dk_4_11/feature/home/widgets/task_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var _selectedValue = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // header
              const HomeHeader(),
              // date header
              const SizedBox(height: 20),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMMEEEEd().format(DateTime.now()),
                        style: getTitleStyle(),
                      ),
                      Text(
                        'Today',
                        style: getTitleStyle(),
                      )
                    ],
                  ),
                  const Spacer(),

                  // add task button
                  CustomButton(
                    text: '+ Add Task',
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddTaskView(),
                      ));
                    },
                  )
                ],
              ),
              //--------------------- date timeline
              const SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DatePicker(
                    DateTime.now(),
                    height: 100,
                    width: 80,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColors.primaryColor,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      // New date selected
                      setState(() {
                        _selectedValue = date;
                        print(_selectedValue.toIso8601String());
                      });
                    },
                  ),
                ],
              ),
              // tasks or empty tasks
              const SizedBox(height: 15),
              ValueListenableBuilder(
                valueListenable: Hive.box<Task>('task').listenable(),
                builder: (context, box, child) {
                  // filterition by date  ==> List<Task>
                  List<Task> tasks = box.values.where((element) {
                    if (element.date.split('T').first ==
                        _selectedValue.toIso8601String().split('T').first) {
                      return true;
                    } else {
                      return false;
                    }
                  }).toList();
                  if (tasks.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/empty.png'),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('no tasks')
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              padding: const EdgeInsets.all(10),
                              color: Colors.green,
                              child: const Row(
                                children: [
                                  Icon(Icons.check),
                                  SizedBox(width: 5),
                                  Text('Complete Task')
                                ],
                              ),
                            ),
                            secondaryBackground: Container(
                              padding: const EdgeInsets.all(10),
                              color: AppColors.redColor,
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 5),
                                  Text('Delete Task')
                                ],
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.startToEnd) {
                                box.put(
                                    tasks[index].id,
                                    Task(
                                        id: tasks[index].id,
                                        title: tasks[index].title,
                                        note: tasks[index].note,
                                        date: tasks[index].date,
                                        startTime: tasks[index].startTime,
                                        endTime: tasks[index].endTime,
                                        color: tasks[index].color,
                                        isComplete: true));
                              } else {
                                box.delete(tasks[index].id);
                              }
                            },
                            child: TaskItem(
                              model: tasks[index],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
  });
  final Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor),
        child: Text(text, style: TextStyle(color: AppColors.lightBg)),
      ),
    );
  }
}
