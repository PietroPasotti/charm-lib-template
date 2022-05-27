# how to use this template

- run `scripts/init.sh <LIB_NAME>`

This will 
 - Register a charm with name LIB_NAME
 - Initialize a library called LIB_NAME
   - Grab the LIBID
   - Populate: 
     - `metadata.yaml`
     - `tox.ini`
     - `lib_template.jinja`
     - `scripts/init.sh`
     - `scripts/inline-lib.py`
     - `scripts/publish.sh`
   - Create `<LIB_NAME>.py`

After that, you should put your lib code in `./<LIB_NAME>.py`
When you're ready to publish, you should run `scripts/publish.sh`
If you're ready to publish a new revision, you can run `scripts/bump-and-publish.sh`
