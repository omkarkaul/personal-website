import Header from "./header";
import Home from "../pages/home/home";
import About from "../pages/about/about";
import {useEffect, useState} from "react";

import '../App.css';

function Router() {
    const [path, setPath] = useState(window.location.pathname);

    function renderBody() {
        if (path === "/") {
            return <Home/>;
        } else if (path === "/about") {
            return <About/>
        } else {
            return <div>up to bro? <b>{path}</b> is not a path on this website</div>
        }
    }

    const handleSetPath = (event, path) => {
        event.preventDefault();
        window.history.pushState({}, "", path)
        setPath(path);
    }

    useEffect(() => {
        const onLocationChange = () => {
            setPath(window.location.pathname);
        }

        window.addEventListener('popstate', onLocationChange);

        return () => {
            window.removeEventListener('popstate', onLocationChange)
        };
    }, [])

    return (
        <>
            <Header currentPath={path} handleSetPath={handleSetPath}/>
            {renderBody(path)}
        </>
    )
}

export default Router;