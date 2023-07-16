import 'dart:convert';

import 'package:address_manager/models/address.dart';
import 'package:address_manager/persistence/graphql.dart';
import 'package:address_manager/persistence/queries.dart';
import 'package:address_manager/utils/masking.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final createAddress = useMutation(
      MutationOptions(
        document: gql(createAddressMutation),
        onCompleted: (address) {
          if (kDebugMode) print(address);
        },
        update: (cache, result) {},
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: const Text("Address Manager"),
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
          final cepEditingController = TextEditingController();
          final titleEditingController = TextEditingController();

          void onCloseDialog(BuildContext context) {
            Navigator.pop(context, {
              "title": titleEditingController.text,
              "cep": cepEditingController.text,
            });
          }

          final result = await Get.defaultDialog<Map?>(
            title: "Add Item",
            content: ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: 100,
                maxWidth: 256,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: titleEditingController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(hintText: "Name"),
                    inputFormatters: [
                      textMask
                    ],
                  ),
                  TextField(
                    controller: cepEditingController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(hintText: "CEP"),
                    inputFormatters: [
                      cepMask
                    ],
                    onSubmitted: (_) {
                      onCloseDialog(context);
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

          cepEditingController.dispose();

          if (result == null) return;

          final response = await get(Uri.parse("https://viacep.com.br/ws/${result['cep']}/json/"));
          final address = Address.fromJson({
            "title": result['title'],
            ...jsonDecode(response.body)
          });

          createAddress.runMutation({
            "input": {
              "fields": {
                "cep": address.cep,
                "title": address.title,
                "logradouro": address.logradouro,
                "complemento": address.complemento,
                "bairro": address.bairro,
                "localidade": address.localidade,
                "uf": address.uf,
                "ibge": address.ibge,
                "gia": address.gia,
                "ddd": address.ddd,
                "siafi": address.siafi,
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
