#!/bin/bash

cd /root/ranger-admin/ && \
./setup.sh && \
ranger-admin start && \
tail -f /root/ranger-admin/ews/logs/ranger-admin-*-.log
