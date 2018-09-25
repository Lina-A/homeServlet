<%--
  Created by IntelliJ IDEA.
  User: eveli
  Date: 22.09.2018
  Time: 20:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>

</head>
<body>
<h1>Задание 2</h1>
<button id="somebutton">press here</button>
<input type="text" id="input">


<div id="somediv"></div>
<script>
    var input = document.querySelector("#input");
    input.addEventListener("keypress", getData);
    function getData() {
        var word = input.value;

        fetch('/servlet',{method:'POST', body: JSON.stringify({slovo:word})})
            .then((response) =>
                response.text())
            // .then((body) =>
            //   body.text
            // )
            .then((text) =>
               console.log(text));





    }
        //
        //
        // function getData() {
        //     fetch('/servlet',{method:'GET'})
        //         .then((response) => response.text())
        // .then((resp) => {const serverData = JSON.parse(resp);
        //     alert(serverData.data);
        // });
        // }


</script>

</body>
</html>
