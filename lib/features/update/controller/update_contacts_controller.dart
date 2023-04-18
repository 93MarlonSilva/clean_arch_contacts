import 'package:clean_arch_class/common/modules/home/domain/models/dtos/user_dto.dart';
import 'package:clean_arch_class/common/modules/home/domain/usecases/add_user_usecase.dart';
import 'package:clean_arch_class/common/modules/home/domain/usecases/update_user_usecase.dart';
import 'package:clean_arch_class/common/modules/shared/response/response_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';

final $UpdateContactsController = Bind.singleton(
  (i) => UpdateContactsController(i()),
);

class UpdateContactsController {
  UpdateContactsController(this._updateUserUseCase);

  final UpdateUserUseCase _updateUserUseCase;

  Future<ResponsePresentation> editContact(UserDto dto) async {
    return await _updateUserUseCase(dto);
  }
}
