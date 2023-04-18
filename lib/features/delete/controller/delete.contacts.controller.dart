import 'package:clean_arch_class/common/modules/home/domain/models/dtos/user_dto.dart';
import 'package:clean_arch_class/common/modules/home/domain/usecases/delete_user_usecase.dart';
import 'package:clean_arch_class/common/modules/home/domain/usecases/get_users_usecase.dart';
import 'package:clean_arch_class/common/modules/shared/response/response_presentation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

final $DeleteContactsController = Bind.singleton(
  (i) => DeleteContactsController(i()),
);

class DeleteContactsController {
  DeleteContactsController(this._deleteUserUseCase);
  final DeleteUserUseCase _deleteUserUseCase;

  List<UserDto> contacts = [];

  Future<ResponsePresentation> deleteData(String? id) async {
    if (id == null) {
      print("id is null");
      return ResponsePresentation(success: false);
    }
    var res = await _deleteUserUseCase(id);

    if (!res.success) {
      print(res.message);
    }

    return res;
  }
}
