part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class CreateNote extends NoteEvent {
  // @override
  // List<Object> get props => []; // What to do here?
}

final class RequestNotes extends NoteEvent {}

final class DeleteNote extends NoteEvent {}

final class UpdateNote extends NoteEvent {}
