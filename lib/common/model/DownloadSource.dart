import 'package:json_annotation/json_annotation.dart';

/**
 * Created by sppsun
 * Date: 2019-06-06
 */

part 'DownloadSource.g.dart';

@JsonSerializable()
class DownloadSource {
  String url;
  bool isSourceCode;
  String name;
  int size;

  DownloadSource(
    this.url,
    this.isSourceCode,
    this.name,
    this.size,
  );

  factory DownloadSource.fromJson(Map<String, dynamic> json) => _$DownloadSourceFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadSourceToJson(this);
}
