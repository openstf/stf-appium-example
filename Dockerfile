# https://github.com/vbanthia/docker-appium/tree/master/appium-ruby/onbuild/Dockerfile
FROM vbanthia/appium-ruby-onbuild:1.4.16

# Run following script on docker run
ENTRYPOINT ["./scripts/run_integration_test.sh"]
