import 'package:nlp_starter/common/model/CommitGitInfo.dart';
import 'package:nlp_starter/common/model/User.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by sppsun
 * Date: 2019-06-06
 */

part 'RepoCommit.g.dart';

@JsonSerializable()
class RepoCommit {
  String sha;
  String url;
  @JsonKey(name: "html_url")
  String htmlUrl;
  @JsonKey(name: "comments_url")
  String commentsUrl;

  CommitGitInfo commit;
  User author;
  User committer;
  List<RepoCommit> parents;

  RepoCommit(
    this.sha,
    this.url,
    this.htmlUrl,
    this.commentsUrl,
    this.commit,
    this.author,
    this.committer,
    this.parents,
  );

  factory RepoCommit.fromJson(Map<String, dynamic> json) => _$RepoCommitFromJson(json);
  Map<String, dynamic> toJson() => _$RepoCommitToJson(this);
}
