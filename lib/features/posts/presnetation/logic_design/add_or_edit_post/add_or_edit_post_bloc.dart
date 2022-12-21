import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:unit_testing/core/errors/failures.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';
import 'package:unit_testing/features/posts/domain/usecases/add_post.dart';
import 'package:unit_testing/features/posts/domain/usecases/update_post.dart';

part 'add_or_edit_post_event.dart';
part 'add_or_edit_post_state.dart';

@injectable
class AddOrEditPostBloc extends Bloc<AddOrEditPostEvent, AddOrEditPostState> {
  final UpdatePost updatePosts;
  final AddPost addPosts;

  final TextEditingController titleController;
  final TextEditingController bodyController;

  AddOrEditPostBloc({
    required this.addPosts,
    required this.updatePosts,
    required this.bodyController,
    required this.titleController,
  }) : super(AddOrEditPostInitial()) {
    on<AddOrEditPostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(OnAddOrEditLoadingState());
        final addOrFailure = await addPosts.addPost(post: event.post);
        _afterEditOrAdd(addOrFailure, emit);
      } else if (event is EditPostEvent) {
        emit(OnAddOrEditLoadingState());
        final editOrFailure = await updatePosts.updatePost(post: event.post);
        _afterEditOrAdd(editOrFailure, emit);
      }
    });
  }

  void _afterEditOrAdd(Either<Failure, Unit> response, Emitter emit) {
    response.fold(
      (failure) {
        emit(OnAddOrEditErrorState());
      },
      (unit) {
        emit(OnAddOrEditDoneState());
      },
    );
  }

  void setEditValues(Post post) {
    titleController.text = post.title;
    bodyController.text = post.body;
  }

  void submit({Post? post}) {
    if (post != null) {
      add(
        EditPostEvent(
          post: Post(
            id: post.id,
            body: bodyController.text,
            title: titleController.text,
          ),
        ),
      );
    } else {
      add(
        AddPostEvent(
          post: Post(
            body: bodyController.text,
            title: titleController.text,
          ),
        ),
      );
    }
  }
}
