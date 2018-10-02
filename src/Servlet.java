import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;

@WebServlet(name = "Servlet")
public class Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServerRequest(request, response);
    }

    private void ServerRequest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        StringBuilder sb = new StringBuilder();
        BufferedReader reader = request.getReader();
        try {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line).append('\n');
            }
        } finally {
            reader.close();
        }
        String text = sb.toString();
        /*
            There are 2 problems here:
            1. Parsing with substring is ugly (but it still works for now :) )
            2. Encoding is broken, cyrillic suggestions are unavailable :(
         */
        text = text.substring(text.indexOf('=') + 1).trim();
        var suggestions = dadata.Sugg(text);
        System.err.println(text);
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(suggestions.toString());
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServerRequest(request, response);
    }


}
