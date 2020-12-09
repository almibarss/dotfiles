#!/usr/bin/env bash

set -euo pipefail

source ~/.dotfiles/scripts/core/log.sh

BASEDIR=$(dirname $0)

# https://mrmacintosh.com/how-to-manage-catalinas-new-application-notifications-with-a-profile/
section "> Install notification profile (MacOS 15+)"
profiles -I -F "${BASEDIR}/10.15.Notifications.mobileconfig"
