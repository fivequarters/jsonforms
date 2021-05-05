#!/bin/bash

pushd .
cd packages/core
npm run build
cd ../react
npm run build
cd ../material
npm run build
npm run bundle
cd ../react
npm run bundle
cd ../core
npm run bundle
