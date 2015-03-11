#!/bin/bash

ssh -o StrictHostKeyChecking=no -i ${GIT_SSH_KEY} $@

