function validateForm() {
    let name = document.getElementById("name");
    let email = document.getElementById("email");

    if (name && name.value.trim() === "") {
        alert("Please enter your name");
        return false;
    }

    if (email && email.value.trim() === "") {
        alert("Please enter your email");
        return false;
    }

    return true;
}

function confirmComplaint() {
    return confirm("Are you sure you want to submit this complaint?");
}