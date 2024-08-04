
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_list/core/components/text_form_field_component.dart';
import 'package:tasks_list/features/tasks/presentation/screens/show_tasks.dart';

import '../../../../core/components/button_component.dart';
import '../../../../generated/l10n.dart';
import '../../../settings/presentation/widgets/actionBar.dart';
import '../../domain/bloc/tasks_cubit.dart';
import '../../domain/bloc/tasks_states.dart';
import '../../domain/model/tasks_model.dart';

class EditTaskScreen extends StatelessWidget {
   TaskData task;
  EditTaskScreen({required TaskData this.task});
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var longDescriptionController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return BlocProvider(
        create: (BuildContext context) => TasksCubit(),
        child: BlocConsumer<TasksCubit, TasksState>(
          listener: (BuildContext context, state) {
            if (state is EditTaskLoadingState)
              print("loading...");
          },
          builder: (BuildContext context, Object? state) {

            if (state is TasksInitialState)
              {
                titleController.text=task.title!;
                descriptionController.text=task.description!;
                longDescriptionController.text=(task.longDescription==null)?"":task.longDescription!;
              }

            var cubit = TasksCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                actions: [ActionBarSettings(context)],
              ),
              body: Container(
                padding: EdgeInsets.all(16),
                child: (state is EditTaskLoadingState)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Form(
                                key:formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                        height: height / 2.5,
                                        child: Container(
                                          child: Image.asset(
                                              'assets/images/octobus.png'),
                                        )),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              S.of(context).title + ' : ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            SizedBox(
                                              width: width / 20,
                                            ),
                                            Expanded(
                                              child: TextFormFieldComponent(
                                                controller: titleController,
                                                // initialValue: task.title,
                                                validation: (value) {
                                                  if (value!.isEmpty) {
                                                    return S
                                                        .of(context)
                                                        .title_validation;
                                                  }
                                                  return null;
                                                },
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            SizedBox(
                                              width: width / 20,
                                            ),
                                            Expanded(
                                              child: TextFormFieldComponent(
                                                controller: descriptionController,
                                                validation: (value) {
                                                  if (value!.isEmpty) {
                                                    return S
                                                        .of(context)
                                                        .description_validation;
                                                  }
                                                  return null;
                                                },
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
                                              S.of(context).long_description +
                                                  ' : ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            SizedBox(
                                              width: width / 20,
                                            ),
                                            Expanded(
                                              child: TextFormFieldComponent(
                                                controller:
                                                    longDescriptionController,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height / 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          ButtonComponent(
                              onPressed: () {
                            if (formKey.currentState!.validate()){
                                  cubit
                                      .editTask(
                                          id: task.id!,
                                          title: titleController.text,
                                          description:
                                              descriptionController.text,
                                          longDescription:
                                              longDescriptionController.text)
                                      .then((value) => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ShowTasksScreen())));
                                }
                              },
                              text: S.of(context).edit),
                        ],
                      ),
              ),
            );
          },
        ));
  }
}
