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
          <h3 className="mainTitle">FAQ</h3>
          {generateFaqBlob("What's your name?", "Omkar Kaul")}
          {generateFaqBlob("What did you study?", "I studied a Computer Science and Economics conjoint degree at the University of Auckland")}
          {generateFaqBlob("What do you do?", "I work as a Software Engineer at Xero")}
          {generateFaqBlob("What kind of things do you enjoy in Software Engineering?", "I really enjoy DevOps, software automation, SRE, and product enablement")}
          {generateFaqBlob("When will this website be done?", "Ticket is in the backlog")}
          {generateFaqBlob("What's the deal with the website name?", "The website name spelled backwards is what my friends usually say to get my attention")}
        </div>
      </div>
    </div>
  );
}

export default App;
