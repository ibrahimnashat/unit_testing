part of 'add_or_edit_post_bloc.dart';

abstract class AddOrEditPostEvent extends Equatable {
  const AddOrEditPostEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AddOrEditPostEvent {
  final Post post;

  const AddPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}

class EditPostEvent extends AddOrEditPostEvent {
  final Post post;

  const EditPostEvent({required this.post});
  @override
  List<Object> get props => [post];
}
