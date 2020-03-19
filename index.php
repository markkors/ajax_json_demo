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
            let p = document.getElementById("questioncontainer");
            o.forEach(function (e) {
                let q = Object.assign(new question(),e);
                let r = document.createElement("div");
                r.className="datarow";
                for(let prop in q) {
                    let c = document.createElement("div");
                    c.className = "dataitem";
                    c.setAttribute("field",prop);
                    c.innerText = q[prop];
                    r.appendChild(c)
                }
                p.appendChild(r);
            });

        }
    }
    req.open("POST","db.php",true);
    req.send();
}




</script>

<body>


<div id="questioncontainer" class="datatable">

</div>




</body>
</html>
