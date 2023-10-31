import './constants'
import { S3Client, GetObjectCommand } from "@aws-sdk/client-s3";

export const retrieveObjectFromS3 = async (key, bucket, region) => {
    try {
        const client = new S3Client({
            region: region,
            credentials:{
                accessKeyId:process.env.REACT_APP_USER_ACCESS_KEY_ID,
                secretAccessKey:process.env.REACT_APP_USER_ACCESS_SECRET
            }
        });
        const command = new GetObjectCommand({
            Bucket: bucket,
            Key: key,
        });

        const doRetrieveObjectFromS3 = async (command) => {
            const response = await client.send(command);
            const str = await response.Body.transformToString();
            return str;
        }

        return doRetrieveObjectFromS3(command);
    } catch (err) {
        console.error(err);
    }
}
