import 'dart:async';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:notes_tasks/appwrite/database.dart';
import 'package:notes_tasks/notes/models/note.dart';

part './note_event.dart';
part './note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final int pageSize = 10;
  String? lastDocumentId;

  NoteBloc() : super(const NoteState()) {
    // TODO: Before the development of the other functions try out the realtime API first.
    // The Changes made on any device should automatically be reflected on all devices
    // https://appwrite.io/docs/apis/realtime

    // on<CreateNote>(_onCreateNote);
    on<RequestNotes>(
      _onRequestNotes,
      transformer: throttleDroppable(Duration(milliseconds: 100)),
    );
    // on<UpdateNote>(_onUpdateNote);
    // on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onCreateNote(CreateNote event, Emitter<NoteState> emit) async {
    print('onCreateNote');
    DocumentList? response;
    try {
      // response = await database.createDocument(
      //   collectionId: Database.notesCollectionId,
      //   documentId: '00000000000', // TODO: How to solve reordering and realtime updates?
      //   data: Map(), // How to fill data?
      // );
    } catch (exception) {
      throw Exception('Error creating note.');
    }

    inspect(response);
  }

  Future<void> _onUpdateNote(UpdateNote event, Emitter<NoteState> emit) async {
    print('onUpdateNote');
    DocumentList? response;
    try {
      // response = await database.updateDocument(
      //   collectionId: Database.notesCollectionId,
      //   documentId: '00000000000', // TODO: How to solve reordering and realtime updates?
      //   data: Map(), // How to fill data?
      // );
    } catch (exception) {
      throw Exception('Error updating note.');
    }

    inspect(response);
  }

  Future<void> _onDeleteNote(UpdateNote event, Emitter<NoteState> emit) async {
    print('onDeleteNote');
    DocumentList? response;
    try {
      // response = await database.deleteDocument(
      //   collectionId: Database.notesCollectionId,
      //   documentId: '00000000000', // TODO: How to solve reordering and realtime updates?
      // );
    } catch (exception) {
      throw Exception('Error deleting note.');
    }

    inspect(response);
  }

  Future<void> _onRequestNotes(
    RequestNotes event,
    Emitter<NoteState> emit,
  ) async {
    print('onRequestNote');
    if (state.hasReachedMax) return;

    DocumentList? response;
    try {
      // Request some notes.
      response = await database.listDocuments(
        databaseId: Database.databaseId,
        collectionId: Database.notesCollectionId,
        queries: [
          Query.limit(pageSize),
          // TODO: Cursor does not work when i have both tier and index order query enabled.
          // Probably only one order command works and it's due to how SQL works https://stackoverflow.com/questions/27931257/how-to-combine-two-sql-queries-with-different-order-by-clauses
          // if (lastDocumentId != null) Query.cursorAfter(lastDocumentId!),
          Query.offset(state.notes.length),
          Query.orderDesc('tier'),
          Query.orderAsc('index'),
        ],
      );
      inspect(response);
    } catch (e) {
      inspect(e);
      emit(state.copyWith(status: NotesFetchStatus.failure));
      throw Exception('Could not get documents from database');
    }

    // Return if there is no more data.
    // Otherwise save the last document id for next request, create and emit notes.
    if (response.documents.isEmpty) {
      return;
    }

    lastDocumentId = response.documents[response.documents.length - 1].$id;

    // Create new notes.
    final notes = response.documents
        .map((d) => Note(
              id: d.$id,
              text: d.data['text'],
              index: d.data['index'],
            ))
        .toList();
    inspect(notes);

    // Update state.
    emit(state.copyWith(
      status: NotesFetchStatus.success,
      notes: List.of(state.notes)..addAll(notes),
      hasReachedMax: state.notes.length + notes.length == response.total,
    ));
  }
}

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
