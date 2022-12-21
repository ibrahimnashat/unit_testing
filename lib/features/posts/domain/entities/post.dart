import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int? id;
  final String title;
  final String body;

  const Post({
    required this.body,
    this.id,
    required this.title,
  });
  @override
  List<Object?> get props => [];
}
