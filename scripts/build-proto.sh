protoc \
  --plugin=./node_modules/.bin/protoc-gen-ts_proto \
  --ts_proto_out=./src/user-grpc/tsprotos \
  --ts_proto_opt=nestJs=true,useDate=true \
  --proto_path=./src/user-grpc/protos \
  ./src/user-grpc/protos/*.proto


protoc \
  --plugin=./node_modules/.bin/protoc-gen-ts_proto \
  --ts_proto_out=./src/user-client/tsprotos \
  --ts_proto_opt=nestJs=true,useDate=true \
  --proto_path=./src/user-client/protos \
  ./src/user-client/protos/*.proto
