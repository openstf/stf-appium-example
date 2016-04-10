var Swagger = require('swagger-client');

var SWAGGER_URL = 'http://localhost:7100/api/v1/swagger.json'
var AUTH_TOKEN  = '03f5e019a2f94a35b90c30e40829395b5a0d0f0e7fd14bc496a176b03e229540';


var client = new Swagger({
  url: SWAGGER_URL
, usePromise: true
, authorizations: {
    accessTokenAuth: new Swagger.ApiKeyAuthorization('Authorization', 'Bearer ' + AUTH_TOKEN, 'header')
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
