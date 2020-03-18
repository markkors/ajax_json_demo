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



   document.addEventListener("DOMContentLoaded", function (e) {
        get_questions();
    });

    function get_questions() {
        let fd = new FormData();
        fd.append("action","show");

        let req = new XMLHttpRequest();
        req.onreadystatechange = function () {
            if(this.readyState==4 || this.readyState ==200) {
                console.log(req.responseText);
            };
        };
        req.open("POST","db.php",true);
        req.send(fd);
    }


</script>

<body>

<div class="datatable">

</div>


</body>
</html>
