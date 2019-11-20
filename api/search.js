const { client, index, type } = require('./connection');

module.exports = {
  /** Query ES index for the provided term */
  queryTerm(term, offset = 0) {
    const body = {
      from: offset,
      query: {
        multi_match: {
          query: term,
          fields: ['name^5', 'address^3', 'city', 'type^2'],
          // fuzziness: '6',
          fuzziness: 'AUTO',
        },
      },
      highlight: { fields: { name: {} } },
    };

    return client.search({ index, type, body });
  },
};
