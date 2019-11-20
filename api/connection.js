const elasticsearch = require('elasticsearch');

// Core ES variables for this project
const index = 'venues';
const type = '';
// const type = 'venue';
const host = process.env.ES_HOST || 'localhost';
const port = process.env.ES_PORT || 9200;
const client = new elasticsearch.Client({ host: { host, port } });

/**
 * Check the ES connection status
 */
const checkConnection = async () => {
  let isConnected = false;
  while (!isConnected) {
    console.log('Connecting to ES');
    try {
      const health = await client.cluster.health({});
      console.log(health);
      isConnected = true;
    } catch (err) {
      console.log('Connection Failed, Retrying...', err);
    }
  }
};

/**
 *  Clear the index, recreate it, and add mappings
 */
const resetIndex = async () => {
  if (await client.indices.exists({ index })) {
    await client.indices.delete({ index });
  }

  await client.indices.create({ index });
  await putMapping();
};

/**
 * Add venue section schema mapping to ES
 */
async function putMapping() {
  const schema = {
    venue_id: { type: 'integer' },
    name: { type: 'keyword' },
    address: { type: 'text' },
    location: { type: 'geo_point' },
    type: { type: 'keyword' },
    city: { type: 'keyword' },
  };

  return client.indices.putMapping({
    index,
    type,
    body: { properties: schema },
  });
}

module.exports = {
  client,
  index,
  type,
  checkConnection,
  resetIndex,
};
