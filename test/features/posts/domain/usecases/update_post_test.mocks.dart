// Mocks generated by Mockito 5.3.2 from annotations
// in unit_testing/test/features/posts/domain/usecases/update_post_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:unit_testing/core/errors/failures.dart' as _i6;
import 'package:unit_testing/features/posts/domain/entities/post.dart' as _i7;
import 'package:unit_testing/features/posts/domain/repository/posts_repository.dart'
    as _i2;
import 'package:unit_testing/features/posts/domain/usecases/update_post.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePostsRepositroy_0 extends _i1.SmartFake
    implements _i2.PostsRepositroy {
  _FakePostsRepositroy_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [UpdatePost].
///
/// See the documentation for Mockito's code generation for more information.
class MockUpdatePost extends _i1.Mock implements _i4.UpdatePost {
  @override
  _i2.PostsRepositroy get postsRepositroy => (super.noSuchMethod(
        Invocation.getter(#postsRepositroy),
        returnValue: _FakePostsRepositroy_0(
          this,
          Invocation.getter(#postsRepositroy),
        ),
        returnValueForMissingStub: _FakePostsRepositroy_0(
          this,
          Invocation.getter(#postsRepositroy),
        ),
      ) as _i2.PostsRepositroy);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i3.Unit>> updatePost(
          {required _i7.Post? post}) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePost,
          [],
          {#post: post},
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, _i3.Unit>>.value(
            _FakeEither_1<_i6.Failure, _i3.Unit>(
          this,
          Invocation.method(
            #updatePost,
            [],
            {#post: post},
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i3.Unit>>.value(
                _FakeEither_1<_i6.Failure, _i3.Unit>(
          this,
          Invocation.method(
            #updatePost,
            [],
            {#post: post},
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i3.Unit>>);
}