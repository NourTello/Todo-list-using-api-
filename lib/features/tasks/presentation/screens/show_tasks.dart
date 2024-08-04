import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:tasks_list/core/consts/colors.dart';
import 'package:tasks_list/features/settings/presentation/widgets/actionBar.dart';
import 'package:tasks_list/features/tasks/domain/bloc/tasks_cubit.dart';
import 'package:tasks_list/features/tasks/presentation/screens/filter_tasks.dart';
import '../../../../generated/l10n.dart';
import '../../domain/bloc/tasks_states.dart';
import '../widgest/task_card.dart';
import 'add task.dart';
import 'show_task.dart';

class ShowTasksScreen extends StatelessWidget {
  // TasksCubit cubit = TasksCubit() ;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return BlocProvider(
      create: (BuildContext context) => TasksCubit()..getTasks(pageNumber: 1),

      child: BlocConsumer<TasksCubit, TasksState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = TasksCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              actions: [
                ActionBarSettings(context)
              ],
              title: Text(
                S.of(context).my_tasks,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            bottomNavigationBar: NumberPaginator(
              // by default, the paginator shows numbers as center content
              numberPages: cubit.pagesNumber,
              onPageChange: (int index) {
                cubit.getTasks(pageNumber: index);
              },

            ),
            floatingActionButton: FloatingActionButton.extended(
              icon: Icon(Icons.add),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
              ),
               label:Text(S.of(context).new_task),
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddTask())),

            ),
            body: (state is GetTasksLoadingState)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    padding: EdgeInsets.only(left:12,right:12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(icon:Icon(Icons.filter_list), onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              FilterTasksScreen())).
                          then((value) => cubit.setNewState());
                        }),
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder:(context)=>ShowTaskScreen(task:TasksCubit.tasks[index],))
                                ),
                                child: TaskCard(
                                    checkBoxFunction:
                                    (TasksCubit.tasks[index].completedAt == null) ?
                          (value) =>cubit.completeTask(TasksCubit.tasks[index].id!).then((value) => cubit.getTasks(pageNumber: cubit.currentPageNumber)):
                                        (value)=>print('task is already completed !'),

                                    //cubit.completeTask(1, cubit.tasks[index].id!)
                                    isCompleted: TasksCubit.tasks[index].completedAt != null,
                                    title: TasksCubit.tasks[index].title!,
                                    description: TasksCubit.tasks[index].description!,
                                    height: height,
                                    context: context),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: height /30,
                                  ),
                              itemCount: TasksCubit.tasks.length),
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
