#!/bin/bash

if [ ! -z "${PUID}" -a ! -z "${PGID}" -a ! -z ${PUSERNAME} ]; then
  shell="$(which bash || which sh)"
  addgroup --gid "${PGID}" "${PUSERNAME}"
  adduser --home "/home/${PUSERNAME}" --shell "${shell}" --gid "${PGID}" --uid "${PUID}" "${PUSERNAME}"
  chown -R "${PUID}:${PGID}" "/home/${PUSERNAME}"
fi

exec "${@}"
