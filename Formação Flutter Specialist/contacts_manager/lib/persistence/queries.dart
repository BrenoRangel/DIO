const String contactModel = '''
  type Contact {
    name: String
    phone: String
    email: String
  }
''';

const createContactMutation = '''
  mutation CreateContact(\$input: CreateContactInput!) {
    createContact(input: \$input) {
      contact {
        name
        phone
        email
      }
    }
  }
''';

const updateContactMutation = '''
mutation updateContact(\$input: UpdateContactInput!) {
  updateContact(input: \$input) {
    contact {
      name
      phone
      email
    }
  }
}

''';

const deleteContactMutation = '''
mutation DeleteContact(\$input: DeleteContactInput!) {
  deleteContact(input: \$input) {
    contact {
      id
    }
  }
}
''';

const getContactsQuery = '''
  query GetContact(\$where: ContactWhereInput) {
    contacts(where: \$where) {
      edges {
        node {
          id
          objectId
          name
          phone
          email
        }
      }
    }
  }
''';
