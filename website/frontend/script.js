const API_URL = "/api";


async function createProject(){

    const name =
        document.getElementById(
            "projectName"
        ).value;

    await fetch(
        `${API_URL}/projects`,
        {
            method:"POST",

            headers:{
                "Content-Type":
                "application/json"
            },

            body:JSON.stringify({
                name:name
            })
        }
    );

    loadProjects();
}


async function loadProjects(){

    const response =
        await fetch(
            `${API_URL}/projects`
        );

    const data =
        await response.json();

    const list =
        document.getElementById(
            "projectList"
        );

    list.innerHTML="";

    data.forEach(project=>{

        list.innerHTML += `
        <li>
            ${project.name}
        </li>
        `;
    });
}


loadProjects();