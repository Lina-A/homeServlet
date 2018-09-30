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
    <title>Узнать Расстояние</title>
    <style>
        p:not(.geo) {
            padding: 5px;
            border-bottom: 2px solid rgb(77, 144, 254);
            margin: 0;
            width: 50%;
            min-width: 500px;
        }

        p:hover:not(.geo) {
            background-color: rgb(77, 144, 254);
            cursor: pointer;
        }

        p:active {
            background-color: lightseagreen;
        }

        input {
            width: 50%;
            min-width: 500px;
            margin: 10px;
        }
    </style>


</head>
<body>

<h1>Задание 1</h1>
<label for="g1">Первый город</label>
<input type="text" class="input" id="g1">
<div class="suggestions"></div>
<label for="g2">Второй город</label>
<input type="text" class="input" id="g2">
<div class="suggestions"></div>
<button>Показать расстояние</button>
<p class="geo">Расстояние по прямой: <span class="distance"></span> </p>


<script>

    var inputs = document.querySelectorAll(".input");
    inputs.forEach((elem) => elem.addEventListener("input", makeSuggestionsList));

    var suggestionsFields = document.querySelectorAll(".suggestions");
    suggestionsFields.forEach((elem) => elem.addEventListener("click", makeChoice));

    var button = document.querySelector("button");
    button.addEventListener("click", showDistance);

    var distance = document.querySelector(".distance");
    var la1 = 0;
    var lo1 = 0;
    var la2 = 0;
    var lo2 = 0;

    function askDadata(word, count) {
        var suggestionsArray;
        body = "slovo=" + encodeURIComponent(word) + "&count=" + count;
        if (word == null || word.length < 3) return;
        var xhr = new XMLHttpRequest();
        xhr.open("POST", '/servlet', false);
        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xhr.send(body);
        if (xhr.status != 200) {
            alert(xhr.status + ': ' + xhr.statusText);
        } else {

            suggestionsArray = JSON.parse(xhr.responseText);
        }
        return suggestionsArray;
    }

    function makeSuggestionsList() {
        let currentInput = this;
        let word = this.value;
        let count = 10;
        var la1 = 0;
        var lo1 = 0;
        var la2 = 0;
        var lo2 = 0;
        new Promise((resolve) => {
            resolve(askDadata(word, count))
        })
            .then(function (suggestionsArray) {
                let suggestionsField = currentInput.nextElementSibling;
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
        let suggestionsField = event.target.parentElement;
        let currentInput = suggestionsField.previousElementSibling;
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
                    currentInput.value = suggestionsArray["suggestions"][0]["value"];
                    la1 ? la2 = +suggestionsArray["suggestions"][0]["data"]["geo_lat"] : la1 = +suggestionsArray["suggestions"][0]["data"]["geo_lat"];
                    lo1 ? lo2 = +suggestionsArray["suggestions"][0]["data"]["geo_lon"] : lo1 = +suggestionsArray["suggestions"][0]["data"]["geo_lon"];

                }
            )

    }

    function showDistance() {
        distance.innerHTML = Math.round(getDistance(la1,lo1,la2,lo2)) + " км."
    }

    function getDistance(lat1,lon1,lat2,lon2) {
        var R = 6371; // Radius of the earth in km
        var dLat = deg2rad(lat2-lat1);  // deg2rad below
        var dLon = deg2rad(lon2-lon1);
        var a =
            Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
            Math.sin(dLon/2) * Math.sin(dLon/2)
        ;
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        var d = R * c; // Distance in km
        return d;
    }

    function deg2rad(deg) {
        return deg * (Math.PI/180)
    }





</script>

</body>
</html>
