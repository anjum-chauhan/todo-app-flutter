import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/components/custom_inputfield.dart';
import 'package:todoapp/models/todo_class.dart';

class ToDoDetails extends StatefulWidget {
  final toDo;
  ToDoDetails({this.toDo});

  @override
  State<StatefulWidget> createState() => _ToDoDetails();
}

class _ToDoDetails extends State<ToDoDetails> {
  TodoBloc todoBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc..add(GetTodoDetails(widget.toDo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Details'),
        actions: <Widget>[
          GestureDetector(
            child: Center(child: Text('SAVE')),
            onTap: () {
              todoBloc..add(SaveTodoDetails(widget.toDo));
              Navigator.pop(context);
            },
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return buildLoading();
          } else if (state is TodoDetails) {
            return buildTodoDetails();
          } else
            return Container();
        },
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildTodoDetails() {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Text(
            widget.toDo.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          CustomInputField(
            txtInputType: TextInputType.multiline,
            hintText: 'Enter Todo details',
            initialValue: widget.toDo.details ?? '',
            onChanged: (value) {
              widget.toDo.details = value;
            },
          )
        ],
      ),
    );
  }
}
