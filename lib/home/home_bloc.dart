import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:true_tech_pro_bhargav/db/repository.dart';
import 'package:true_tech_pro_bhargav/models/comment.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Repository repository;
  HomeBloc(this.repository) :super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if(event is InitEvent){
      yield* mapInitEventToState();
    }
  }

  Stream<HomeState> mapInitEventToState() async*{
    yield HomeInitial();
    var response=await repository.getUserComments();
    if(response==null){
      yield ErrorState();
    }else{
      List<Comment> comments=response;
      if(comments.length==0){
        yield NoDataState();
      }else{
        yield DisplayDataState(comments);
      }
    }
  }
}
