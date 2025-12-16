Prometheus query on memory

((node_memory_MemTotal_bytes{instance_name=~"frontend-dev|backend-dev|mysql-dev"} 
 - node_memory_MemAvailable_bytes{instance_name=~"frontend-dev|backend-dev|mysql-dev"}) 
 / node_memory_MemTotal_bytes{instance_name=~"frontend-dev|backend-dev|mysql-dev"}) * 100
