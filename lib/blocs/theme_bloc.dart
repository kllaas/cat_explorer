import 'dart:async';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:catexplorer/models/models.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeState extends Equatable {
  final ThemeData theme;
  final bool night;
  final IconData changeThemeIcon;

  const ThemeState(
      {@required this.theme,
      @required this.night,
      @required this.changeThemeIcon})
      : assert(theme != null),
        assert(changeThemeIcon != null),
        assert(night != null);

  @override
  List<Object> get props => [theme, night, changeThemeIcon];
}

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final bool night;

  const ThemeChanged({@required this.night}) : assert(night != null);

  @override
  List<Object> get props => [night];
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState => _getThemeData(false);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeChanged) {
      yield _getThemeData(event.night);
    }
  }

  ThemeState _getThemeData(bool night) {
    if (night) {
      return ThemeState(
          theme: ThemeData(
              primaryColor: Colors.indigo,
              brightness: Brightness.dark),
          night: night,
          changeThemeIcon: Icons.wb_sunny);
    } else {
      return ThemeState(
          theme: ThemeData(
              primaryColor: Colors.orangeAccent,
              brightness: Brightness.light),
          night: night,
          changeThemeIcon: Icons.wb_sunny);
    }
  }
}
