import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks_list/core/components/button_component.dart';
import 'package:tasks_list/core/consts/colors.dart';
import 'package:tasks_list/features/settings/domain/bloc/settings_cubit.dart';
import 'package:tasks_list/features/tasks/domain/bloc/tasks_cubit.dart';
import 'package:tasks_list/features/tasks/presentation/screens/show_tasks.dart';

import '../../../../core/components/text_form_field_component.dart';
import '../../../../generated/l10n.dart';
import '../../../settings/presentation/widgets/actionBar.dart';
import '../../domain/bloc/tasks_states.dart';

class FilterTasksScreen extends StatelessWidget {
  TextEditingController titleController = new TextEditingController(text: "");
  TextEditingController descriptionController =
      new TextEditingController(text: "");
  TextEditingController longDescriptionController =
      new TextEditingController(text: "");
  TextEditingController dateController = new TextEditingController(text: "");
  TextEditingController timeController = new TextEditingController(text: "");
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateTime? selectedDateTime;

  Future<DateTime?> selectDate(BuildContext context) async {
    selectedDate = await showDatePicker(
      context: context,
      initialDate: (selectedDate != null) ? selectedDate! : DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    return selectedDate;
  }

  Future<TimeOfDay?> selectTime(BuildContext context) async {
    selectedTime = await showTimePicker(
      context: context,
      initialTime: (selectedTime != null) ? selectedTime! : TimeOfDay.now(),
    );

    return selectedTime;
  }

  String _saveDateTime() {
    selectedDateTime = DateTime(selectedDate!.year, selectedDate!.month,
        selectedDate!.day, selectedTime!.hour, selectedTime!.minute, 00);

    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(selectedDateTime!);
    print('Selected Date and Time: $formattedDateTime');
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (BuildContext context) => TasksCubit(),
      child: BlocConsumer<TasksCubit, TasksState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = TasksCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              actions: [ActionBarSettings(context)],
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(12),
                width: width,
                height: height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          S.of(context).title + ' : ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        Expanded(
                          child: TextFormFieldComponent(
                            controller: titleController,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          S.of(context).description + ' : ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        Expanded(
                          child: TextFormFieldComponent(
                            controller: descriptionController,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          S.of(context).long_description + ' : ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        Expanded(
                          child: TextFormFieldComponent(
                            controller: longDescriptionController,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height / 30,
                    ),
                    Row(
                      children: [
                        Text(
                          S.of(context).completed_date + ' : ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          width: width / 40,
                        ),
                        DropdownButton<String>(
                          dropdownColor: (SettingsCubit.darkMode
                              ? darkModeBackgroundColor
                              : lightModeBackgroundColor),
                          alignment: Alignment.bottomCenter,
                          value: cubit.currentDateFilter,
                          style: Theme.of(context).textTheme.bodyLarge,
                          onChanged: (newValue) {
                            print(newValue);
                            cubit.changeFilterDate(newValue!);
                          },
                          items: cubit.dateFilterOptionsList
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              // alignment: Alignment.bottomCenter,
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          width: width / 40,
                        ),
                        Expanded(
                          child: TextFormFieldComponent(
                            // prefixIcon: Icons.calendar_month,
                            // hintText:S.of(context).day,
                            readOnly: true,
                            onTap: () {
                              selectDate(context).then((value) {
                                selectTime(context).then((value) =>
                                    dateController.text = _saveDateTime());
                              });
                              // .then((value) => dateController
                              // .text = DateFormat('yyyy-MM-dd').format(value!));
                            },
                            controller: dateController,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height / 10,
                    ),
                    ButtonComponent(
                        onPressed: () {
                          cubit
                              .getFilteredTasks(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  longDescription:
                                      longDescriptionController.text,
                                  date: dateController.text)
                              .then((value)
                          {
                                    Navigator.pop(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowTasksScreen()));
                                  });
                        },
                        text: S.of(context).search)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
