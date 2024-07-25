import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/resources/colors.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_bloc.dart';
import 'package:news_app/features/home/presentation/headlines/bloc/headlines_state.dart';

class Headlines extends StatelessWidget {
  const Headlines({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWelcome(),
        _buildSearchBar(),
        _buildHeadlinesSection(),
      ],
    );
  }

  Widget _buildHeadlinesSection() => Container(
        margin: const EdgeInsets.only(top: 30),
        height: 305,
        color: Colors.red,
        child: null,
      );

  Widget _buildSearchBar() => Container(
      margin: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: SizedBox(
        height: 55,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search for article...",
                          hintStyle: const TextStyle(
                              color: CustomColors.grayTextColor),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 55, // Adjust width as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: CustomColors.buttonColor,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/search_icon.svg',
                  semanticsLabel: 'Search Icon',
                  width: 24, // Example size
                  height: 24, // Example size
                  color: Colors.white, // Adjust icon color if needed
                ),
              ),
            ),
          ],
        ),
      ));

  Widget _buildWelcome() => const Padding(
      padding: EdgeInsets.only(top: 70, left: 30, right: 30),
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/images/profile_placeholder.png'),
            width: 50,
            height: 50,
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back!',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),
                Text(
                  'Monday, 3 October',
                  style: TextStyle(
                      fontSize: 14, color: CustomColors.grayTextColor),
                )
              ],
            ),
          ))
        ],
      ));

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
