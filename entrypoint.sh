#!/usr/bin/env bash
export LD_LIBRARY_PATH=$(pwd)
./altv-server --config "config/server.cfg" --logfile "logs/server.log"