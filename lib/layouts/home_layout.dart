import 'package:contact_app/cubit/contact_cubit.dart';
import 'package:contact_app/data/models/contact_model.dart';
import 'package:contact_app/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
        builder:(context, value, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: const Center(
                child: Text(
                  "Contacts",
                ),
              ),
              actions: [
                IconButton(
                    onPressed: (){
                        value.toggleTheme();
                    },
                    icon: Container(
                      decoration: BoxDecoration(
                          color:  Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: value.isDark? const Icon(Icons.light_mode) :const Icon(Icons.dark_mode),
                      ),
                    ))
              ],
            ),
            body: BlocBuilder<ContactCubit,List<ContactModel>>(
                builder: (context,contactList){
                  var contactItem = context.read<ContactCubit>();
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return  Dismissible(
                          key: Key(contactList[index].phone),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction){
                            contactItem.deleteContact(index);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: value.isDark? Colors.grey.shade800 :Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child:  Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    child: Text(
                                      contactList[index].name[0].toUpperCase(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 25,),
                                  Column(
                                    children: [
                                      Text(contactList[index].name,
                                        style:  const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),

                                      Text(
                                        contactList[index].phone,
                                        style:  const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: contactList.length,
                      separatorBuilder: (BuildContext context, int index) { return const SizedBox(height: 10,); },
                    ),
                  );
                }),
            floatingActionButton:  FloatingActionButton(
              onPressed: (){
                Navigator.pushNamed(context, "/AddTask");
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.add,
              ),
            ),
          );
        },
    );
  }
}
