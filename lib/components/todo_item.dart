import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final bool completed;
  final String content;
  final Function(bool?)? onChanged;
  final Function() onEdit;
  final Function() onDelete;

  const TodoItem(
      {super.key,
      required this.completed,
      required this.content,
      required this.onChanged,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0),
      shadowColor: Colors.transparent,
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
        contentPadding: const EdgeInsets.all(-4),
        tileColor: const Color.fromARGB(25, 129, 109, 252),
        shape: RoundedRectangleBorder(
            side: const BorderSide(
                color: Color.fromARGB(25, 129, 109, 252), width: 2),
            borderRadius: BorderRadius.circular(7)),
        horizontalTitleGap: 7,
        leading: Transform.scale(
          scale: 1.1,
          child: Checkbox(
              visualDensity: VisualDensity.compact,
              side: BorderSide(width: 1, color: Theme.of(context).primaryColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              fillColor: completed
                  ? MaterialStatePropertyAll<Color>(
                      Theme.of(context).primaryColor)
                  : const MaterialStatePropertyAll<Color>(Colors.white),
              value: completed,
              onChanged: onChanged),
        ),
        trailing: PopupMenuButton(
          offset: const Offset(-20, -30),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: const EdgeInsets.all(0),
          position: PopupMenuPosition.under,
          child: SizedBox(
            height: double.maxFinite,
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryColor,
            ),
          ),
          itemBuilder: (context) {
            return <PopupMenuEntry<TextButton>>[
              PopupMenuItem(
                padding: const EdgeInsets.all(0),
                child: Center(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(50, 200, 191, 255)))),
                    child: TextButton(
                      onPressed: onEdit,
                      child: const Text("Editar",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),
              ),
              PopupMenuItem(
                child: Center(
                  child: TextButton(
                    onPressed: onDelete,
                    child: const Text(
                      "Deletar",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              )
            ];
          },
        ),
        title: Text(
          content,
        ),
      ),
    );
  }
}
