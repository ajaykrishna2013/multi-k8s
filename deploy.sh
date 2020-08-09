docker build -t ajkris/multi-client:latest -t ajkris/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajkris/multi-server:latest -t ajkris/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajkris/multi-worker:latest -t ajkris/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ajkris/multi-client:latest
docker push ajkris/multi-server:latest
docker push ajkris/multi-worker:latest

docker push ajkris/multi-client:$SHA
docker push ajkris/multi-server:$SHA
docker push ajkris/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajkris/multi-server:$SHA
kubectl set image deployments/client-deployment client=ajkris/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ajkris/multi-worker:$SHA
