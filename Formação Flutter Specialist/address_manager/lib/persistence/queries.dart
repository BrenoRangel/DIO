const String addressModel = '''
  type Address {
    cep: String
    title: String
    logradouro: String
    complemento: String
    bairro: String
    localidade: String
    uf: String
    ibge: String
    gia: String
    ddd: String
    siafi: String
  }
''';

const createAddressMutation = '''
  mutation CreateAddress(\$input: CreateAddressInput!) {
    createAddress(input: \$input) {
      address {
        cep
        title
        logradouro
        complemento
        bairro
        localidade
        uf
        ibge
        gia
        ddd
        siafi
      }
    }
  }
''';

const updateAddressMutation = '''
mutation updateAddress(\$input: UpdateAddressInput!) {
  updateAddress(input: \$input) {
    address {
      cep
      title
      logradouro
      complemento
      bairro
      localidade
      uf
      ibge
      gia
      ddd
      siafi
    }
  }
}

''';

const deleteAddressMutation = '''
mutation DeleteAddress(\$input: DeleteAddressInput!) {
  deleteAddress(input: \$input) {
    address {
      cep
    }
  }
}
''';

const getAddressessQuery = '''
  query GetAddresses(\$where: AddressWhereInput) {
    addresses(where: \$where) {
      edges {
        node {
          id
          objectId
          createdAt
          updatedAt
          cep
          title
          logradouro
          complemento
          bairro
          localidade
          uf
          ibge
          gia
          ddd
          siafi
        }
      }
    }
  }
''';
