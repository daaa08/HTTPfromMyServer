package com.example.da08.httpfrommyserver;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.util.Log;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        networkTest("http://192.168.10.253:8080/bbb.jsp");
    }

    public void networkTest(String url){
        new AsyncTask<String,Void,String>(){

            @Override
            protected String doInBackground(String... params) {
               String result =  getData(params[0]);
                return result;
            }

            @Override
            protected void onPostExecute(String r) {
               Log.e("result", "결과"+r);
            }
        }.execute(url);
    }

    public String getData(String url){
        StringBuilder result = new StringBuilder();
        try {
            // 1 요청 처리
            URL serverUrl = new URL(url);
            // 주소에 해당하는 서버의 소켓을 연결
            HttpURLConnection con = (HttpURLConnection) serverUrl.openConnection();
            // outputStream으로 데이터 요청
            con.setRequestMethod("GET");  // http 통신중에 get으로 통신하겠다

            // 2 응담 처리
            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {

                BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream())); // 줄단위로 데이터를 읽기위해서 버퍼사용(속도 향상도)
           String temp = "";
                while((temp = br.readLine())!= null){
                    result.append(temp+"\n");
                }

            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return result.toString();
    }
}
