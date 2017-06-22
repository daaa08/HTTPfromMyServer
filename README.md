## Server & Client

#### Server
- 서버는 연결요청을 수락해주는 것으로 연결 요청이 들어오면 Socket을 생성하여 통신을 함
- 요청을 받는쪽이 서버가 됨(accept()가 계속 대기중인 상태)
- accept()메소드로 클라이언트와 통신하는 전용 소켓을 따로 생성하여 통신

> 127.0.0.1 : 무조건, 어디서든 자신의 PC를 카르킴
> 8080 (port)번호 : 아무거나해도 상관은 없으나 8080을 기본으로 함
```java
//특정 port로 서버를 열어서 서버를 생성
serverSocket = new ServerSocket(port);

// 소켓 서버가 종료될때까지 무한 루프
try {
  // 서버의 메인스레드는 클라이언트와의 연결만 담당하고 실제 테스크는 서브스레드에서 처리되기때문에 동시에 많은요청을 처리할 수 있음
  while(true){
  Socket client = serverSocket.accept();   // scanner의 readLine과 같음 , 연결이 완성될때까지 여기서 멈춤 (연결 요청이 올때까지)
  processClient(client);
  }
} catch (IOException e) {
  e.printStackTrace();
}
...
}.is.close(); // 소켓은 사용 후 꼭 닫아줄 것!!
```

```java
OutputStream os = client.getOutputStream();  // 읽기
InputStream is = client.getInputStream();    // 쓰기
```
```java

//
InputStream is;
try {  
     is = client.getInputStream();
    // 연결된 소켓과 스트림을 열어서 통신 준비를 함
    BufferedReader br = new BufferedReader(new InputStreamReader(is)); // 버퍼로 데이터 처리속도를 높힌다
    String line = "";
    // 데이터가 없을때까지 한줄씩 읽어서 출력
    while((line = br.readLine()) != null){
    System.out.println(line);
}
```

#### Client
- 요청하는 하나하나의 앱들
- 데이터를 수정하거나 다루기위해 서버에 접속




> Tomcat : 서버 프로그래밍
- 톰캣 시작 : sudo /Library/Tomcat/bin/startup.sh
- 톰캣 종료 : sudo /Library/Tomcat/bin/shutdown.sh
[톰캣 참조](http://egloos.zum.com/nicolec/v/5912922)


![enter image description here](http://www.libqa.com/imageView?path=/resource/real/57/20130624/thumb/thumb_2013062423673809792197240.jpg)


## Http 통신
- 웹 기반의 통신

#### HttpURLConnection
- 자바에서 웹페이지에 접속 가능하게 해 줌
- 인증 과정이 없음

```java
 URL serverUrl = new URL(url);  // URL 주소 인식 가능
 // 주소에 해당하는 서버의 소켓을 연결
            HttpURLConnection con = (HttpURLConnection) serverUrl.openConnection();
            // outputStream으로 데이터 요청
           con.setRequestMethod("GET");  // http 통신중에 get으로 통신하겠다
 ```
#### responseCode
- 서버 응답 코드
 ```java
 // 2 응담 처리
           int responseCode = con.getResponseCode();
           if (responseCode == HttpURLConnection.HTTP_OK) {

               BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream())); // 줄단위로 데이터를 읽기위해서 버퍼사용(속도 향상도)
          String temp = "";
               while((temp = br.readLine())!= null){
                   result.append(temp+"\n");
               }

           }
 ```
