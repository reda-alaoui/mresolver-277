#!/bin/bash

set -ex

rm -fr ~/.m2/repository/me/redaalaoui/mresolver_277
mvn clean package
