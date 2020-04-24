#!/bin/bash

CA_PASS=$(grep "octavia_ca_password: " /etc/kolla/passwords.yml )
CA_PASS=${CA_PASS#"octavia_ca_password: "}

export CA_PASS

mkdir client_ca server_ca

cd server_ca
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
openssl genrsa -aes256 -passout env:CA_PASS -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem

openssl req -config ../openssl.cnf -passin env:CA_PASS -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem

cd ../client_ca
mkdir certs crl csr newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
openssl genrsa -aes256 -passout env:CA_PASS -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem

openssl req -config ../openssl.cnf -passin env:CA_PASS -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem

openssl genrsa -aes256 -passout env:CA_PASS -out private/client.key.pem 2048
openssl req -config ../openssl.cnf -new -sha256 -passin env:CA_PASS -key private/client.key.pem -out csr/client.csr.pem
openssl ca -batch -config ../openssl.cnf -extensions usr_cert -days 7300 -notext -md sha256 -passin env:CA_PASS -in csr/client.csr.pem -out certs/client.cert.pem

echo last
openssl rsa -passin env:CA_PASS -in private/client.key.pem -out private/client.cert-and-key.pem
cat certs/client.cert.pem >> private/client.cert-and-key.pem

cd ..

chmod -R 700 client_ca/ server_ca/

cp server_ca/private/ca.key.pem cakey.pem
cp server_ca/certs/ca.cert.pem ca_01.pem
cp client_ca/private/client.cert-and-key.pem client.pem
