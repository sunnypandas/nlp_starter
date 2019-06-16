import 'package:nlp_starter/common/model/Issue.dart';
import 'package:nlp_starter/common/model/IssueEvent.dart';
import 'package:nlp_starter/common/model/PushEventCommit.dart';
import 'package:nlp_starter/common/model/Release.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by sppsun
 * Date: 2019-06-06
 */

part 'EventPayload.g.dart';

@JsonSerializable()
class EventPayload {

  @JsonKey(name: "push_id")
  int pushId;
  int size;
  @JsonKey(name: "distinct_size")
  int distinctSize;
  String ref;
  String head;
  String before;
  List<PushEventCommit> commits;

  String action;
  @JsonKey(name: "ref_type")
  String refType;
  @JsonKey(name: "master_branch")
  String masterBranch;
  String description;
  @JsonKey(name: "pusher_type")
  String pusherType;

  Release release;
  Issue issue;
  IssueEvent comment;

  EventPayload();

  factory EventPayload.fromJson(Map<String, dynamic> json) => _$EventPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$EventPayloadToJson(this);
}
