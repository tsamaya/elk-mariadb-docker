const { client, index, type } = require('./connection');

module.exports = {
  /** Query ES index for the provided term */
  queryTerm(term, offset = 0) {
    const body = {
      from: offset,
      query: {
        multi_match: {
          query: term,
          fields: ['name^10', 'address', 'city', 'type'],
        },
      },
      highlight: { fields: { name: {} } },
    };

    return client.search({ index, type, body });
  },
};