#!/bin/bash
mkdir client_ca server_ca

cd server_ca
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial

openssl genrsa -aes256 -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem

openssl req -config ../openssl.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem

cd ../client_ca
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
openssl genrsa -aes256 -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem

openssl req -config ../openssl.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem

openssl genrsa -aes256 -out private/client.key.pem 2048
openssl req -config ../openssl.cnf -new -sha256 -key private/client.key.pem -out csr/client.csr.pem
openssl ca -config ../openssl.cnf -extensions usr_cert -days 7300 -notext -md sha256 -in csr/client.csr.pem -out certs/client.cert.pem

openssl rsa -in private/client.key.pem -out private/client.cert-and-key.pem
cat certs/client.cert.pem >> private/client.cert-and-key.pem

