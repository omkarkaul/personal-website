import {useEffect, useState} from "react";
import {retrieveObjectFromS3} from "../../utils";
import {CONSTANTS} from "../../constants";

function About() {
    const [qna, setQna] = useState("");

    const fetchQna = () => {
        retrieveObjectFromS3(CONSTANTS.QNA_KEY, CONSTANTS.WEBSITE_BUCKET, CONSTANTS.REGION)
            .then(object => setQna(object));
    }

    useEffect(() => {
        fetchQna();
    }, []);

    return (
        <div>
            <pre>{qna}</pre>
        </div>
    )
}

export default About;