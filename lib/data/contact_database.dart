import 'package:hive/hive.dart';

import 'models/contact_model.dart';

class ContactDataBase {

  final myBox = Hive.box<ContactModel>("contactBox");

  void addContact(ContactModel contactModel){
      myBox.add(contactModel);
  }

  void deleteContact(int index){
      myBox.deleteAt(index);
  }

  void updateContact(int index,ContactModel contactModel){
    myBox.putAt(index, contactModel);
  }

  List<ContactModel> getContact(){
    return myBox.isNotEmpty ? myBox.values.toList() : [] ;
  }
}