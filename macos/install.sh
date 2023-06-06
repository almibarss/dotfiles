#!/usr/bin/env bash

BASEDIR=$(dirname $0)

$BASEDIR/defaults.sh
$BASEDIR/brew.sh
$BASEDIR/sdkman.sh
$BASEDIR/notifications.sh
