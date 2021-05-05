#!/bin/bash

FILES="./node_modules/react/umd/react.production.min.js \
  ./node_modules/react-dom/umd/react-dom.production.min.js \
  ./node_modules/@material-ui/core/umd/material-ui.production.min.js \
  ./packages/core/lib/jsonforms-core.js \
  ./packages/react/lib/jsonforms-react.js \
  ./packages/material/lib/jsonforms-material.js"

VERSION=`jq -rc ".version" packages/core/package.json`
MAJOR=`echo ${VERSION} | sed 's/\([0-9]*\)\.\([0-9]*\)\.\(.*\)/\1/'`
MINOR=`echo ${VERSION} | sed 's/\([0-9]*\)\.\([0-9]*\)\.\(.*\)/\2/'`
PATCH=`echo ${VERSION} | sed 's/\([0-9]*\)\.\([0-9]*\)\.\(.*\)/\3/'`

S3_BASE=s3://fusebit-io-cdn/fusebit/js/fusebit-form
S3_LOCS="${S3_BASE}/latest ${S3_BASE}/${MAJOR} ${S3_BASE}/${MAJOR}/${MINOR} ${S3_BASE}/${MAJOR}/${MINOR}/${PATCH}"

for file in ${FILES}; do
  for loc in ${S3_LOCS}; do
    aws s3 cp --acl public-read --content-type application/javascript --cache-control max-age=300 \
    ${file} \
    ${loc}/
  done
done

