#!/bin/bash

ssh -v -o StrictHostKeyChecking=no -i ${GIT_SSH_KEY} $@

