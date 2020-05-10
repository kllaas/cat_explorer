import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:catexplorer/repositories/repositories.dart';
import 'package:catexplorer/models/models.dart';

abstract class CatsEvent extends Equatable {
  const CatsEvent();

  @override
  List<Object> get props => [];
}

class FetchCats extends CatsEvent {
  const FetchCats();

  @override
  List<Object> get props => [];
}

class RefreshCats extends CatsEvent {

  const RefreshCats();

  @override
  List<Object> get props => [];
}

abstract class CatsState extends Equatable {
  const CatsState();

  @override
  List<Object> get props => [];
}

class CatsEmpty extends CatsState {}

class CatsLoading extends CatsState {}

class CatsLoaded extends CatsState {
  final List<Cat> cats;

  const CatsLoaded({@required this.cats}) : assert(cats != null);

  @override
  List<Object> get props => [cats];
}

class CatsLoadingError extends CatsState {

  final String error;

  const CatsLoadingError({@required this.error}) : assert(error != null);

  @override
  List<Object> get props => [error];

}

class CatsBloc extends Bloc<CatsEvent, CatsState> {
  final CatsRepository catsRepository;

  CatsBloc({@required this.catsRepository})
      : assert(catsRepository != null);

  @override
  CatsState get initialState => CatsEmpty();

  @override
  Stream<CatsState> mapEventToState(CatsEvent event) async* {
    if (event is FetchCats) {
      yield* _mapFetchCatsToState(event);
    } else if (event is RefreshCats) {
      yield* _mapRefreshCatsToState(event);
    }
  }

  Stream<CatsState> _mapFetchCatsToState(FetchCats event) async* {
    yield CatsLoading();
    try {
      final List<Cat> cats = await catsRepository.getCats(false);
      yield CatsLoaded(cats: cats);
    } catch (e) {
      yield CatsLoadingError(error: e.toString());
    }
  }

  Stream<CatsState> _mapRefreshCatsToState(RefreshCats event) async* {
    try {
      final List<Cat> cats = await catsRepository.getCats(true);
      yield CatsLoaded(cats: cats);
    } catch (_) {
      yield state;
    }
  }
}
