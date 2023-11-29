part of 'note_bloc.dart';

enum NotesFetchStatus { initial, success, failure }

final class NoteState extends Equatable {
  const NoteState({
    this.status = NotesFetchStatus.initial,
    this.notes = const <Note>[],
    this.hasReachedMax = false,
  });

  final NotesFetchStatus status;
  final List<Note> notes;
  final bool hasReachedMax;

  NoteState copyWith({
    NotesFetchStatus? status,
    List<Note>? notes,
    bool? hasReachedMax,
  }) {
    return NoteState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'NoteState { status: $status, hasReachedMax: $hasReachedMax, notes: ${notes.length} }';
  }

  @override
  List<Object> get props => [status, notes, hasReachedMax];
}
