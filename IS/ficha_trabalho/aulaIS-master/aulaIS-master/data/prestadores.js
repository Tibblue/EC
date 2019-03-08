module.exports = {
  prestadoresByID:{
    '1':'213832123',
    '2':'23231231'
  },
  prestadoresByNif:{
    '213832123':{
      id:1,
      name: 'CHP',
      password: 'chp',
      allIDsLocais:[11, 23],
      locaisByID:{
        11:{
          name:'CMIN',
          password:'CMIN',
        },
        23:{
          name:'CentroQ',
          password:'CentroQ'
        }
      }
    },
    '23231231':{
      id:2,
      name:'Hospital de Braga',
      password: 'hb',
      allIDsLocais:[],
      locaisByID:{}
    }
  }
};