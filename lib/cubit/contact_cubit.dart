import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../data/models/contact_model.dart';

class ContactCubit extends Cubit<List<ContactModel>>{
  final Box<ContactModel> contactBox;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();

  ContactCubit(this.contactBox) : super([]){
    loadContact();
  }

  void loadContact(){
    if(contactBox.isNotEmpty){
      emit(contactBox.values.toList());
    }
  }

  void addContact(String name,String phone,String email){
    var newContact = ContactModel(name: name, phone: phone, email: email);
    contactBox.add(newContact);
    emit([...state,newContact]);
  }

  // void updateContact(int index){
  //   contactBox.putAt(index, state[index]);
  //   emit([...state]);
  // }

  void deleteContact(int index){
    contactBox.delete(index);
    emit([...state..removeAt(index)]);
  }

}