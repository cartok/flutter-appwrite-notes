import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_tasks/notes/bloc/note_bloc.dart';

import 'package:notes_tasks/notes/widgets/bottom_loader.dart';
import 'package:notes_tasks/notes/widgets/notes_list_item.dart';
import 'package:visibility_detector/visibility_detector.dart';

class NotesList extends StatefulWidget {
  const NotesList({super.key});

  @override
  State<NotesList> createState() => _NotesListState();
}

class _NotesListState extends State<NotesList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    print('scroll');
    if (_isBottom) context.read<NoteBloc>().add(RequestNotes());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        switch (state.status) {
          case NotesFetchStatus.failure:
            return const Center(child: Text('failed to fetch notes'));
          case NotesFetchStatus.success:
            if (state.notes.isEmpty) {
              return const Center(child: Text('no notes'));
            }

            return LayoutBuilder(builder: (
              BuildContext context,
              BoxConstraints constraints,
            ) {
              // TODO: Looks like I can remove `LayoutBuilder` as `VisibilityDetector` is enough.
              print('height: ${constraints.biggest.height}');
              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    VisibilityDetector(
                      key: UniqueKey(),
                      onVisibilityChanged: (info) {
                        print('visibility ${info.visibleFraction}');
                        if (info.visibleFraction == 1) {
                          context.read<NoteBloc>().add(RequestNotes());
                        }
                      },
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: state.hasReachedMax
                            ? state.notes.length
                            : state.notes.length +
                                1, // One more for the `BottomLoader`.
                        itemBuilder: (BuildContext context, int index) {
                          return index >= state.notes.length
                              // TODO: Maybe put the `BottomLoader` into a stack.
                              ? const BottomLoader()
                              : NotesListItem(note: state.notes[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            });

          case NotesFetchStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
