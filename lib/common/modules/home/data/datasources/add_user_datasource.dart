import 'package:clean_arch_class/common/modules/home/domain/models/dtos/user_dto.dart';

abstract class AddUserDataSource {
  Future<Map<String, dynamic>> call(UserDto dto);
}
