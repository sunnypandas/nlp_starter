import 'package:nlp_starter/common/model/CommitGitUser.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by sppsun
 * Date: 2019-06-06
 */

part 'CommitGitInfo.g.dart';

@JsonSerializable()
class CommitGitInfo  {
  String message;
  String url;
  @JsonKey(name: "comment_count")
  int commentCount;
  CommitGitUser author;
  CommitGitUser committer;

  CommitGitInfo(
    this.message,
    this.url,
    this.commentCount,
    this.author,
    this.committer,
  );

  factory CommitGitInfo.fromJson(Map<String, dynamic> json) => _$CommitGitInfoFromJson(json);


  Map<String, dynamic> toJson() => _$CommitGitInfoToJson(this);
}
