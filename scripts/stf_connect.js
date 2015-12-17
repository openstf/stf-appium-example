var Swagger = require('swagger-client');

var SWAGGER_URL = 'http://10.33.85.12/api/v1/swagger.json'
var AUTH_TOKEN  = 'b01df63d2b42459c9c885fb5b6cfed5b152996291134438c96d938962c1ef939';


var client = new Swagger({
  url: SWAGGER_URL
, usePromise: true
, authorizations: {
    accessTokenAuth: new Swagger.ApiKeyAuthorization('Authorization', 'bearer ' + AUTH_TOKEN, 'header')
  }
})

var serial = process.argv.slice(2)[0]

client.then(function(api) {
  return api.devices.getDeviceBySerial({
    serial: serial
  , fields: 'serial,present,ready,using,owner'
  }).then(function(res) {
      // check if device can be added or not
      var device = res.obj.device
      if (!device.present || !device.ready || device.using || device.owner) {
        throw new Error('Device is not available')
      }

      return api.user.addUserDevice({
        device: {
          serial: device.serial
        , timeout: 900000
        }
      }).then(function(res) {
        if (!res.obj.success) {
          throw new Error('Could not connect to device')
        }

        return api.user.remoteConnectUserDeviceBySerial({
          serial: device.serial
        }).then(function(res) {
          console.log(res.obj.remoteConnectUrl)
        })
      })
  })
})
