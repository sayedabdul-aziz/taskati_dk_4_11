import 'package:flutter/material.dart';
import 'package:taskati_dk_4_11/core/utils/colors.dart';
import 'package:taskati_dk_4_11/core/utils/styles.dart';
import 'package:taskati_dk_4_11/feature/home/model/task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.model,
  });

  final Task model;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (model.color == 0)
              ? AppColors.primaryColor
              : (model.color == 1)
                  ? AppColors.orangeColor
                  : AppColors.redColor),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.title, style: getTitleStyle(color: AppColors.lightBg)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.watch_later_outlined,
                    size: 20,
                    color: Colors.white70,
                  ),
                  const SizedBox(width: 5),
                  Text('${model.startTime} - ${model.endTime}',
                      style: getSmallStyle(color: Colors.white70))
                ],
              ),
              const SizedBox(height: 8),
              Text(model.note,
                  style: getSubTitleStyle(color: AppColors.lightBg))
            ],
          ),
          const Spacer(),
          Container(
            height: 60,
            width: .8,
            color: Colors.white70,
          ),
          const SizedBox(
            width: 5,
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              model.isComplete ? 'COMPLETED' : 'TODO',
              style: getSubTitleStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
