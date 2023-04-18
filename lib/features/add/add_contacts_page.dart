import 'package:clean_arch_class/common/modules/home/domain/models/dtos/user_dto.dart';
import 'package:clean_arch_class/features/add/controller/add_constacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({
    this.userDto,
    super.key,
  });

  final UserDto? userDto;

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  final controller = Modular.get<AddContactsController>();
  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.userDto != null) {
      _nameTextController.text = widget.userDto!.name ?? '';
      _emailTextController.text = widget.userDto!.email ?? '';
      _phoneTextController.text = widget.userDto!.phone ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.cyanAccent.shade200,
        title: Text(
          widget.userDto == null ? "Novo Contato" : "Alterar Contato",
        ),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 0, 225, 255),
            fontFamily: 'Times new roman',
            fontWeight: FontWeight.bold,
            fontSize: 24),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              TextFormField(
                controller: _nameTextController,
                validator: (v) {
                  if (v!.isEmpty) return 'required';
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Nome",
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 0, 225, 255),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneTextController,
                validator: (v) {
                  if (v!.isEmpty) return 'required';
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Telefone",
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.smartphone,
                    color: Color.fromARGB(255, 0, 225, 255),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailTextController,
                validator: (v) {
                  if (v!.isEmpty) return 'required';
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 0, 225, 255),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 225, 255),
        onPressed: () async {
          if (formKey.currentState!.validate()) {
            // Adicionar
            if (widget.userDto == null) {
              var res = await controller.addContact(UserDto(
                name: _nameTextController.text,
                email: _emailTextController.text,
                phone: _phoneTextController.text,
                createdAt: 'createdAt',
              ));
              if (res.success) {
                await alertMessage('Contato adicionado!');
                Modular.to.pop();
                Modular.to.pop(true);
              } else {
                await alertMessage(res.message ?? 'ERROR');
              }
            }
          }
        },
        child: const Text("Salvar"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 0, 225, 255),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black54,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contatos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note_outlined),
            label: 'Call',
          ),
        ],
      ),
    );
  }

  Future alertMessage(String message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Aviso"),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () => Modular.to.pop(),
              child: const Text("Fechar"),
            ),
          ],
        );
      },
    );
  }
}
