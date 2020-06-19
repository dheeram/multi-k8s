docker build -t dkbond007/multi-client:latest -t dkbond007/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dkbond007/multi-server:latest -t dkbond007/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dkbond007/multi-worker:latest -t dkbond007/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dkbond007/multi-client:latest
docker push dkbond007/multi-server:latest
docker push dkbond007/multi-worker:latest

docker push dkbond007/multi-client:$SHA
docker push dkbond007/multi-server:$SHA
docker push dkbond007/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dkbond007/multi-server:$SHA
kubectl set image deployments/client-deployment client=dkbond007/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dkbond007/multi-worker:$SHA

