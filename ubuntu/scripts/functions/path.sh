#!/usr/bin/bash

function path_list() {
  echo ${PATH} | tr ':' '\n'
}
