import 'dart:ui';

import 'package:contacts_manager/models/contact.dart';
import 'package:contacts_manager/persistence/queries.dart';
import 'package:contacts_manager/utils/masking.dart';
import 'package:contacts_manager/utils/theming.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ContactView extends HookWidget {
  final Contact contact;

  final nameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

  ContactView(
    this.contact, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deleteContact = useMutation(
      MutationOptions(
        document: gql(deleteContactMutation),
        onCompleted: (contact) {
          if (kDebugMode) print(contact);
        },
        update: (cache, result) {},
      ),
    );
    final updateContact = useMutation(
      MutationOptions(
        document: gql(updateContactMutation),
        onCompleted: (contact) {
          if (kDebugMode) print(contact);
        },
        update: (cache, result) {},
      ),
    );
    return Card(
      color: seedColor,
      child: Card(
        margin: const EdgeInsets.all(2),
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              trailing: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Center(
                    child: PopupMenuButton<int>(
                      constraints: const BoxConstraints(
                        maxHeight: 168,
                        maxWidth: 356,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          onTap: () async {
                            nameEditingController.text = contact.name;
                            phoneEditingController.text = contact.phone;
                            emailEditingController.text = contact.email;

                            await Future.delayed(Duration.zero);

                            final result = await Get.defaultDialog<Map<String, dynamic>?>(
                              title: "Edit Item",
                              content: Form(
                                autovalidateMode: AutovalidateMode.always,
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: nameEditingController,
                                      decoration: const InputDecoration(hintText: "Name"),
                                      textInputAction: TextInputAction.next,
                                    ),
                                    TextField(
                                      controller: phoneEditingController,
                                      decoration: const InputDecoration(hintText: "Phone"),
                                      textInputAction: TextInputAction.next,
                                      inputFormatters: [
                                        phoneMask
                                      ],
                                    ),
                                    TextFormField(
                                      controller: emailEditingController,
                                      decoration: const InputDecoration(hintText: "Email"),
                                      textInputAction: TextInputAction.done,
                                      validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                                      onFieldSubmitted: (value) {
                                        if (value.length == 9) {
                                          onCloseDialog(context);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              confirm: TextButton(
                                onPressed: () {
                                  onCloseDialog(context);
                                },
                                child: const Text("Confirm"),
                              ),
                              cancel: TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Cancel"),
                              ),
                            );

                            if (result == null) return;

                            final newContact = Contact.fromJson(result);

                            updateContact.runMutation({
                              "input": {
                                "id": contact.objectId,
                                "fields": {
                                  "name": newContact.name,
                                  "phone": newContact.phone,
                                  "email": newContact.email,
                                },
                              }
                            });

                            Get.snackbar(
                              "✓ Success!",
                              "Change saved",
                              colorText: Colors.white,
                              backgroundColor: Colors.green,
                            );
                            return;
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.edit),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          onTap: () {
                            deleteContact.runMutation({
                              "input": {
                                "id": contact.objectId
                              }
                            });
                          },
                          child: const Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              title: Text(
                " ${contact.name.toUpperCase()} ",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).add(const EdgeInsets.only(bottom: 8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    shape: const CircleBorder(),
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.hardEdge,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Image.network(
                        "https://i.pravatar.cc/300?u=${contact.objectId}",
                        height: kToolbarHeight * 2,
                      ),
                    ),
                  ),
                  if (contact.phone.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        Text(" ${contact.phone}"),
                      ],
                    ),
                  if (contact.email.isNotEmpty)
                    Row(
                      children: [
                        const Icon(Icons.email),
                        Text(" ${contact.email}"),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onCloseDialog(BuildContext context) {
    Navigator.pop(context, {
      "name": nameEditingController.text,
      "phone": phoneEditingController.text,
      "email": emailEditingController.text,
    });
  }
}
