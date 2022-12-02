#!/bin/bash

openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout example.key -out example.crt -subj "/CN=<your-domain>" \
  -addext "subjectAltName=DNS:<yout-domain>"
