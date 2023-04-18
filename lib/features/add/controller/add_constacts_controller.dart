import 'package:clean_arch_class/common/modules/home/domain/models/dtos/user_dto.dart';
import 'package:clean_arch_class/common/modules/home/domain/usecases/add_user_usecase.dart';
import 'package:clean_arch_class/common/modules/home/domain/usecases/update_user_usecase.dart';
import 'package:clean_arch_class/common/modules/shared/response/response_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $AddContactsController = Bind.singleton(
  (i) => AddContactsController(i()),
);

class AddContactsController {
  AddContactsController(this._addUserUseCase);

  final AddUserUseCase _addUserUseCase;

  Future<ResponsePresentation> addContact(UserDto dto) async {
    return await _addUserUseCase(dto);
  }
}
