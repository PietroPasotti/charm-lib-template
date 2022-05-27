#!/usr/bin/env bash
export CHARM_NAME=$1
export LIB_NAME=$2

[ -z "$LIB_NAME" ] && echo "need to provide LIB_NAME as first argument" && exit 1
[ -z "$CHARM_NAME" ] && echo "need to provide CHARM_NAME as second argument" && exit 1



function fill_in() {
    echo "$3:: replacing $1 -> $2"
    sed -i "s/$1/$2/g" "$3"
}

# populate templates
fill_in "\$LIB_NAME" "$LIB_NAME" "./scripts/publish.sh"
fill_in "\$CHARM_NAME" "$CHARM_NAME" "./scripts/publish.sh"

fill_in "\$LIB_NAME" "$LIB_NAME" "./scripts/inline-lib.py"
fill_in "\$CHARM_NAME" "$CHARM_NAME" "./scripts/inline-lib.py"

fill_in "\$LIB_NAME" "$LIB_NAME" "./metadata.yaml"
fill_in "\$CHARM_NAME" "$CHARM_NAME" "./metadata.yaml"
fill_in "\$LIB_NAME" "$LIB_NAME" "./tox.ini"

echo "registering charm $CHARM_NAME"
charmcraft register "$CHARM_NAME"  # create the 'charm' placeholder

echo "registering lib $LIB_NAME"
charmcraft create-lib "$LIB_NAME"  # register the lib to that charm
touch  "./$LIB_NAME.py" # create the source file for the lib

LIBID_RAW=$(cat "./lib/charm/$LIB_NAME/v0/$LIB_NAME.py" | grep LIBID)
LIBID=${a#*LIBID = }  # extract LIBID

fill_in "\$LIBID" "$LIBID" "lib_template.jinja"

rm "./lib/charm/$LIB_NAME/v0/$LIB_NAME.py" # get rid of the lib file

echo "lib ready at lib/charms/$LIB_NAME/v0/$LIB_NAME! Happy coding."