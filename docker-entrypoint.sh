#!/bin/bash
export LD_LIBRARY_PATH=/usr/local/lib

uname -a
echo "========================================================================"  
echo "Begin to compile proto file to js!"

PROTO_DIR=/protos
TARGET_DIR=/out

rm -rf $TARGET_DIR/*

for f in $PROTO_DIR/*.proto
do
	protoc -I=$PROTO_DIR --js_out=import_style=commonjs:$TARGET_DIR --grpc-web_out=import_style=commonjs,mode=grpcwebtext:$TARGET_DIR $f
done

echo "Done!"
