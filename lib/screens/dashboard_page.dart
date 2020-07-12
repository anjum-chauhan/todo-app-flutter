import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/todo_bloc.dart';
import 'package:todoapp/models/todo_class.dart';
import 'package:todoapp/screens/todo_details_page.dart';
import '../constants.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  TodoBloc todoBloc;
  var tempTodoList;
  @override
  void initState() {
    super.initState();
    todoBloc = BlocProvider.of<TodoBloc>(context);
    todoBloc..add(GetTodo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo App'),
        ),
        body: BlocBuilder<TodoBloc, TodoState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is TodoInitial) {
              return buildLoading();
            }
            if (state is TodoLoading) {
              return buildLoading();
            } else if (state is TodoLoaded) {
              tempTodoList = state.todo;
              return todoListView(state.todo);
            } else if (state is TodoError) {
              return getNoConnectionWidget(state.message);
            } else if (state is TodoDetails) {
              return todoListView(tempTodoList);
            } else
              Container();
          },
        ));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget todoListView(List<ToDo> todoList) {
    return ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading:
                todoList[index].completed ? kIconCompleted : kIconNotCompleted,
            title: Text(todoList[index].title),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<TodoBloc>(context),
                          child: ToDoDetails(
                            toDo: todoList[index],
                          ),
                        ),
                    maintainState: true),
              );
            },
          );
        });
  }

  Widget getNoConnectionWidget(String message) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 60.0,
          child: new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('images/wifi.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        new Text(message),
        SizedBox(
          height: 20,
        ),
        new FlatButton(
            color: Colors.red,
            child: new Text(
              "Retry",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => {todoBloc..add(GetTodo())})
      ],
    );
  }
}
