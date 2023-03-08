import React from 'react'
import qna from '../../data/qna.json'
import './Faq.css'

function generateFaqBlob(question, answer) {
    return (
        <div className="faqItem">
            <p className="question">{question}</p>
            <p className="answer">{answer}</p>
        </div>
    )
}

function Faq() {
    return (
        <div className={"faq"}>
            {qna.map((qnaItem) => (
                generateFaqBlob(qnaItem?.question, qnaItem?.answer)
            ))
            }
        </div>
    )
}

export default Faq