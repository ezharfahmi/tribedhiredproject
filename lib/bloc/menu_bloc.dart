import 'package:tribed_hired_assessment/model/comment_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../model/post_model.dart';
import '../repo/repositories.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final PostRepository _postRepository;

  MenuBloc(this._postRepository) : super(MenuLoadingState()) {
    on<LoadMenuEvent>((event, emit) async {
      emit(MenuLoadingState());
      try {
        final posts = await _postRepository.getPosts();
        emit(MenuLoadedState(posts));
      } catch (e) {
        emit(MenuErrorState(e.toString()));
      }
    });

    on<LoadCommentEvent>((event, emit) async {
      emit(GetCommentLoadingState());
      try {
        final comment = await _postRepository.getComment(event.id ?? 99);
        emit(GetCommentLoadedState(comment));
      } catch (e) {
        emit(MenuErrorState(e.toString()));
      }
    });
  }
}
