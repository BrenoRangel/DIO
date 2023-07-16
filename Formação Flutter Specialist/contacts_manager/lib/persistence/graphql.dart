import 'package:contacts_manager/components/contact_view.dart';
import 'package:contacts_manager/models/contact.dart';
import 'package:contacts_manager/persistence/queries.dart';
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
        document: gql(getContactsQuery),
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
          final length = result!.data!["contacts"]["edges"].length;
          return ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ContactView(Contact.fromJson(result.data!["contacts"]["edges"][index]["node"]));
            },
            itemCount: length,
          );
        }
      },
    );
  }
}
