import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catexplorer/widgets/cat_item.dart';

import 'package:catexplorer/widgets/widgets.dart';
import 'package:catexplorer/blocs/blocs.dart';
import 'package:google_fonts/google_fonts.dart';

class CatsScreen extends StatefulWidget {
  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CatsBloc>(context).add(FetchCats());

    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('CatExplorer',
                style: GoogleFonts.comfortaa(
                    textStyle: Theme.of(context).textTheme.headline6)),
            actions: <Widget>[
              IconButton(
                icon: Icon(themeState.changeThemeIcon),
                onPressed: () {
                  BlocProvider.of<ThemeBloc>(context).add(
                    ThemeChanged(night: !themeState.night),
                  );
                },
              ),
            ],
          ),
          body: GradientContainer(
            color: themeState.theme.primaryColor,
            child: Center(
              child: BlocConsumer<CatsBloc, CatsState>(
                listener: (context, state) {
                  _refreshCompleter?.complete();
                  _refreshCompleter = Completer();
                },
                builder: (context, state) {
                  if (state is CatsLoading) {
                    return Center(
                        child: Image.asset(
                      "assets/loader.gif",
                      height: 125.0,
                      width: 125.0,
                    ));
                  }
                  if (state is CatsLoaded) {
                    final cats = state.cats;

                    return RefreshIndicator(
                        onRefresh: () {
                          BlocProvider.of<CatsBloc>(context).add(
                            RefreshCats(),
                          );
                          return _refreshCompleter.future;
                        },
                        child: new ListView(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8.0),
                            children: List.generate(cats.length, (index) {
                              return Center(
                                child: CatItem(cat: cats[index]),
                              );
                            })));
                  }
                  if (state is CatsLoadingError) {
                    return Text(
                      'Something went wrong!, error = ${state.error}',
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return Center(child: Text('Please Select a Location'));
                },
              ),
            ),
          ));
    });
  }
}
