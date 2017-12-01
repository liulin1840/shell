#!/bin/sh

work_dir=/tmp/cert

gen_ca()
{
	[ ! -e ca ] && mkdir ca
	openssl genrsa -out ca/ca-key.pem 1024
	openssl req -new -out ca/ca-req.csr -key ca/ca-key.pem << EOF
CN
CHINA
CHENGDU
ZK
YF
root
support@zkchina.com.cn


EOF
	openssl x509 -req -in ca/ca-req.csr -out ca/ca-cert.pem -signkey ca/ca-key.pem -days 3650
}

gen_server_cert()
{
	[ ! -e server ] && mkdir server
	openssl genrsa -out server/server-key.pem 1024
	openssl req -new -out server/server-req.csr -key server/server-key.pem << EOF
CN
CHINA
CHENGDU
ZK
YF
root
support@zkchina.com.cn


EOF
	openssl x509 -req -in server/server-req.csr -out server/server-cert.pem -signkey server/server-key.pem -CA ca/ca-cert.pem -CAkey ca/ca-key.pem -CAcreateserial -days 3650
}

gen_client_cert()
{
	[ ! -e client ] && mkdir client
	openssl genrsa -out client/client-key.pem 1024
	openssl req -new -out client/client-req.csr -key client/client-key.pem << EOF
CN
CHINA
CHENGDU
ZK
YF
root
support@zkchina.com.cn


EOF
	openssl x509 -req -in client/client-req.csr -out client/client-cert.pem -signkey client/client-key.pem -CA ca/ca-cert.pem -CAkey ca/ca-key.pem -CAcreateserial -days 3650
}

gen_cert()
{
	gen_ca
	gen_server_cert
	gen_client_cert
}

[ ! -e $work_dir ] && mkdir $work_dir
cd $work_dir
gen_cert > /dev/null 2>&1
