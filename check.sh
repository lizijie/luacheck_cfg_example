#!/bin/sh

LUA_CHECK_ROOT=$(cd `dirname $0`; pwd)/my_tools/luacheck
PARAMS=$*

lua -e "package.path=\"${LUA_CHECK_ROOT}/src/?.lua;${LUA_CHECK_ROOT}/src/?/init.lua;\"..package.path" \
${LUA_CHECK_ROOT}/bin/luacheck.lua ${PARAMS}