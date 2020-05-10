import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:catexplorer/simple_bloc_delegate.dart';
import 'package:catexplorer/widgets/widgets.dart';
import 'package:catexplorer/repositories/repositories.dart';
import 'package:catexplorer/blocs/blocs.dart';

void main() {
  final CatsRepository catsRepository = CatsRepository(
    catsApiClient: CatsApiClient(
      httpClient: http.Client(),
    ),
  );
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        )
      ],
      child: App(catsRepository: catsRepository),
    ),
  );
}

class App extends StatelessWidget {
  final CatsRepository catsRepository;

  App({Key key, @required this.catsRepository})
      : assert(catsRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          title: 'CatExplorer',
          theme: themeState.theme,
          home: BlocProvider(
            create: (context) => CatsBloc(
              catsRepository: catsRepository,
            ),
            child: CatsScreen(),
          ),
        );
      },
    );
  }
}
