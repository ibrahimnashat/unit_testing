import 'package:json_annotation/json_annotation.dart';
import 'package:unit_testing/features/posts/domain/entities/post.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Post {
  final int? userId;

  const PostModel({
    this.userId,
    required super.body,
    super.id,
    required super.title,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
