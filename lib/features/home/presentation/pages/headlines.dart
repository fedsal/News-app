import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_bloc.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_state.dart';

class Headlines extends StatelessWidget {
  const Headlines({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  _buildBody() {
    return BlocBuilder<HeadlinesBloc, HeadlinesState>(
      builder: (BuildContext context, HeadlinesState state) {
        switch (state.runtimeType) {
          case HeadlinesLoading:
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          case HeadlinesError:
            return const Center(child: Icon(Icons.refresh));
          case HeadlinesSuccess:
            return ListView.builder(
                itemCount: state.articles!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("$index"),
                  );
                });
          default:
            return const SizedBox();
        }
      },
    );
  }
}
