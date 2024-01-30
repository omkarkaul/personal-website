import json
import boto3
import botocore.exceptions

from boto3.dynamodb.conditions import Key, Attr

def handler(event, context):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('BlogTable')

    limit = event['limit']
    offset = event['offset']

    try:
        response = table.query(
            KeyConditionExpression=Key()
        )
    except botocore.exceptions.ClientError as e:
        print(e.response['Error']['Message'])

    print("total count of element: ", len(response))

    return json.dumps(response, default=str)
