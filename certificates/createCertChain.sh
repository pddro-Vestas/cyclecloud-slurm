#!/usr/bin/env bash

# This script downloads and prepares the root CA certificates required for Azure Database for MySQL Flexible Server.
# Reference: https://learn.microsoft.com/en-us/azure/mysql/flexible-server/concepts-root-certificate-rotation#how-to-update-the-root-certificate-store-on-your-client

# Download DigiCert Global Root CA certificate (PEM format)
wget https://cacerts.digicert.com/DigiCertGlobalRootCA.crt.pem

# Download DigiCert Global Root G2 certificate (PEM format)
wget https://cacerts.digicert.com/DigiCertGlobalRootG2.crt.pem

# Download Microsoft RSA Root Certificate Authority 2017 (DER format)
wget "https://www.microsoft.com/pkiops/certs/Microsoft%20RSA%20Root%20Certificate%20Authority%202017.crt"
# Rename the downloaded Microsoft certificate for consistency
mv "Microsoft RSA Root Certificate Authority 2017.crt" MicrosoftRSARootCertificateAuthority2017.crt
# Convert Microsoft certificate from DER to PEM format
openssl x509 -inform der -in MicrosoftRSARootCertificateAuthority2017.crt -out MicrosoftRSARootCertificateAuthority2017.crt.pem

# Concatenate all root certificates into a single PEM file for use in client applications
cat DigiCertGlobalRootCA.crt.pem > RootCARootG2Authority2017.crt.pem
cat DigiCertGlobalRootG2.crt.pem >> RootCARootG2Authority2017.crt.pem
cat MicrosoftRSARootCertificateAuthority2017.crt.pem >> RootCARootG2Authority2017.crt.pem
