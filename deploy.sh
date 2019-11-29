docker build -t szaszolak/multi-client:latest -t szaszolak/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t szaszolak/multi-server:latest -t szaszolak/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t szaszolak/multi-worker:latest -t szaszolak/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push szaszolak/multi-client:latest
docker push szaszolak/multi-client:$SHA
docker push szaszolak/multi-server:latest
docker push szaszolak/multi-server:$SHA
docker push szaszolak/multi-worker:latest
docker push szaszolak/multi-worker:$SHA

kubectl apply -f k8s

kubectl rolling-update client-deployment --image=szaszolak/multi-client:$SHA
kubectl rolling-update server-deployment --image=szaszolak/multi-server:$SHA
kubectl rolling-update worker-deployment --image=szaszolak/multi-worker:$SHA