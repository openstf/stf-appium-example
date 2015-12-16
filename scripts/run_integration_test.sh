#!/bin/bash
set -e

# Run appium server
(appium &) > /dev/null 2>&1
sleep 5

# Run tests
if [ "$FEATURE_TYPE" == "" ]; then
  echo "Running all tests"
  bundle exec rake spec
else
  echo "Running $FEATURE_TYPE tests"
  bundle exec rake spec:$FEATURE_TYPE
fi
