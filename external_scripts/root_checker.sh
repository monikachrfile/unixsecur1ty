#!/bin/bash

if [[ $EUID -ne 0 ]]
then
  echo Error
  exit
fi
