docker build -t ahmadusamabeg/multi-client-k8s:latest -t ahmadusamabeg/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t ahmadusamabeg/multi-server-k8s-pgfix:latest -t ahmadusamabeg/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t ahmadusamabeg/multi-worker-k8s:latest -t ahmadusamabeg/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push ahmadusamabeg/multi-client-k8s:latest
docker push ahmadusamabeg/multi-server-k8s-pgfix:latest
docker push ahmadusamabeg/multi-worker-k8s:latest

docker push ahmadusamabeg/multi-client-k8s:$SHA
docker push ahmadusamabeg/multi-server-k8s-pgfix:$SHA
docker push ahmadusamabeg/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ahmadusamabeg/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=ahmadusamabeg/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=ahmadusamabeg/multi-worker-k8s:$SHA