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

            const inputElement = $("#input")[0];
            var dadata = {"words": inputElement.value};
            console.log(dadata);

            $.ajax
            ({
                type: "POST",//Метод передачи
                data: dadata,//Передаваемые данные в JSON - формате
                url: 'servlet', //Название сервлета
                success: function (response) {
                    console.log(response)
                    const parsed = JSON.parse(response);
                    console.log(parsed)
                    for (item of parsed.suggestions) {
                        console.log(item.value);
                    }
                    if (parsed.suggestions.length > 0) {
                        var suggesstionsElement = $("#suggestions");
                        for (item of parsed.suggestions) {
                            suggesstionsElement.html(parsed.suggestions.map(x => x.value + "<br/>").join("\n"))
                        }
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

<div id="suggestions" style="height: 500px; display: block"></div>

</body>
</html>
