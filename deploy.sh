docker build -t yakushou730/multi-client:latest -t yakushou730/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yakushou730/multi-server:latest -t yakushou730/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yakushou730/multi-worker:latest -t yakushou730/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yakushou730/multi-client:latest
docker push yakushou730/multi-server:latest
docker push yakushou730/multi-worker:latest

docker push yakushou730/multi-client:$SHA
docker push yakushou730/multi-server:$SHA
docker push yakushou730/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yakushou730/multi-server:$SHA
kubectl set image deployments/client-deployment client=yakushou730/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yakushou730/multi-server:$SHA
