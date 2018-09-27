import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;

import java.net.URL;

public class dadata {


    public static void main(String[] args) {


    }

    static StringBuffer Sugg(String words, int count) {
        StringBuffer jsonString = new StringBuffer();
        try {
            URL url = new URL(" https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/address");
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("charset", "utf-8");
            con.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            con.setRequestProperty("Accept", "application/json; charset=UTF-8");
            con.setRequestProperty("Authorization", "Token 35840dc3dde98f80cc79207694041f2163a01855");
            con.setDoInput(true);
            con.setDoOutput(true);
            OutputStreamWriter outwr = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
            String query = "{ \"query\": \"" + words + "\", \"count\":" + count + "}";
            outwr.write(query);
            outwr.flush();
            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));

            String line;
            while ((line = br.readLine()) != null) {
                jsonString.append(line);
            }
            br.close();
            con.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return jsonString;
    }
}