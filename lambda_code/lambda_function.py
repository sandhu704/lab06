import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    instance_id = event['detail']['instance-id']

    instance_details = ec2.describe_instances(InstanceIds=[instance_id])
    security_group_id = instance_details['Reservations'][0]['Instances'][0]['SecurityGroups'][0]['GroupId']

   
    try:
        ec2.revoke_security_group_ingress(
            GroupId=security_group_id,
            IpPermissions=[{
                'IpProtocol': 'tcp',
                'FromPort': 22,
                'ToPort': 22,
                'IpRanges': [{'CidrIp': '0.0.0.0/0'}]
            }]
        )
        print(f"SSH access revoked on security group {security_group_id}")
    except Exception as e:
        print(f"Failed to modify security group {security_group_id}: {str(e)}")
        return {
            'statusCode': 400,
            'body': f"Error: {str(e)}"
        }
    return {
        'statusCode': 200,
        'body': "Security group modified successfully."
    }
