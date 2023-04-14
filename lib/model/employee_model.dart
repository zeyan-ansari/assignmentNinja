import 'package:hive/hive.dart';
part 'employee_model.g.dart';

@HiveType(typeId: 1)
class People {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String role;

  @HiveField(2)
  final String startDate;

  @HiveField(3)
  final String endDate;
  @HiveField(4)
  final bool? isCurrentEmployee;
  People({
    required this.name,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.isCurrentEmployee,
  });
}