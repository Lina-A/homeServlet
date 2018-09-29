import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.net.URLDecoder;
import java.util.Map;

import static java.lang.Integer.valueOf;

@WebServlet(name = "Servlet")
public class Servlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String wrongWord = URLDecoder.decode(request.getParameter("slovo"), "UTF-8");
        String words = new String(wrongWord.getBytes("ISO-8859-1"), "UTF-8");
        int count = Integer.valueOf(request.getParameter("count"));
        String sug = dadata.Sugg(words, count).toString();
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(sug);

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }


}
