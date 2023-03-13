import 'package:exercise_tracker/ui/Activity/pages/home.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  final List<User> _users = [
    User(
        id: "1",
        name: "Fabian",
        lastName: "Vargas",
        email: "fabian@gmail.com",
        password: "fabian123"),
    User(
        id: "2",
        name: "Freddy",
        lastName: "Guette",
        email: "freddy@gmail.com",
        password: "freddy123"),
    User(
        id: "3",
        name: "Luis",
        lastName: "Caro",
        email: "luis@gmail.com",
        password: "luis123"),
    User(
        id: "4",
        name: "Angel",
        lastName: "Rivera",
        email: "angel@gmail.com",
        password: "angel123"),
  ].obs;

  Rx<User?> user = Rx<User?>(null);
  User? get userInfo => user.value;

  void login(String email, String password) {
    late User foundUser;
    int sw = 1;

    for (User elem in _users) {
      if (elem.email == email && elem.password == password) {
        foundUser = elem;
        sw = 0;
        break;
      }
    }

    if (sw == 0) {
      user.value = foundUser;
      Get.to(() => HomeView());
    } else {
      Get.snackbar('Error', 'Usuario o contraseña invalidos');
    }
  }

  void register(String name, String lastName, String email, String password) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    int sw = 1;
    for (User elem in _users) {
      if (elem.email == email) {
        sw = 0;
        break;
      }
    }

    if (sw == 1) {
      if (emailRegex.hasMatch(email)) {      User userToAdd = User(
          id: (_users.length + 1).toString(),
          name: name,
          lastName: lastName,
          email: email,
          password: password);
      _users.add(userToAdd);
      user.value = userToAdd;
      Get.to(() => HomeView());
  // El texto es una dirección de correo electrónico válida
} else {
    Get.snackbar('Error', 'Digite una direccion de correo valida');
  // El texto no es una dirección de correo electrónico válida
}

    } else {
      Get.snackbar('Error', 'Este correo ya se encuentra registrado');
    }
  }

  void logout() {
    user.value = null;
    Get.offAllNamed('/');
  }
}
