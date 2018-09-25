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


</head>
<body>
<h1>Задание 2</h1>
<button id="somebutton">press here</button>
<input type="text" id="input">


<div id="somediv"></div>
<script>
    var input = document.querySelector("#input");
    input.addEventListener("input", getData);

    function getData() {
        var word = input.value;
if (word==null||word.length<3) return;
        fetch('/servlet', {method: 'POST', body: JSON.stringify({slovo: word})})
            .then((response) =>
                response.text())
        .then((result0)=>{
            let pos = result0.indexOf("{\"suggestions",5);
            return (pos!=-1)? result0.slice(0,pos):result0;
        })
            .then((result) =>
                JSON.parse(result))
            .then((massiv) => {
                    for(let i = 0; i < massiv["suggestions"].length; i++){
            console.log(massiv["suggestions"][i]["value"]);}})}


</script>

</body>
</html>
