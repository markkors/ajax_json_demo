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
                let tc = document.createElement("i")
                tc.className = "fas fa-trash";

                tc.addEventListener("click",function (evt) {
                    if(confirm('Dit wist de vraag, doorgaan?')) {
                        let e = evt.currentTarget;
                        e.setAttribute("q_id", q.idQuestion);
                        let id = e.getAttribute("q_id");
                        let fd = new FormData();
                        fd.append("action", "delete");
                        fd.append("id", id);
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

                edit.appendChild(tc);
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
