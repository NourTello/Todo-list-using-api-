import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_list/core/components/button_component.dart';
import 'package:tasks_list/core/consts/colors.dart';
import 'package:tasks_list/features/settings/presentation/screens/settings.dart';
import 'package:tasks_list/features/tasks/domain/bloc/tasks_cubit.dart';
import 'package:tasks_list/features/tasks/domain/model/tasks_model.dart';
import 'package:tasks_list/features/tasks/presentation/screens/edit_task.dart';
import 'package:tasks_list/features/tasks/presentation/screens/show_tasks.dart';

import '../../../../generated/l10n.dart';
import '../../../settings/presentation/widgets/actionBar.dart';
import '../../domain/bloc/tasks_states.dart';

class ShowTaskScreen extends StatelessWidget {
  TaskData task;
  ShowTaskScreen({required TaskData this.task});

  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return BlocProvider(
        create: (BuildContext context) => TasksCubit(),
        child: BlocConsumer<TasksCubit, TasksState>(
          listener: (BuildContext context, state) {
            if (state is DeleteTaskSuccessState)
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowTasksScreen()));
          },
          builder: (BuildContext context, Object? state) {
            var cubit = TasksCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                actions: [ActionBarSettings(context)],
              ),
              body: Container(
                padding: EdgeInsets.all(16),
                child: state is DeleteTaskLoadingState?Center(child: CircularProgressIndicator()):Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                                height: height/2.5,
                                child: Container(
                              child:Image.asset('assets/images/octobus.png'),
                            )),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).title+' : ',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: width / 20,
                                    ),
                                    Text(
                                      task.title!,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 30,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).description+' : ',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: width / 20,
                                    ),
                                    Text(
                                      "${task.description!}",
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 30,
                                ),
                                if (task.longDescription!=null)
                                Row(
                                  children: [
                                    Text(
                                      S.of(context).long_description+' : ',
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    SizedBox(
                                      width: width / 20,
                                    ),
                                    Text(
                                      " ${task.longDescription}",
                                      style: Theme.of(context).textTheme.bodyLarge,
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
                    Row(
                      children: [
                        Expanded(
                          child: ButtonComponent(
                              onPressed: () {
                                cubit.deleteTask(task.id!);
                              },
                              text: 'Delete',
                              color: secondaryColor,
                          ),
                        ),
                        SizedBox(
                          width: width / 10,
                        ),
                        Expanded(
                          child: ButtonComponent(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditTaskScreen(task: task))),
                              text: 'Edit'),
                        )
                      ],
                    )


                  ],
                ),
              ),
            );
          },
        ));
  }
}
