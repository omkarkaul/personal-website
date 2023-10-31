function Icon({href, title, svgPath}) {
    return (
        <a href={href} title={title}>
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1" strokeLinecap="round" strokeLinejoin="round" className="feather feather-github">
                <path d={svgPath}></path>
            </svg>
        </a>
    )
}

export default Icon;