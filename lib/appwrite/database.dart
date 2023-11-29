import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:notes_tasks/appwrite/account.dart';
import 'package:notes_tasks/appwrite/client.dart';

final Database database = Database(client);

// TODO: Check if this class is even needed. Maybe JWT regeneration is handled in the SDK already.
class Database extends Databases {
  // I could no longer use default values for `databaseId` in overridden methods cause
  // dotenv gives non const values.
  static final String databaseId = dotenv.get('DATABASE_ID');
  static final String notesCollectionId = dotenv.get('NOTES_COLLECTION_ID');
  static final String tasksCollectionId = dotenv.get('TASKS_COLLECTION_ID');

  static Database? _instance;
  Database._private(Client client) : super(client);
  factory Database(Client client) {
    _instance ??= Database._private(client);
    return _instance!;
  }

  Future<T> wrap<T>(Future<T> Function() closure) async {
    try {
      return await closure();
    } catch (e) {
      inspect(e);

      try {
        var jwt = await account.createJWT();
        client.setJWT(jwt.jwt);

        return await closure();
      } catch (e) {
        inspect(e);

        // TODO: Rather check error type string.
        if (e is AppwriteException && e.code == 401) {
          // TODO: Create and send a Bloc event, listen to it in view and redirect to login screen.
          rethrow;
        }

        throw Exception('Unexpected error while refreshing JWT.'
            'Check the database configuration.');
      }
    }
  }

  @override
  Future<DocumentList> listDocuments({
    required String databaseId,
    required String collectionId,
    List<String>? queries,
  }) async {
    return wrap(() => super.listDocuments(
          databaseId: databaseId,
          collectionId: collectionId,
          queries: queries,
        ));
  }

  @override
  Future<Document> getDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    List<String>? queries,
  }) {
    return wrap(() => super.getDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          queries: queries,
        ));
  }

  @override
  Future<Document> createDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    required Map data,
    List<String>? permissions,
  }) {
    return wrap(() => super.createDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          data: data,
          permissions: permissions,
        ));
  }

  @override
  Future<Document> updateDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
    Map? data,
    List<String>? permissions,
  }) {
    return wrap(() => super.updateDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
          data: data,
          permissions: permissions,
        ));
  }

  @override
  Future deleteDocument({
    required String databaseId,
    required String collectionId,
    required String documentId,
  }) {
    return wrap(() => super.deleteDocument(
          databaseId: databaseId,
          collectionId: collectionId,
          documentId: documentId,
        ));
  }
}