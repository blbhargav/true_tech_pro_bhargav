import 'package:true_tech_pro_bhargav/home/home_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:test/test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:true_tech_pro_bhargav/models/comment.dart';
import 'test_repository.dart';
void main() {
  setUpAll(() {
    registerFallbackValue<HomeEvent>(InitEvent());
  });

  mainBloc();
}

void mainBloc() {
  group('HomeBloc', () {
    blocTest<HomeBloc, HomeState>(
      'when no event is added',
      build: () => HomeBloc(TestRepository()),
      expect: () => const <HomeState>[],
    );

    blocTest<HomeBloc, HomeState>(
      'when ChangeEvent is added and response is null',
      build: () => HomeBloc(TestRepository()),
      act: (bloc) => bloc.add(InitEvent()),
      expect: () => <HomeState>[HomeInitial(),ErrorState()],
    );

    blocTest<HomeBloc, HomeState>(
      'when ChangeEvent is added and response is empty i.e List<Comment> = []',
      build: () {
        TestRepository repository=TestRepository();
        List<Comment> comments=[];
        repository.setMockData("getUserComments", comments);
        return HomeBloc(repository);
      },
      act: (bloc) => bloc.add(InitEvent()),
      expect: () => <HomeState>[HomeInitial(),NoDataState()],
    );

    blocTest<HomeBloc, HomeState>(
      'when ChangeEvent is added and with positive response',
      build: () {
        TestRepository repository=TestRepository();
        List<Comment> comments=[Comment(),Comment()];
        repository.setMockData("getUserComments", comments);
        return HomeBloc(repository);
      },
      act: (bloc) => bloc.add(InitEvent()),
      expect: (){
        List<Comment> comments=[Comment(),Comment()];
        return <HomeState>[HomeInitial(),DisplayDataState(comments)];
      },
    );

  });
}