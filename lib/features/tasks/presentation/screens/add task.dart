import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tasks_list/core/components/button_component.dart';
import 'package:tasks_list/core/components/text_form_field_component.dart';
import 'package:tasks_list/features/tasks/domain/bloc/tasks_cubit.dart';
import 'package:tasks_list/features/tasks/domain/bloc/tasks_states.dart';

import '../../../../generated/l10n.dart';
import '../../../settings/presentation/widgets/actionBar.dart';
import 'show_tasks.dart';

class AddTask extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var longDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (BuildContext context)=>TasksCubit(),
      child: BlocConsumer<TasksCubit,TasksState>(
        listener: (BuildContext context, state) {
          // if (state is AddTaskLoadingState)
            // EasyLoading.show(status: 'loading...',
            //   maskType: EasyLoadingMaskType.black,
            // );
          if (state is AddTaskSuccessState)
            {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShowTasksScreen()));
            }

        },
        builder: (BuildContext context, Object? state) {
          var cubit =TasksCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                ActionBarSettings(context)
              ],

              title: Text(S.of(context).new_task,style: Theme.of(context).textTheme.titleLarge,),
            ),
            body: SingleChildScrollView(
              child: Form(
                  key: formKey,
                  child: Container(
                    height: height,
                    width: width,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                     // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: height/3,
                            child: Image.asset('assets/images/write.png',fit: BoxFit.contain,)),
                        TextFormFieldComponent(
                          controller: titleController,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).title_validation;
                            }
                            return null;
                          },
                          hintText: S.of(context).title,
                          prefixIcon: Icons.title,
                        ),
                        SizedBox(height: height / 20),
                        TextFormFieldComponent(
                          controller: descriptionController,
                          validation: (value) {
                            if (value!.isEmpty) {
                              return S.of(context).description_validation;
                            }
                            return null;
                          },
                          hintText: S.of(context).description,
                          prefixIcon: Icons.description,
                        ),
                        SizedBox(height: height / 20),
                        TextFormFieldComponent(
                          controller: longDescriptionController,
                          hintText: S.of(context).long_description,
                          prefixIcon: Icons.receipt_long,
                        ),
                        SizedBox(height: height / 10),
                        ButtonComponent(onPressed: (){
                          if (formKey.currentState!.validate())
                          cubit.addTask(title: titleController.text, description: descriptionController.text, longDescription: longDescriptionController.text);
                        }, text:S.of(context).add)

                      ],
                    ),
                  )),
            ),
          );
        },

      ),
    );
  }
}
