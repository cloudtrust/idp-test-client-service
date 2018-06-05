FROM cloudtrust-baseimage:f27

WORKDIR /opt
#Get dependencies and create user
RUN dnf install -y java java-1.8.0-openjdk-devel git maven; dnf clean all; \
    git clone git@github.com:cloudtrust/idp-test-client.git; \
    git clone git@github.com:cloudtrust/idp-test-client-service.git; \
    groupadd SOresource; \
    useradd -m -s /sbin/nologin -g SOresource SOresource

#Build idp-test-client
WORKDIR /opt/idp-test-client
RUN	mvn clean package; \
        mkdir /opt/idp-test-client-run; \
	mv target/IdPTestClient.jar /opt/idp-test-client-run/IdPTestClient.jar; \
	chown -R SOresource:SOresource /opt/idp-test-client-run

#config
WORKDIR /opt/idp-test-client-service
RUN install -v -o root -g root -m 644 -d /etc/systemd/system/idp-test-client.service.d; \
    install -v -o root -g root -m 644 deploy/common/etc/systemd/system/idp-test-client.service /etc/systemd/system/idp-test-client.service; \
    install -v -o SOresource -g SOresource -m 755 deploy/common/opt/runIdPTestClient.sh /opt/runIdPTestClient.sh
	
#Enable service
RUN systemctl enable idp-test-client.service
