const esConnection = require('./connection');

const venues = [
  {
    id: 4,
    name: 'Snaps and Rye',
    address: '93 Golborne Rd, London W10 5NL',
    latitude: 51.5218763,
    longitutde: -0.2084877,
    type: ['restaurant', 'danish'],
    city: ['London'],
  },
  {
    id: 3,
    name: 'Taqueria',
    address: '141-145 Westbourne Grove, Notting Hill, London W11 2RS',
    latitude: 51.514682,
    longitutde: -0.196577,
    type: ['restaurant', 'mexican'],
    city: ['London', 'bayswater'],
  },
  {
    id: 2,
    name: 'Golborne Deli',
    address: '100-102 Golborne Rd, London W10 5PS',
    latitude: 51.52183,
    longitutde: -0.208878,
    type: ['restaurant', 'breakfast', 'italian'],
    city: ['London'],
  },
  {
    id: 1,
    name: 'Au Petit Bouchon Chez Georges',
    address: '8 Rue du Garet, 69001 Lyon, France',
    latitude: 45.7670249,
    longitutde: 4.8367981,
    type: ['restaurant', 'lyonnais'],
    city: ['Lyon'],
  },
];

const loadVenues = async () => {
  return venues;
};

const pushVenueData = async venue => {
  let bulkOps = []; // Array to store bulk operations
  let a = 0;
  for (let i = 0; i < venue.type.length; i++) {
    for (let j = 0; j < venue.city.length; j++) {
      // Describe action
      bulkOps.push({
        index: { _index: esConnection.index, _type: esConnection.type },
      });

      // Add document
      bulkOps.push({
        venue_id: venue.id,
        name: venue.name,
        address: venue.address,
        location: {
          lat: venue.latitude,
          lng: venue.longitutde,
        },
        nuplet: a,
        type: venue.type[i],
        city: venue.city[j],
      });

      a = a + 1;
    }
  }
  // Insert remainder of bulk ops array
  await esConnection.client.bulk({ body: bulkOps });
  console.log(`Indexed venue`);
};

const insertVenues = async () => {
  try {
    await esConnection.checkConnection();
    const venues = await loadVenues();
    for (venue of venues) {
      console.log(`Pushing venue - ${venue.name}`);
      await pushVenueData(venue);
    }
  } catch (err) {
    console.error(err);
  }
};

insertVenues();
