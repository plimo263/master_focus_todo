import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:master_focus_todo/constants/images_path.dart';
import 'package:master_focus_todo/models/todo_task.dart';
import 'package:master_focus_todo/utils/dates.dart';

const strings = {
  'label_btn_view': 'DETALHES',
  'label_btn_edit': 'EDITAR',
  'label_btn_delete': 'EXCLUIR',
  'label_btn_start': 'INICIAR',
};

class TodoTaskWidget extends StatelessWidget {
  final TodoTask task;
  final Function(BuildContext context, TodoTask task) onDelete;
  final Function(BuildContext context, TodoTask task) onView;
  final Function(BuildContext context, TodoTask task) onEdit;
  final Function(BuildContext context, TodoTask task) onStart;

  const TodoTaskWidget({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onView,
    required this.onEdit,
    required this.onStart,
  });

  IconData? _getIcon() {
    if (task.isCompleted) {
      return Icons.check_circle;
    }
    return Icons.radio_button_unchecked;
  }

  String _formatDateString() {
    return formatDate(task.dateCreated, 'dd/MM/yy', true);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => onStart(context, task),
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                _getIcon(),
                color: Colors.green,
              ),
              title: Text(task.description),
              trailing: _OptionsMenu(
                task: task,
                onDelete: onDelete,
                onView: onView,
                onEdit: onEdit,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        tomatoImg,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${task.pomodoroCompleted} / ${task.pomodoros}',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(width: 4),
                      Text(_formatDateString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionsMenu extends StatelessWidget {
  final TodoTask task;
  final Function(BuildContext context, TodoTask task) onDelete;
  final Function(BuildContext context, TodoTask task) onView;
  final Function(BuildContext context, TodoTask task) onEdit;

  const _OptionsMenu({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onView,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {
        switch (value) {
          case 'view':
            onView(context, task);
            break;
          case 'edit':
            onEdit(context, task);
            break;
          case 'delete':
            onDelete(context, task);
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'view',
            child: _LabelWithIcon(
              label: Text(strings['label_btn_view']!),
              icon: Icons.list_alt,
            ),
          ),
          PopupMenuItem(
            value: 'edit',
            child: _LabelWithIcon(
              label: Text(strings['label_btn_edit']!),
              icon: Icons.edit,
            ),
          ),
          PopupMenuItem(
            value: 'delete',
            child: _LabelWithIcon(
              label: Text(strings['label_btn_delete']!),
              icon: Icons.delete,
            ),
          ),
        ];
      },
    );
  }
}

class _LabelWithIcon extends StatelessWidget {
  final IconData icon;
  final Widget label;
  const _LabelWithIcon({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 4),
        label,
      ],
    );
  }
}
