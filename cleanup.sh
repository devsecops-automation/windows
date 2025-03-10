#!/bin/bash

terraform destroy -auto-approve
rm -rf .terraform* *.pem terraform.tfstate* *.json