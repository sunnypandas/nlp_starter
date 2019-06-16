/**
 * Created by sppsun
 * Date: 2019-06-06
 */
import 'package:json_annotation/json_annotation.dart';

/**
 * Created by sppsun
 * Date: 2019-06-06
 */

part 'License.g.dart';

@JsonSerializable()
class License {

  String name;

  License(this.name);

  factory License.fromJson(Map<String, dynamic> json) => _$LicenseFromJson(json);

  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}
