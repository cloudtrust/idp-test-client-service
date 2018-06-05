# idp-test-client service

This is a service (docker container) for running the [idp-test-client](https://github.com/cloudtrust/idp-test-client).

## Installing the idp-test-client service

```
# prepare the environment
git clone git@github.com:cloudtrust/idp-test-client-service.git
cd idp-test-client-service

# build the docker file
sudo docker build -t cloudtrust-idptestclient -f cloudtrust-idpTestClient.dockerfile .

#create container 1
sudo docker create --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name client-1 -p 7000:7000 cloudtrust-idptestclient

# test
sudo docker start client-1

# In a browser go to http://localhost:7005
```


