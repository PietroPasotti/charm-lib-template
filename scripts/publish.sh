#!/usr/bin/env bash
export LIB_NAME="$LIB_NAME"  # $ TEMPLATE: Filled in by ./scripts/init.sh
charmcraft publish-lib charms.relation_wrapper.v0.endpoint_wrapper
