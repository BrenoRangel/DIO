import 'dart:convert';

import 'package:address_manager/models/address.dart';
import 'package:address_manager/persistence/queries.dart';
import 'package:address_manager/utils/masking.dart';
import 'package:address_manager/utils/theming.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:maps_launcher/maps_launcher.dart';

class AddressView extends HookWidget {
  final Address address;

  final titleEditingController = TextEditingController();
  final cepEditingController = TextEditingController();

  AddressView(
    this.address, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deleteAddress = useMutation(
      MutationOptions(
        document: gql(deleteAddressMutation),
        onCompleted: (addressess) {
          if (kDebugMode) print(addressess);
        },
        update: (cache, result) {},
      ),
    );
    final updateAddress = useMutation(
      MutationOptions(
        document: gql(updateAddressMutation),
        onCompleted: (addressess) {
          if (kDebugMode) print(addressess);
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
                    child: TextButton(
                      style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(seedColor),
                      ),
                      onPressed: () {
                        MapsLauncher.launchQuery(address.cep);
                      },
                      child: const Text(
                        "Go to map ➚",
                        style: TextStyle(color: seedColor),
                      ),
                    ),
                  ),
                  Center(
                    child: PopupMenuButton<int>(
                      constraints: const BoxConstraints(
                        minWidth: 0,
                        maxWidth: 500,
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          onTap: () async {
                            cepEditingController.text = address.cep;
                            titleEditingController.text = address.title;

                            await Future.delayed(Duration.zero);

                            final result = await Get.defaultDialog<Map?>(
                              title: "Edit Item",
                              content: Column(
                                children: [
                                  TextField(
                                    controller: titleEditingController,
                                    decoration: const InputDecoration(hintText: "Name"),
                                    textInputAction: TextInputAction.next,
                                    inputFormatters: [
                                      textMask
                                    ],
                                  ),
                                  TextField(
                                    controller: cepEditingController,
                                    decoration: const InputDecoration(hintText: "CEP"),
                                    textInputAction: TextInputAction.done,
                                    onSubmitted: (value) {
                                      if (value.length == 9) {
                                        onCloseDialog(context);
                                      }
                                    },
                                    inputFormatters: [
                                      cepMask
                                    ],
                                  ),
                                ],
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

                            final response = await get(Uri.parse("https://viacep.com.br/ws/${result['cep']}/json/"));

                            final body = jsonDecode(response.body);

                            if (body.toString() == "{erro: true}") {
                              Get.snackbar(
                                "⚠️ Error!",
                                "Invalid zip code",
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                              );
                              return;
                            }

                            final newAddress = Address.fromJson({
                              "title": result['title'],
                              ...body
                            });

                            updateAddress.runMutation({
                              "input": {
                                "id": address.objectId,
                                "fields": {
                                  "cep": newAddress.cep,
                                  "title": newAddress.title,
                                  "logradouro": newAddress.logradouro,
                                  "complemento": newAddress.complemento,
                                  "bairro": newAddress.bairro,
                                  "localidade": newAddress.localidade,
                                  "uf": newAddress.uf,
                                  "ibge": newAddress.ibge,
                                  "gia": newAddress.gia,
                                  "ddd": newAddress.ddd,
                                  "siafi": newAddress.siafi,
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
                            deleteAddress.runMutation({
                              "input": {
                                "id": address.objectId
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
                "${address.title.toUpperCase()} ",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0).add(const EdgeInsets.only(bottom: 8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (address.cep.isNotEmpty) Text("CEP: ${address.cep}"),
                  if (address.logradouro.isNotEmpty) Text("Logradouro: ${address.logradouro}"),
                  if (address.complemento.isNotEmpty) Text("Complemento: ${address.complemento}"),
                  if (address.bairro.isNotEmpty) Text("Bairro: ${address.bairro}"),
                  if (address.localidade.isNotEmpty) Text("Localidade: ${address.localidade}"),
                  if (address.uf.isNotEmpty) Text("UF: ${address.uf}"),
                  if (address.ddd.isNotEmpty) Text("DDD: ${address.ddd}"),
                  if (address.ibge.isNotEmpty) Text("IBGE: ${address.ibge}"),
                  if (address.gia.isNotEmpty) Text("GIA: ${address.gia}"),
                  if (address.siafi.isNotEmpty) Text("SIAFI: ${address.siafi}"),
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
      "title": titleEditingController.text,
      "cep": cepEditingController.text,
    });
  }
}
