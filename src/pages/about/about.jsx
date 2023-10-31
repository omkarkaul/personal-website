import {useEffect, useState} from "react";
import {retrieveObjectFromS3} from "../../utils";
import {CONSTANTS} from "../../constants";

function About() {
    const [qna, setQna] = useState([]);

    const fetchQna = () => {
        retrieveObjectFromS3(CONSTANTS.QNA_KEY, CONSTANTS.WEBSITE_BUCKET, CONSTANTS.REGION)
            .then(object => setQna(JSON.parse(object)));
    }

    useEffect(() => {
        fetchQna();
    }, []);

    const buildQnaThingToRender = () => {
        return (
            <>
                <p>{"["}</p>
                {qna.map((qnaItem, index) =>
                    <div key={index} className="qna">
                        <p>{"{"}</p>
                        <div className="qnaQuestionContainer">
                            <p className="qnaQuestion">"question": </p>
                            <p> "{qnaItem.question}</p>
                        </div>
                        <div className="qnaAnswerContainer">
                            <p className="qnaAnswer">"answer": </p>
                            <p> "{qnaItem.answer}"</p>
                        </div>
                        <p>{index === qna.length - 1 ? "}" : "},"}</p>
                    </div>
                )}
                <p>{"]"}</p>
            </>
        )
    }

    return (
        <div className="qnaContainer">
            {qna.length === 0 ?
                <p className="loading">loading...</p> :
                buildQnaThingToRender(qna)}
        </div>
    )
}

export default About;