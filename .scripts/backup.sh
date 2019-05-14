#!/bin/bash

cd ~/.task
tar czf ~/backup/task-backup-$(date +'%Y%m%d%H%I%S').tar.gz *
