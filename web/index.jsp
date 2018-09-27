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
    <title>Узнать ФИАС</title>
    <style>
        p:not(.fias) {
            padding: 5px;
            border-bottom: 2px solid rgb(77, 144, 254);
            margin: 0;
            width: 50%;
            min-width: 500px;
        }

        p:hover:not(.fias) {
            background-color: rgb(77, 144, 254);
            cursor: pointer;
        }

        p:active {
            background-color: lightseagreen;
        }

        input {
            width: 50%;
            min-width: 500px;
        }
    </style>


</head>
<body>
<h1>Задание 2</h1>
<input type="text" id="input">
<div id="suggestions"></div>
<p class="fias">ФИАС: </p>


<script>
    var input = document.querySelector("#input");
    input.addEventListener("input", makeSuggestionsList);
    var suggestionsField = document.querySelector("#suggestions");
    suggestionsField.addEventListener("click", makeChoice);
    var fias = document.querySelector(".fias");

    function askDadata(word, count) {

        if (word == null || word.length < 3) return;
        return fetch('/servlet', {method: 'POST', body: JSON.stringify({slovo: word, count: count})})
            .then((response) =>
                response.text()
            )
            .then((result) => {
                    suggestionsArray = JSON.parse(result);
                    return suggestionsArray;
                }
            )
    }

    function makeSuggestionsList() {
        let word = input.value;
        let count = 10;
        new Promise((resolve) => {
            resolve(askDadata(word, count))
        })
            .then(function (suggestionsArray) {

                while (suggestionsField.firstElementChild) {
                    suggestionsField.removeChild(suggestionsField.firstElementChild);
                }
                for (let i = 0;
                     i < suggestionsArray["suggestions"].length;
                     i++
                ) {
                    var suggestionsItem = document.createElement("p");
                    suggestionsField.appendChild(suggestionsItem);
                    suggestionsItem.innerHTML = suggestionsArray["suggestions"][i]["value"];
                }
            })

    }

    function makeChoice(event) {
        let target = event.target;
        let word = target.innerText;
        let count = 1;
        new Promise((resolve) => {
            resolve(askDadata(word, count))
        })
            .then(function (suggestionsArray) {
                    while (suggestionsField.firstElementChild) {
                        suggestionsField.removeChild(suggestionsField.firstElementChild);
                    }
                    input.value = suggestionsArray["suggestions"][0]["value"];
                    fias.innerText = "ФИАС: " + suggestionsArray["suggestions"][0]["data"]["fias_id"]
                }
            )
       
    }

</script>

</body>
</html>
