import 'package:image_picker/image_picker.dart';
import 'package:name_badge/models/user.dart';
import 'package:name_badge/services/user_manager.dart';

class SetInformationRepository {
  final UserManager userManager = UserManager();
  Future<void> saveUser(User user) async {
    await userManager.saveUser(user);
  }

  Future<User?> getUser() async {
    final user = await userManager.getUser();
    return user;
  }

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }
}
