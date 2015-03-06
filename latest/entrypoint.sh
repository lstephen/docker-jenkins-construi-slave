#!/bin/bash

env > /etc/environment

exec "$@"

