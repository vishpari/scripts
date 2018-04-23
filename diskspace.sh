#! /bin/bash
#aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output=text
#aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0],State.Name,PrivateIpAddress,PublicIpAddress]' --output text | column -t
#ssh -t ubuntu@13.127.107.52 -i /home/ubuntu/vishal/Shashank.pem df -h
#aws ec2 describe-instances --query "Reservations[*].Instances[*].{Id:InstanceId,Name:Tags[?Key=='Name'].Value | [0],IP:PublicIpAddress}" --output=text > details
key="/home/ubuntu/vishal/india.pem"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,Tags[?Key==`Name`].Value|[0],State.Name,PublicIpAddress]' --output text | column -t | grep running > details
while read -r line; do
   value1=$(echo "$line"| awk -F" "  '{print $1}')
   value2=$(echo "$line"| awk -F" "  '{print $2}')
   value4=$(echo "$line"| awk -F" "  '{print $4}')
if [[ $value2 = *"ubuntu"* ]]; then
echo "Name:"$value2   "IP:"$value4   "ID:"$value1    "platform:Ubuntu"
#ssh -n ubuntu@$value4 -i /home/ubuntu/vishal/india.pem df -h | grep /dev/xvda1
ssh -n ubuntu@$value4 -i $key df -h | grep /dev/xvda1
fi
done < details
