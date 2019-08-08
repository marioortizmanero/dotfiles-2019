const default_image = "src/assets/tux.png";

function initialize() {
    show_message("");
    initialize_users();
    initialize_timer();
    initialize_sessions();
}

function initialize_users() {
    let template = document.querySelector("#user_template");
    let parent = template.parentElement;
    parent.removeChild(template);

    // Create the user divs using a template. Tries to use the default user image
    for (i = 0; i < lightdm.users.length; i += 1) {
        user = lightdm.users[i];
        userNode = template.cloneNode(true);

        let image = userNode.querySelectorAll(".user_image")[0];
        let name = userNode.querySelectorAll(".user_name")[0];
        name.innerHTML = user.display_name;

        if (user.image) {
            image.src = user.image;
            image.onerror = on_image_error;
        } else {
            image.src = default_image;
        }

        userNode.id = user.name;
        userNode.onclick = user_event;
        parent.appendChild(userNode);
    }
    setTimeout(show_users, 400);
}

function on_image_error(e) {
    e.currentTarget.src = default_image;
}

function initialize_sessions() {
    let template = document.querySelector("#session_template");
    let container = session_template.parentElement;
    container.removeChild(template);

    for (let i = 0; i < lightdm.sessions.length; i = i + 1) {
        let session = lightdm.sessions[i];
        let s = template.cloneNode(true);
        s.id = "session_" + session.key;

        let label = s.querySelector(".session_label");
        let radio = s.querySelector("input");

        label.innerHTML = session.name;
        radio.value = session.key;
        radio.addEventListener("click", function() {
            if(document.getElementById("password_entry").value != "") document.querySelectorAll("form.password_prompt")[0].submit();
        });
        container.appendChild(s);
    }
}


function initialize_timer() {
    update_time();
    setInterval(update_time, 1000);
}

function add_action(id, name, image, clickhandler, template, parent) {
    action_node = template.cloneNode(true);
    action_node.id = "action_" + id;
    img_node = action_node.querySelectorAll(".action_image")[0];
    label_node = action_node.querySelectorAll(".action_label")[0];
    label_node.innerHTML = name;
    img_node.src = image;
    action_node.onclick = clickhandler;
    parent.appendChild(action_node);
}

