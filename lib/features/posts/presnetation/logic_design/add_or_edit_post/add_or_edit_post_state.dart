part of 'add_or_edit_post_bloc.dart';

abstract class AddOrEditPostState extends Equatable {
  const AddOrEditPostState();

  @override
  List<Object> get props => [];
}

class AddOrEditPostInitial extends AddOrEditPostState {}

class OnAddOrEditLoadingState extends AddOrEditPostState {}

class OnAddOrEditErrorState extends AddOrEditPostState {}

class OnAddOrEditDoneState extends AddOrEditPostState {}
