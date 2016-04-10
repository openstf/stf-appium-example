#!/bin/bash
set -e

if [ "$DEVICE_SERIAL" == "" ]; then
  echo "Please provide $DEVICE_SERIAL"
  exit
fi

connectUrl=$(node ./scripts/stf_connect.js $DEVICE_SERIAL)

if [ "$connectUrl" == "" ]; then
  echo "Cannot connect to device"
  exit
else
  adb connect $connectUrl
fi

function disconnetDevice {
  if [ "$DEVICE_SERIAL" != "" ]; then
    echo "Releasing device"
    node ./scripts/stf_disconnect.js $DEVICE_SERIAL
  fi
}

# Always disconnect devic before exit
trap disconnetDevice EXIT

# Run appium server
(./node_modules/.bin/appium &) > /dev/null 2>&1
sleep 15

export UDID=$connectUrl

# Run tests
if [ "$FEATURE_TYPE" == "" ]; then
 echo "Running all tests"
 bundle exec rake spec
else
 echo "Running $FEATURE_TYPE tests"
 bundle exec rake spec:$FEATURE_TYPE
fi

disconnetDevice
