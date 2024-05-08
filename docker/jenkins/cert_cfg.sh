#!/bin/bash

# Configure Nexus Trusted Certification

cert_trust="/etc/pki/ca-trust/source/anchors"

cp -r -v cert/* $cert_trust
update-ca-trust
systemctl restart docker
