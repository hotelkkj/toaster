#!/bin/bash

aws s3 sync target/ s3://toast.sh/ --acl public-read
