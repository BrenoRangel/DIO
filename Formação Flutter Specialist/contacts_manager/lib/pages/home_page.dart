import 'package:contacts_manager/models/contact.dart';
import 'package:contacts_manager/persistence/graphql.dart';
import 'package:contacts_manager/persistence/queries.dart';
import 'package:contacts_manager/utils/masking.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyHomePage extends HookWidget {
  MyHomePage({super.key});

  final nameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final createContact = useMutation(
      MutationOptions(
        document: gql(createContactMutation),
        onCompleted: (contact) {
          if (kDebugMode) print(contact);
        },
        update: (cache, result) {},
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("Contacts Manager"),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Test(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          nameEditingController.clear();
          phoneEditingController.clear();
          emailEditingController.clear();
          void onCloseDialog(BuildContext context) {
            Navigator.pop(context, {
              "name": nameEditingController.text,
              "phone": phoneEditingController.text,
              "email": emailEditingController.text,
            });
          }

          final result = await Get.defaultDialog<Map<String, dynamic>?>(
            title: "Add Item",
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 168,
                maxWidth: 356,
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    TextField(
                      controller: nameEditingController,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: "Name"),
                    ),
                    TextField(
                      controller: phoneEditingController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(hintText: "Phone"),
                      inputFormatters: [
                        phoneMask
                      ],
                    ),
                    TextFormField(
                      controller: emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(hintText: "Email"),
                      validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                      onFieldSubmitted: (_) {
                        onCloseDialog(context);
                      },
                    ),
                  ],
                ),
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

          final contact = Contact.fromJson(result);

          createContact.runMutation({
            "input": {
              "fields": {
                "name": contact.name,
                "phone": contact.phone,
                "email": contact.email,
              },
            }
          });
        },
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
