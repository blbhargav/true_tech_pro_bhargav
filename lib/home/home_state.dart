part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class ErrorState extends HomeState {
  @override
  List<Object> get props => [];
}

class NoDataState extends HomeState {
  @override
  List<Object> get props => [];
}

class DisplayDataState extends HomeState {
  final List<Comment> comments;
  DisplayDataState(this.comments);
  @override
  List<Object> get props => [];
}