import 'package:nlp_starter/common/model/CommitFile.dart';
import 'package:nlp_starter/common/model/CommitGitInfo.dart';
import 'package:nlp_starter/common/model/CommitStats.dart';
import 'package:nlp_starter/common/model/RepoCommit.dart';
import 'package:nlp_starter/common/model/User.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by sppsun
 * Date: 2019-06-06
 */

part 'PushCommit.g.dart';

@JsonSerializable()
class PushCommit {
  List<CommitFile> files;

  CommitStats stats;

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

  PushCommit(
    this.files,
    this.stats,
    this.sha,
    this.url,
    this.htmlUrl,
    this.commentsUrl,
    this.commit,
    this.author,
    this.committer,
    this.parents,
  );

  factory PushCommit.fromJson(Map<String, dynamic> json) => _$PushCommitFromJson(json);

  Map<String, dynamic> toJson() => _$PushCommitToJson(this);
}
