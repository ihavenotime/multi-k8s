docker build -t not1me/multi-client:latest -t not1me/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t not1me/multi-server:latest -t not1me/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t not1me/multi-worker:latest -t not1me/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push not1me/multi-client:latest
docker push not1me/multi-server:latest
docker push not1me/multi-worker:latest

docker push not1me/multi-client:$SHA
docker push not1me/multi-server:$SHA
docker push not1me/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=not1me/multi-server:$SHA
kubectl set image deployments/client-deployment client=not1me/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=not1me/multi-worker:$SHA