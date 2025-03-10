#!/bin/bash
set -e

echo "⚠️  Warning: This will destroy all AWS resources and remove local Terraform files."
echo "    Resources to be removed:"
echo "    - EC2 Windows Instance"
echo "    - Security Groups"
echo "    - Key Pairs"
echo "    - Local .terraform files"
echo "    - Local .pem key files"
echo "    - Terraform state files"
echo "    - JSON files"

read -p "Are you sure you want to proceed? (y/N): " confirm

if [[ $confirm =~ ^[Yy]$ ]]; then
    if [ -d ".terraform" ]; then
        echo "🗑️  Destroying AWS resources..."
        terraform destroy -auto-approve
    else
        echo "ℹ️  No .terraform directory found, skipping resource destruction..."
    fi
    
    echo "🧹 Cleaning up local files..."
    rm -rf .terraform* *.pem terraform.tfstate* *.json
    
    echo "✅ Cleanup completed successfully!"
else
    echo "❌ Cleanup cancelled."
    exit 0
fi