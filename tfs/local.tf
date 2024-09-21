## EXAMPLE CONFIGURATION
## SINGLE-DC, THREE-RACK, 2-NODES PER RACK DC
## CASSANDRA VERSION CAN BE MODIFIED IN THE TPL FILE
## USES UBUNTU 18.04 BY DEFAULT

locals {
  cassandra_nodes = {
    node_1 = {
      name               = "newdc1r1n1"
      instance_type      = "t3.medium"
      private_ip         = "10.50.45.243"
      dc                 = "datacenter1"
      rack               = "rack1"
      subnet_id          = "subnet-0ff07b6cafcd1b284" //1a
      security_group_ids = ["sg-06e3640bc6f4e0c94"]
    }
    node_2 = {
      name               = "riya-DC-1-r1-n2"
      instance_type      = "t3.medium"
      private_ip         = "10.50.111.198"
      dc                 = "datacenter1"
      rack               = "rack1"
      subnet_id          = "subnet-076ba9da2f55ab9f8" 
      security_group_ids = ["sg-06e3640bc6f4e0c94"]
    }
    
}
seeds = "10.50.45.243,10.50.111.198 "
}