#!/usr/bin/env bash
sudo apt update -y
sudo apt upgrade -y
sudo apt install openjdk-8-jdk -y

#cass
wget https://dlcdn.apache.org/cassandra/3.11.17/apache-cassandra-3.11.17-bin.tar.gz
tar -xzf apache-cassandra-3.11.17-bin.tar.gz
cd apache-cassandra-3.11.17
nohup bin/cassandra
export PATH=$PATH:$HOME/apache-cassandra-3.11.17/bin



HOSTNAME="${name}"
hostnamectl set-hostname $HOSTNAME
sudo hostnamectl set-hostname $HOSTNAME
sudo sed -i "s/^127.0.0.1.*/127.0.0.1\t$HOSTNAME/g" /etc/hosts
sudo echo "alias nodetool='nodetool -h ::FFFF:127.0.0.1'" | sudo tee -a /home/ubuntu/.bashrc

sudo sed -i "s/endpoint_snitch: SimpleSnitch/endpoint_snitch: GossipingPropertyFileSnitch/g" /etc/cassandra/cassandra.yaml
sudo sed -i "s/seeds: \"127.0.0.1\"/seeds: \"${seeds}\"/g" /etc/cassandra/cassandra.yaml
sudo sed -i "s/num_tokens: 256/num_tokens: 4/g" /etc/cassandra/cassandra.yaml
sudo sed -i "s/listen_address: localhost/listen_address: ${instance_ip}/g" /etc/cassandra/cassandra.yaml
sudo sed -i "s/rpc_address: localhost/rpc_address: ${instance_ip}/g" /etc/cassandra/cassandra.yaml
sudo sed -i "s/dc=dc1/dc=${dc}/g" /etc/cassandra/cassandra-rackdc.properties
sudo sed -i "s/rack=rack1/rack=${rack}/g" /etc/cassandra/cassandra-rackdc.properties    