#!/bin/sh

set -e

rm -rf tmp
mkdir tmp
go run build/build.go > tmp/_config.yml
grep -P "\tVersion" main.go | tr -d '\t'

for GOOS in windows linux darwin; do
	EXT=""
	if [ $GOOS = "windows" ]; then
		EXT=".exe"
	fi
	for GOARCH in amd64 386; do
		export GOOS=$GOOS
		export GOARCH=$GOARCH
		echo $GOOS $GOARCH $EXT
		go build -o tmp/scollector-$GOOS-$GOARCH$EXT
	done
done
