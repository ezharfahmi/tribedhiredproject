part of 'menu_bloc.dart';

@immutable
abstract class MenuEvent extends Equatable {
  const MenuEvent();
}

class LoadMenuEvent extends MenuEvent {
  @override
  List<Object?> get props => [];
}

class FetchPostDetail extends MenuEvent {
  final num id;

  const FetchPostDetail({required this.id});

  @override
  List<Object?> get props => [];
}

class LoadCommentEvent extends MenuEvent {
  final num? id;

  const LoadCommentEvent({this.id});

  @override
  List<Object?> get props => [];
}
