# https://github.com/vbanthia/docker-appium/tree/master/appium-ruby/onbuild/Dockerfile
FROM vbanthia/appium-ruby-onbuild

# Run following script on docker run
ENTRYPOINT ["./scripts/run_integration_test.sh"]
