import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/contact_cubit.dart';

class AddTask extends StatelessWidget {
   AddTask({super.key});
   var _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var contactItem = context.read<ContactCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Edit & Add Contact"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              formFields(
                  controller:contactItem.nameController,
                  type: TextInputType.text,
                  hint: 'Contact Name',
                  label: 'Enter Contact Name',
                  icon: Icons.contact_phone),
              const SizedBox(height: 25,),
              formFields(
                  controller: contactItem.phoneController,
                  type: TextInputType.phone,
                  hint: "Contact Phone",
                  label: "Enter Contact Phone",
                  icon: Icons.phone_android),
              const SizedBox(height: 25,),
              formFields(
                  controller: contactItem.emailController,
                  type: TextInputType.emailAddress,
                  hint: "Enter Your Email",
                  label: "Enter Your Email To Store This Number",
                  icon: Icons.email),
              const SizedBox(height: 45,),
              Center(
                child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState?.validate()==true){
                        contactItem.addContact(
                            contactItem.nameController.text,
                            contactItem.phoneController.text,
                            contactItem.emailController.text);
                      }
                      contactItem.nameController.clear();
                      contactItem.phoneController.clear();
                      contactItem.emailController.clear();
                      Navigator.pushNamed(context, "/Home");
                    },
                    child: const Text("Save Number"),
                ),
              )
            ],

          ),
        ),
      ),
    );
  }
}


Widget formFields({
  required TextEditingController controller,
  required TextInputType type,
  required String hint,
  required String label,
  required IconData icon,

})=>SizedBox(
  child: TextFormField(
    controller: controller,
    keyboardType: type,
    textAlignVertical: TextAlignVertical.top,
    decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:const BorderSide(width: 2,)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:const BorderSide(width: 2,)),
        hintText: hint,
        hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
        ),
        labelText: label,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
        ),
        prefixIcon: Icon(icon),
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value){
      if(value==null || value.isEmpty){
        return "This Field Is Required";
      }else{
        return null;
      }
    },
  ),
);