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
    <script>
        // $(document).on("click", "#somebutton", function() {
        //     $.get("servlet", function(responseText) {
        //         var sugg =  JSON.parse(responseText);
        //               $("#somediv").text(sugg);
        //         // $("#somediv").text(responseText);
        //     });
        // });
        $(document).on("keypress", "#input", function () {

            var dadata = {"words": $("#input").val()};

            $.ajax
            ({
                type: "GET",//Метод передачи
                data: dadata,//Передаваемые данные в JSON - формате
                url: 'servlet', //Название сервлета
                success: function (responseText) {
                    let res = JSON.parse(responseText);
                    for (item of res.suggestions) {
                        console.log(item.value);
                    }
                }
            })
        })


    </script>
</head>
<body>
<h1>fgfgfdgdg</h1>
<button id="somebutton">press here</button>
<input type="text" id="input">


<div id="somediv"></div>

</body>
</html>
