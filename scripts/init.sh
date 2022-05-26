#!/usr/bin/env bash
export LIB_NAME="TEMPLATE: FILL THIS IN" # TODO: TEMPLATE - set lib name
charmcraft register "$LIB_NAME"  # create the 'charm' placeholder
touch "$LIB_NAME.py" # create the source file for the lib

charmcraft create_lib "$LIB_NAME"  # register the lib to that charm
LIBID_RAW=$(cat db.py | grep LIBID)
LIBID=${a#*LIBID = }  # extract LIBID

echo "
'''TEMPLATE: fill this in'''

# The unique Charmhub library identifier, never change it
LIBID = $LIBID

# Increment this major API version when introducing breaking changes
LIBAPI = {{ version }}

# Increment this PATCH version before using `charmcraft publish-lib` or reset
# to 0 if you are raising the major API version
LIBPATCH = {{ revision }}

{{ py }}

" > "lib_template.jinja"  # populate template

echo "lib ready at lib/charms/$LIB_NAME/v0/$LIB_NAME! Happy coding."