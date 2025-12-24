# Download the RHEL 9 compatible RPM
curl "https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm" -o "amazon-ssm-agent.rpm"

# Install the RPM
sudo dnf install -y amazon-ssm-agent.rpm

# Enable and start the service
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent

# Verify it is running
sudo systemctl status amazon-ssm-agent