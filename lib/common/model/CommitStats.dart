import 'package:json_annotation/json_annotation.dart';

/**
 * Created by sppsun
 * Date: 2019-06-06
 */

part 'CommitStats.g.dart';

@JsonSerializable()
class CommitStats  {
  int total;
  int additions;
  int deletions;

  CommitStats(this.total, this.additions, this.deletions);

  factory CommitStats.fromJson(Map<String, dynamic> json) => _$CommitStatsFromJson(json);

  Map<String, dynamic> toJson() => _$CommitStatsToJson(this);
}
