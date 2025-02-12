import "package:json_annotation/json_annotation.dart";
import "package:kaiteki/fediverse/backends/twitter/v2/model/media.dart";
import "package:kaiteki/fediverse/backends/twitter/v2/model/tweet.dart";
import "package:kaiteki/fediverse/backends/twitter/v2/model/user.dart";
import "package:kaiteki/utils/utils.dart";

part "response.g.dart";

typedef TweetResponse = Response<Tweet>;
typedef TweetListResponse = Response<List<Tweet>?>;

@JsonSerializable(
  fieldRename: FieldRename.snake,
  genericArgumentFactories: true,
)
class Response<T> {
  final T data;
  final ResponseIncludes? includes;

  const Response({required this.data, this.includes});

  factory Response.fromJson(
    JsonMap json,
    T Function(Object?) jsonFromT,
  ) {
    return _$ResponseFromJson(json, jsonFromT);
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseIncludes {
  final Set<User>? users;
  final Set<Tweet>? tweets;
  final Set<Media>? media;

  const ResponseIncludes({this.users, this.tweets, this.media});

  factory ResponseIncludes.fromJson(JsonMap json) =>
      _$ResponseIncludesFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseError {
  final String message;
  final JsonMap parameters;

  const ResponseError(this.message, {this.parameters = const {}});

  factory ResponseError.fromJson(JsonMap json) => _$ResponseErrorFromJson(json);
}
