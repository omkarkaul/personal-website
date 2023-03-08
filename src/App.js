import './App.css';
import Faq from './components/Faq/Faq'
import githubLogo from './media/github-mark.png'
import linkedinLogo from './media/LI-In-Bug.png'

function App() {
  return (
    <div className="App">
      <div className="contentContainer">

        <div className="headerContainer">
          <h1 className="title">rakmo.io</h1>
        </div>

        <div className="main">
          <Faq/>
          <div className="linkContainer">
            <p className="linkContainerTitle"><b>find me here</b></p>
            <a className="link" href="https://www.github.com/omkarkaul"><img alt={'github'} className={"githubImage"} src={githubLogo}/></a>
            <a className="link" href="https://www.linkedin.com/in/omkar-kaul/"><img alt={'linkedin'} className={"linkedinImage"} src={linkedinLogo}/></a>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
