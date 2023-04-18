import 'package:clean_arch_class/common/modules/home/domain/models/dtos/user_dto.dart';
import 'package:clean_arch_class/features/delete/controller/delete.contacts.controller.dart';
import 'package:clean_arch_class/features/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controllerHome = Modular.get<HomeController>();
  final controllerDelete = Modular.get<DeleteContactsController>();

  @override
  void initState() {
    super.initState();
    getData();
    selectedTile = -1;
  }

  void getData() async {
    await controllerHome.getData();
    setState(() {});
  }

  dynamic selectedIndex = UserDto(name: 'name', phone: 'phone', email: 'email');
  bool pressed = false;
  int selectedTile = -1;
  @override
  Widget build(BuildContext context) {
    String texto = 'Nenhum contato na lista';
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        )),
        title: const Text("Contatos"),
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 0, 225, 255),
          fontSize: 24,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times new roman',
        ),
        centerTitle: true,
        elevation: 5,
        shadowColor: Colors.cyanAccent.shade200,
        leading: Container(
          decoration: null,
          child: const Icon(
            //colocar um drawer
            Icons.menu, size: 36,
            color: Color.fromARGB(255, 0, 225, 255),
          ),
        ),
        actions: [
          Visibility(
            visible: pressed ?? false,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: TextButton(
                onPressed: () {
                  _confirmDelete(selectedIndex);
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
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 20),
        itemCount: controllerHome.contacts.length,
        itemBuilder: (_, index) {
          final model = controllerHome.contacts[index];
          return SingleChildScrollView(
            //ajustar a scrollbar
            child: ListTile(
              leading: CircleAvatar(
                maxRadius: 26,
                minRadius: 20,
                backgroundColor: const Color.fromARGB(255, 0, 225, 255),
                child: Text(
                  '${model.name?.split('').first.toUpperCase() ?? ''}'
                  '${model.name?.split('').last.toUpperCase() ?? ''}',
                ),
              ),
              title: Text(
                model.name ?? '',
              ),
              subtitle: Text(
                "${model.email ?? ''}\n${model.phone ?? ''}",
              ),
              onTap: () {
                setState(() {
                  pressed = false;
                  selectedIndex = false;
                  selectedTile = -1;
                });
                _updateContact(model);
              },
              onLongPress: () {
                setState(() {
                  pressed = true;
                  selectedIndex = model;
                  selectedTile = index;
                });
              },
              selected: selectedTile == index,
              selectedTileColor: Colors.grey,
              textColor: Colors.white,
              minVerticalPadding: 8,
              selectedColor: Colors.black,
              focusColor: Colors.grey,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 225, 255),
        child: const Icon(
          Icons.add,
        ),
        onPressed: () async {
          var res = await Modular.to.pushNamed('/add');
          if (res == true) {
            getData();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 0, 225, 255),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black54,
        elevation: 10,
        currentIndex: 1,
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
            icon: Icon(Icons.phone),
            label: 'Call',
          ),
        ],
      ),
    );
  }

  void _updateContact(UserDto model) async {
    var res = await Modular.to.pushNamed('/update', arguments: model);
    if (res == true) {
      getData();
    }
  }

  _confirmDelete(UserDto dto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Remover Contato"),
          content: Text("Deseja Remover o ${dto.name ?? 'Contato'} "),
          actions: [
            ElevatedButton(
              onPressed: () async {
                var res = await controllerDelete.deleteData(dto.id);
                if (res.success) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    elevation: 10,
                    backgroundColor: Colors.cyan,
                    content: const Center(
                      child: Text('Contato Deletado com Sucesso'),
                    ),
                    duration: const Duration(seconds: 6),
                    action: SnackBarAction(label: 'label', onPressed: () {}),
                  ));
                  getData();
                }
                selectedIndex = false;
                Modular.to.pop();
              },
              child: const Text("SIM"),
            ),
            OutlinedButton(
              onPressed: Modular.to.pop,
              child: const Text("Não"),
            ),
          ],
        );
      },
    );
  }
}
