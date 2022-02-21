import './App.css';

function generateFaqBlob(question, answer) {
  return (
    <div className="faqBody">
      <p className="question"><b>Q</b>: {question}</p>
      <p className="answer"><b>A</b>: {answer}</p>
    </div>
    )
}

function App() {
  return (
    <div className="App">
      <div className="contentContainer">

        <div className="headerContainer">
          <h1 className="title">rakmo.io</h1>
          <div className="linkContainer">
            <a className="link" href="https://www.github.com/omkarkaul">Github</a>
            <a className="link" href="https://www.linkedin.com/in/omkar-kaul/">LinkedIn</a>
          </div>
        </div>

        <div className="subtitleContainer">
          <h1 className="subtitle">
            This site is under construction
          </h1>
        </div>

        <div className="main">
          {generateFaqBlob("what is this?", "THIS IS A TEST!!")}
        </div>
      </div>
    </div>
  );
}

export default App;
