import 'package:address_manager/components/address_view.dart';
import 'package:address_manager/models/address.dart';
import 'package:address_manager/persistence/queries.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: GraphQLCache(store: HiveStore()),
    link: httpLink,
  ),
);

final HttpLink httpLink = HttpLink(
  'https://parseapi.back4app.com/graphql',
  defaultHeaders: {
    'X-Parse-Application-Id': const String.fromEnvironment("X-Parse-Application-Id"),
    'X-Parse-Client-Key': const String.fromEnvironment("X-Parse-Client-Key"),
  },
);

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<StatefulWidget> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        pollInterval: const Duration(seconds: 1),
        document: gql(getAddressessQuery),
        variables: const {
          /*
          "where": {
            "cep": {
              "equalTo": "01001-000"
            }
          },
          */
        },
      ),
      builder: (
        QueryResult? result, {
        Refetch? refetch,
        FetchMore? fetchMore,
      }) {
        if (result?.data == null) {
          return const Center(
              child: Text(
            "Loading...",
            style: TextStyle(fontSize: 20.0),
          ));
        } else {
          final length = result!.data!["addresses"]["edges"].length;
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return AddressView(Address.fromJson(result.data!["addresses"]["edges"][index]["node"]));
            },
            itemCount: length,
          );
        }
      },
    );
  }
}
