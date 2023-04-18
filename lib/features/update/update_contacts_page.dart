import 'package:clean_arch_class/common/modules/home/domain/models/dtos/user_dto.dart';
import 'package:clean_arch_class/features/update/controller/update_contacts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UpdateContactsPage extends StatefulWidget {
  final UserDto? userDto;

  const UpdateContactsPage({super.key, this.userDto});

  @override
  State<UpdateContactsPage> createState() => _UpdateContactsPageState();
}

class _UpdateContactsPageState extends State<UpdateContactsPage> {
  final controller = Modular.get<UpdateContactsController>();
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
        title: const Text('Editar Contato'),
        titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 0, 225, 255),
            fontFamily: 'Times new roman',
            fontWeight: FontWeight.bold,
            fontSize: 24),
        centerTitle: true,
        actions: [
          Visibility(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextButton(
                onPressed: () {
                  //_confirmDelete();
                },
                child: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(255, 0, 225, 255),
                ),
              ),
            ),
          ),
        ],
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
              Text('Nome'),
              TextFormField(
                controller: _nameTextController,
                validator: (v) {
                  if (v!.isEmpty) return 'required';
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: '',
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 0, 225, 255),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Telefone'),
              TextFormField(
                controller: _phoneTextController,
                validator: (v) {
                  if (v!.isEmpty) return 'required';
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "",
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.smartphone,
                    color: Color.fromARGB(255, 0, 225, 255),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text('Email'),
              TextFormField(
                controller: _emailTextController,
                validator: (v) {
                  if (v!.isEmpty) return 'required';
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: "",
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
            // Alterar
            var res = await controller.editContact(UserDto(
              id: widget.userDto!.id,
              name: _nameTextController.text,
              email: _emailTextController.text,
              phone: _phoneTextController.text,
            ));
            if (res.success) {
              await alertMessage('Contato alterado!');
            } else {
              await alertMessage(res.message ?? 'ERROR');
            }
          }
        },
        child: const Text("Salvar"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color.fromARGB(255, 0, 225, 255),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black54,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contatos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Editar',
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
