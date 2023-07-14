#!/bin/sh

set -e

cleanup_mailhog=0
cleanup_docker=0
cleanup_network=0
cleanup() {
  set +e

  if [ "$cleanup_mailhog" -ne 0 ]; then
    echo "Logs mailhog"
    docker logs mailhog

    echo "Stopping mailhog Docker image"
    docker stop mailhog
    docker rm -f mailhog
  fi

  if [ "$cleanup_docker" -ne 0 ]; then
    echo "Logs"
    docker logs test

    echo "Stopping Docker image"
    docker stop test
    docker rm -f test
  fi

  if [ "$cleanup_network" -ne 0 ]; then
    echo "Removing Docker network"
    docker network rm testnet
  fi
}

trap cleanup EXIT

echo "Creating Docker network"
time docker network create testnet
cleanup_network=1

echo "Preparing"
apk add --no-cache jq

echo "Running Docker image"
docker run -d --name test --network testnet -e LOG_TO_STDOUT=1 -e REMOTES=mailhog "${CI_REGISTRY_IMAGE}:${TAG}"
cleanup_docker=1

echo "Running mailhog Docker image"
docker run -d --name mailhog --network testnet -p 8025:8025 mailhog/mailhog:v1.0.1 -hostname mailhog -smtp-bind-addr :25
cleanup_mailhog=1

echo "Sleeping"
sleep 10

echo "Testing"
# We inside test container use sendmail to send an e-mail to mailhog.
/bin/echo -e "Subject: test\nTo: test@mailhog" | docker exec -i test sendmail -t
sleep 10
wget -q -O - http://docker:8025/api/v2/messages | jq -r .items[0].Raw.To[0] | grep -F test@mailhog
echo "Success"
