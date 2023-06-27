part of 'menu_bloc.dart';

@immutable
abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoadingState extends MenuState {
  List<Object?> get props => [];
}

class MenuLoadedState extends MenuState {
  final List<PostsList> menus;
  MenuLoadedState(this.menus);
  List<Object?> get props => [menus];
}

class MenuErrorState extends MenuState {
  final String error;
  MenuErrorState(this.error);
  List<Object?> get props => [error];
}

class MenuSaveState {
  List<String>? listFood;

  MenuSaveState({this.listFood});

  MenuSaveState copyWith({List<String>? listFood}) =>
      MenuSaveState(listFood: listFood ?? this.listFood);
}

// FETCH COMMENT
class GetCommentInitial extends MenuState {}

class GetCommentLoadingState extends MenuState {
  List<Object?> get props => [];
}

class GetCommentLoadedState extends MenuState {
  final List<CommentList> comment;
  GetCommentLoadedState(this.comment);
  List<Object?> get props => [comment];
}

class GetCommentError extends MenuState {
  final String error;
  GetCommentError(this.error);
  List<Object?> get props => [error];
}
