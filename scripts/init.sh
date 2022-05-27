#!/usr/bin/env bash

export LIB_NAME=$1

charmcraft register "$LIB_NAME"  # create the 'charm' placeholder
charmcraft create_lib "$LIB_NAME"  # register the lib to that charm
touch  "./$LIB_NAME.py" # create the source file for the lib

LIBID_RAW=$(cat "./lib/charm/$LIB_NAME/v0/$LIB_NAME.py" | grep LIBID)
LIBID=${a#*LIBID = }  # extract LIBID

rm "./lib/charm/$LIB_NAME/v0/$LIB_NAME.py" # get rid of the lib file

function fill_in() {
    sed -i "s/$2/$3/g" "$1"
}

# populate templates
fill_in "\$LIBID" "$LIBID" "lib_template.jinja"
fill_in "\$LIB_NAME" "$LIB_NAME" "./scripts/publish.sh"
fill_in "\$LIB_NAME" "$LIB_NAME" "./scripts/inline-lib.sh"
fill_in "\$LIB_NAME" "$LIB_NAME" "./metadata.yaml"
fill_in "\$LIB_NAME" "$LIB_NAME" "./tox.ini"


echo "lib ready at lib/charms/$LIB_NAME/v0/$LIB_NAME! Happy coding."