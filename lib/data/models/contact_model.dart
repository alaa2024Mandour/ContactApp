
import 'package:hive/hive.dart';

part 'refactor_model.g.dart';

@HiveType(typeId: 0)
class ContactModel extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String email;

  ContactModel({
    required this.name,
    required this.phone,
    required this.email
});
}