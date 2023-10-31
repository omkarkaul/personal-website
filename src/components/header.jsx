import Icon from "./icon";
import {CONSTANTS} from "../constants";

function Header({currentPath, handleSetPath}) {
    return (
        <div className="header">
            <h1 className="title">omkar</h1>
            <div className="description">
                <h3 className="subtitle">programmer</h3>
                <nav className="social">
                    <ul className="flat">
                        <Icon
                            href="https://github.com/omkarkaul"
                            title="Github"
                            svgPath={CONSTANTS.GITHUB_ICON_SVG_PATH}
                        />
                        <Icon
                            href="https://twitter.com/nzomkar"
                            title="Twitter"
                            svgPath={CONSTANTS.TWITTER_ICON_SVG_PATH}
                        />
                    </ul>
                </nav>
            </div>
            <nav className="nav">
                <ul className="flat">
                    <li>
                        <a href="/" onClick={(event) => handleSetPath(event, "/")}>
                            {currentPath === "/" ? <b>home</b> : "home"}
                        </a>
                    </li>
                    <li>
                        <a href="/about" onClick={(event) => handleSetPath(event, "/about")}>
                            {currentPath === "/about" ? <b>about me</b> : "about me"}
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
    )
}

export default Header;