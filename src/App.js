import './App.css';
import {useState} from "react";
import Router from "./components/router";

function App() {
    const [path, setPath] = useState(window.location.pathname);

    return (
        <Router path={path} setPath={setPath}/>
    );
}

export default App;
