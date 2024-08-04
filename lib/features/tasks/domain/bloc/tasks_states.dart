abstract class TasksState {}

class TasksInitialState extends TasksState {}
class SetNewTaskState extends TasksState {}

class AddTaskLoadingState extends TasksState {}

class AddTaskSuccessState extends TasksState {}

class AddTaskErrorState extends TasksState {}

class GetTasksLoadingState extends TasksState {}
class GetTasksErrorState extends TasksState {}
class GetTasksSuccessState extends TasksState {}

class CompleteTaskLoadingState extends TasksState{}
class CompleteTaskErrorState extends TasksState{}
class CompleteTaskSuccessState extends TasksState{}

class EditTaskLoadingState extends TasksState{}
class EditTaskErrorState extends TasksState{}
class EditTaskSuccessState extends TasksState{}


class DeleteTaskLoadingState extends TasksState{}
class DeleteTaskErrorState extends TasksState{}
class DeleteTaskSuccessState extends TasksState{}

class ChangeDateFilterState extends TasksState{}