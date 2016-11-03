#!/bin/sh

cd `dirname $0`

docker build -t sunx/mozilla-syncserver ./docker/
