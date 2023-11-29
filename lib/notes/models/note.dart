import 'package:equatable/equatable.dart';
// import 'package:notes_tasks/models/tiers.dart';

// import 'package:notes_tasks/models/tiers.dart';
// import 'package:notes_tasks/tasks/models/task.dart';

final class Note extends Equatable {
  const Note({
    required this.id,
    required this.index,
    required this.text,
    // required this.tier,
    // required this.duration,
    // required this.task,
    // required this.group,
  });

  final String id;
  final int index;
  final String text;
  // final Tiers? tier;
  // final int? duration;
  // final Task task;
  // final Group group;

  Note copyWith({String? id, int? index, String? text}) {
    return Note(
      id: id ?? this.id,
      index: index ?? this.index,
      text: text ?? this.text,
      // tier: tier?? this.tier,
      // duration: duration?? this.duration,
      // task: task?? this.task,
      // group: group?? this.group,
    );
  }

  @override
  List<Object> get props => [
        id,
        index,
        text,
        // tier,
        // duration,
        // task,
        // group,
      ];
}
