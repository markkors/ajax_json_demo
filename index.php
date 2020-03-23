<?php

//include("db.php");
//var_dump(get_connection());
//var_dump(get_questions());

function show_questions_html($questions) {
    $html = null;

    foreach ($questions as $question) {
        $col1 = $question['idQuestion'];
        $col2 = $question['Type'];
        $col3 = $question['Desc'];

    $html .= <<< DATA
        <div class="datarow">
            <div class="dataitem">$col1</div>
            <div class="dataitem">$col2</div>
            <div class="dataitem">$col3</div>
        </div>
DATA;

    }
return $html;
}

?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <link href="font-awesome/css/all.css" type="text/css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>

<style>
    .datatable {
        display: table;
        width: 100%;
    }

    .datarow {
        display: table-row;
        height: 50px;
    }

    .dataitem {
        display: table-cell;
        width: 33%;
        border-bottom: 1px solid black;
        vertical-align: bottom;
    }

    .dataitem:nth-child(1) {
        width: 10%;
    }

    .dataitem:nth-child(1) i:hover
    {
        color:red;
    }

    i {
        margin-right: 5px;
    }
</style>

<script>

get_questions();

function question() {
    this.idQuestion = null;
    this.Type = null;
    this.Desc = null;
}




function get_questions() {
    let req = new XMLHttpRequest();
    req.onreadystatechange = function() {
        if(req.readyState==4 || req.readyState==200) {
            console.log(req.responseText);
            let o = JSON.parse(req.responseText);
            let qc  = document.getElementById("questioncontainer");
            delete_children(qc);
            o.forEach(function (e) {
                let q = Object.assign(new question(),e);
                let r = document.createElement("div");
                r.className="datarow";

                // voeg een trashcan toe
                let edit = document.createElement("div");
                edit.className="dataitem";
                // maak een trashcan
                let tc = document.createElement("i")
                tc.className = "fas fa-trash";
                // voeg een click event aan de trashcan toe,
                tc.addEventListener("click",function (evt) {
                    if(confirm('Dit wist de vraag, doorgaan?')) {
                        //let e = evt.currentTarget;
                        //e.setAttribute("q_id", q.idQuestion);
                        //let id = e.getAttribute("q_id");
                        let fd = new FormData();
                        fd.append("action", "delete");
                        fd.append("id", q.idQuestion);
                        $.ajax({
                            url: "db.php",
                            type: "POST",
                            data: fd,
                            processData: false,
                            enctype: 'multipart/form-data',
                            contentType: false,
                            cache: false,
                            success: function (result) {
                                console.log(result);
                                // get questions again
                                get_questions();
                            }
                        });
                    }
                });

                // maak een update element
                let ue = document.createElement("i")
                ue.className = "fas fa-edit";
                // voeg click event toe aan update element
                ue.addEventListener("click",function (evt) {
                    let desc_ele = evt.currentTarget.parentElement.parentElement.lastChild;
                    desc_ele.innerText = '';
                    let input_ele = document.createElement("input");
                    input_ele.name = q.idQuestion;
                    input_ele.setAttribute("value",q.Desc);
                    // wanneer op enter wordt gedruk ajax update naar db
                    input_ele.addEventListener("keypress", function(evt) {
                        let ele = evt.currentTarget;

                        if(evt.key==='Enter') {
                            // update nieuwe waarde met Ajax naar database
                            let url = "db.php";
                            let data = new FormData()
                                data.append("id",q.idQuestion);
                                data.append("action","update");
                                data.append("desc",ele.value);
                            let options = {
                                method: 'POST',
                                body: data,
                            };
                            // ajax with fetch (only in ES6)
                            fetch(url,options)
                                .then(function(response) {
                                        return response.text();
                                }).then(function(body) {
                                    console.log(body);
                                    // get questions again
                                    get_questions();
                                });
                        }
                    });

                    desc_ele.appendChild(input_ele);
                });



                // voeg de icons toe aan de edit container
                edit.appendChild(tc);
                edit.appendChild(ue);

                r.appendChild(edit);

                for(prop in q) {
                    let c = document.createElement("div");
                    c.className = "dataitem";
                    c.setAttribute("field",prop);
                    c.innerText = q[prop];
                    r.appendChild(c);
                }
                qc.appendChild(r);
            });

        }
    }
    req.open("POST","db.php",true);
    req.send();
}

function delete_children(parent) {
    while(parent.hasChildNodes()) {
        parent.removeChild(parent.firstChild);
    }
}


</script>

<body>


<div id="questioncontainer" class="datatable">

</div>




</body>
</html>
