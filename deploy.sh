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

kubectl set image deployment/client-deployment client=szaszolak/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=szaszolak/multi-worker:$SHA
kubectl set image deployment/server-deployment server=szaszolak/multi-server:$SHA