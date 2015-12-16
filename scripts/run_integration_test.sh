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


# Run appium server
(appium &) > /dev/null 2>&1
sleep 5

export UDID=$connectUrl

# Run tests
if [ "$FEATURE_TYPE" == "" ]; then
 echo "Running all tests"
 bundle exec rake spec
else
 echo "Running $FEATURE_TYPE tests"
 bundle exec rake spec:$FEATURE_TYPE
fi


node ./scripts/stf_disconnect.js $DEVICE_SERIAL
