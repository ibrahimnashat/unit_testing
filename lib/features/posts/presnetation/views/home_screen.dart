import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unit_testing/core/injection/injection.dart';
import 'package:unit_testing/features/posts/presnetation/logic_design/home/post_bloc.dart';
import 'package:unit_testing/features/posts/presnetation/widgets/post_item.dart';

import 'add_or_edit_post_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PostBloc bloc = getIt<PostBloc>();
  @override
  void initState() {
    bloc.add(PostsLoading());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Posts',
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is PostsLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 21.0),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: state.posts.map((post) {
                  return PostItem(
                    post: post,
                    bloc: bloc,
                  );
                }).toList(),
              ),
            );
          } else if (state is PostsIsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                key: Key('home-loader'),
                color: Colors.blue,
              ),
            );
          }
          return const Center(
            child: Text(
              'Please try again later.',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOrDeleteOrEditPostScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
