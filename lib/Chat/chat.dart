import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/login_screen.dart';
import '../modulo/usersmoder.dart';
import 'Cubit/cubit.dart';
import 'Cubit/states.dart';
import 'chat_details.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChatCubit()
        ..getUsers()
        ..getUsersAll(),
      child: BlocConsumer<ChatCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SocialGetAllUserLoadingStates) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              actions: [
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text('Logout'),
                )
              ],
            ),
            body: Container(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: ChatCubit.get(context).users.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => INK(
                  ChatCubit.get(context).users[index],
                  context,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget INK(UsersModel users, context) => InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatDetailes(users),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              const SizedBox(
                width: 8,
              ),
              CircleAvatar(
                radius: 45,
                backgroundImage: NetworkImage(users.ImageProfile.toString()),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                users.name.toString(),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
}