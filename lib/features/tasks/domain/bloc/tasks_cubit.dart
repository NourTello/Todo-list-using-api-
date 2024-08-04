import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_list/features/tasks/data/tasks_repo.dart';
import 'package:tasks_list/features/tasks/domain/bloc/tasks_states.dart';
import 'package:tasks_list/features/tasks/domain/model/tasks_model.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksInitialState());
  TasksRepo tasksRepo = TasksRepo();

  static TasksCubit get(context) => BlocProvider.of(context);

 static  List<TaskData> tasks = [];
  int pagesNumber = 1;
  int currentPageNumber = 1;
  List<String> dateFilterOptionsList = [
    'equal',
    'before',
    'after',
    'before or equal',
    'after or equal'
  ];
  String currentDateFilter = 'equal';

  void changeFilterDate(String value) {
    currentDateFilter = value;
    print(currentDateFilter);
    emit(ChangeDateFilterState());
  }

  addTask(
      {required String title,
      required String description,
      required String longDescription}) async {
    emit(AddTaskLoadingState());
    bool response = await tasksRepo.addTask(
        title: title,
        description: description,
        longDescription: longDescription);
    if (response)
      emit(AddTaskSuccessState());
    else
      emit(AddTaskErrorState());
  }
  setNewState () {
    emit(SetNewTaskState());
  }
  getTasks({required int pageNumber}) async {
    emit(GetTasksLoadingState());
    currentPageNumber = pageNumber;
    var response = await tasksRepo.getTasks(pageNumber: pageNumber);
    if (response.success) {
      pagesNumber = response.meta!.lastPage!;
      tasks = response.data!;
      emit(GetTasksSuccessState());
    } else
      emit(GetTasksErrorState());
  }

  Future<void> completeTask(int id) async {
    emit(CompleteTaskLoadingState());
    var response = await tasksRepo.completeTask(id);
    if (response)
      emit(CompleteTaskSuccessState());
    else
      emit(CompleteTaskErrorState());
  }

  Future<void> editTask(
      {required int id,
      required String title,
      required String description,
      required String longDescription}) async {
    emit(EditTaskLoadingState());
    bool response = await tasksRepo.editTask(
        id: id,
        title: title,
        description: description,
        longDescription: longDescription);
    if (response)
      emit(EditTaskSuccessState());
    else
      emit(EditTaskErrorState());
  }

  Future<void> deleteTask(int id) async {
    emit(DeleteTaskLoadingState());
    var response = await tasksRepo.deleteTask(id);

    if (response)
      emit(DeleteTaskSuccessState());
    else
      emit(DeleteTaskErrorState());
  }

  Future<void> getFilteredTasks(
      {required String title,
      required String description,
      required String longDescription,
      required String date}) async {
    emit(GetTasksLoadingState());
    var response = await tasksRepo.getFilteredTasks(
        title: title,
        description: description,
        longDescription: longDescription,
        dateOp: currentDateFilter,
        date: date);
    if (response.success) {
      if (response.data!.length==0)
        pagesNumber=1;
      else
      pagesNumber = response.meta!.lastPage!;

      tasks = response.data!;
      emit(GetTasksSuccessState());
    } else
      emit(GetTasksErrorState());
  }
}
