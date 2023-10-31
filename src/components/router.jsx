import Header from "./header";
import Home from "../pages/home/home";
import About from "../pages/about/about";

function Router({ path, setPath }) {
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

    return (
        <>
            <Header currentPath={path} handleSetPath={handleSetPath}/>
            {renderBody(path)}
        </>
    )
}

export default Router;