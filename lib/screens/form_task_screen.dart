import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/utils/dates.dart';
import 'package:master_focus_todo/utils/snack_bar.dart';

const strings = {
  'label_description': 'Descrição',
  'label_total_tomatos': 'Total de pomodoros',
  'label_tomatos_finished': 'Pomodoros já concluídos',
  'label_task_completed': 'Tarefa concluída ?',
  'button_save': 'SALVAR',
  'error_description': 'Por favor, insira uma descrição',
  'error_total_tomatos': 'Por favor, insira um número',
  'error_tomatos_finished': 'Por favor, insira um número',
  'label_date_created': 'Executar no dia ',
  'error_total_tomatos_zero': 'Total de pomodoros não pode ser zero',
  'error_tomatos_finished_greater_than_total':
      'Pomodoros concluídos não pode ser maior que o total de pomodoros',
};

class _NewTask {
  String? id;
  String description = '';
  int totalTomatos = 0;
  int tomatoFinished = 0;
  bool isCompleted = false;
  DateTime createdAt = DateTime.now();

  factory _NewTask(TodoTask? task) {
    if (task != null) {
      return _NewTask._fromTask(task);
    }
    return _NewTask._default();
  }

  _NewTask._default();

  _NewTask._fromTask(TodoTask task) {
    description = task.description;
    totalTomatos = task.pomodoros;
    tomatoFinished = task.pomodoroCompleted;
    isCompleted = task.isCompleted;
    id = task.id;
    createdAt = task.dateCreated;
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'totalTomatos': totalTomatos,
      'tomatoFinished': tomatoFinished,
      'isCompleted': isCompleted,
      'id': id,
      'date_created': createdAt,
    };
  }
}

class FormTaskScreen extends StatefulWidget {
  static const routeName = 'form_task_screen';
  final TodoTask? task;
  const FormTaskScreen({
    super.key,
    this.task,
  });

  @override
  State<FormTaskScreen> createState() => _FormTaskScreenState();
}

class _FormTaskScreenState extends State<FormTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late final _NewTask _newTask;
  String? error;

  @override
  void initState() {
    super.initState();
    _newTask = _NewTask(widget.task);
  }

  Future<void> _onUpdateDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _newTask.createdAt,
      firstDate: DateTime(2021),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      setState(() {
        _newTask.createdAt = date;
      });
    }
  }

  bool _moreValidateForm() {
    if (_newTask.totalTomatos < _newTask.tomatoFinished) {
      setState(() {
        error = strings['error_tomatos_finished_greater_than_total'];
      });

      return false;
    }
    if (_newTask.totalTomatos == 0) {
      setState(() {
        error = strings['error_total_tomatos_zero'];
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                  labelText: strings['label_description'],
                ),
                initialValue: _newTask.description,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return strings['error_description'];
                  }
                  return null;
                },
                onSaved: (value) {
                  _newTask.description = value!;
                },
              ),
              TextFormField(
                initialValue: _newTask.totalTomatos.toString(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: strings['label_total_tomatos'],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return strings['error_total_tomatos'];
                  }
                  return null;
                },
                onSaved: (value) {
                  _newTask.totalTomatos = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _newTask.tomatoFinished.toString(),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: strings['label_tomatos_finished'],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return strings['error_tomatos_finished'];
                  }
                  return null;
                },
                onSaved: (value) {
                  _newTask.tomatoFinished = int.parse(value!);
                },
              ),
              Card(
                elevation: 0,
                margin: const EdgeInsets.only(top: 8),
                child: InkWell(
                  onTap: _onUpdateDate,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              strings['label_date_created']!,
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              formatDate(_newTask.createdAt),
                              style: GoogleFonts.orbitron(
                                fontSize: 24,
                              ),
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
              const Divider(),
              SwitchListTile(
                  title: Text(strings['label_task_completed']!),
                  value: _newTask.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _newTask.isCompleted = value;
                    });
                  }),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    error!,
                    style: const TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      error = null;
                    });
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (!_moreValidateForm()) {
                        return;
                      }

                      Navigator.of(context).pop(_newTask.toMap());
                    }
                  },
                  child: Text(strings['button_save']!),
                ),
              ),
            ],
          )),
    );
  }
}
