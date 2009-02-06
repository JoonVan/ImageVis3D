#!/bin/sh

VIS="-fvisibility-inlines-hidden -fvisibility=hidden"
CF="-g -Wall -Wextra -O0 -D_DEBUG"
CXF="-D_GLIBCXX_DEBUG -D_GLIBCXX_CONCEPT_CHECK ${VIS}"
if test -n "${QT_BIN}" ; then
    qm="${QT_BIN}/qmake"
else
    qm="qmake"
fi
${qm} \
    QMAKE_CONFIG="debug" \
    QMAKE_CFLAGS="${CF}" \
    QMAKE_CXXFLAGS+="${CF} ${CXF}" \
    -recursive