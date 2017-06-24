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
 
 ---
## Tomcat
- 웹서버 + 웹컨테이너 
- http 웹 서버를 통해 받고 내부 프로그램은 WAS를 통해 처리. (정적인 데이터와 동적인 데이터를 효과적으로 처리가 가능)
>WAS(Web Application Server) : 다양한 기능을 컨테이너에 구현하여 다양한 역할을 수행할 수 있는 서버
> 웹 컨테이너 : 클라이언트의 요청이 있을 때 내부의 프로그램을 통해 결과를 만들어내고 이것을 다시 클라이언트에 전달해주는 역할

![enter image description here](http://cfile24.uf.tistory.com/image/156A50404F93CDE817331E)

> 사용자 -> Tomcat -> 데이터베이스(값) -> Tomcat (웹에서 데이터들을 받아 가공하여 뿌려줌(Json,xml등을 위젯에 뿌려줌)) -> 사용자 (데코가되어 보여짐)

> apache랑 차이점은?
> - http웹서버, 클라이언트가 GET, POST, DELETE 등등의 메소드를 이용해 요청을 하면 이 프로그램이 어떤 결과를 돌려주는 기능
> - Tomcat이랑 큰 차이점은 웹 컨테이너의 차이!

> 그러면 왜 apache를 사용할까?
> - 우선 목적이 다름 , 웹 서버는 정적인 데이터ㄹ 처리하는 방식임. 이미지나 단순 html파일과 같은 리소스를 제공하는 파일은 웹 서버를 이용하는것이 속도가 더 빠르기 때문임. WAS는 동적인 데이터를 처리하므로 데이터베이스와 연결되어 데이터를 주거나 받는 프로그램임 때문에 데이터를 주고 받을때 활용을 해야 함!

~~~
1. 톰캣 다운로드
	http://tomcat.apache.org/download-80.cgi 페이지에서 파일 다운
2. 파일 이동
터미널에 들어간 이후 아래와 같이 입력하여 배포 경로에 파일을 이동 시켜준다.
	sudo mkdir -p /usr/local
	sudo mv ~/Downloads/apache-tomcat-8.0.8 /usr/local
3. 다음 최신 버전을 손쉽게 배포하기 위해 아래와 같이 링크를 걸어준다.
	sudo rm -f /Library/Tomcat
	sudo ln -s /usr/local/apache-tomcat-8.0.8 /Library/Tomcat
4. 톰캣폴더의 접근권한을 부여한다.
	sudo chown -R <로그인_아이디> /Library/Tomcat
5. 쉘 실행 권한 부여
	sudo chmod +x /Library/Tomcat/bin/*.sh 
6. 톰캣 시작
	/Library/Tomcat/bin/startup.sh
7. 톰캣 종료
	/Library/Tomcat/bin/shutdown.sh  
~~~
> *사용을 안할때는 종료하기*

## Mysql

~~~
1. 아래 페이지에서 다운(mac용)
https://dev.mysql.com/downloads/file/?id=469584 
2. 설치 후 실행하고, 시스템 환경설정 mysql 에서 Server Start 하기
3. 터미널에서 cd /usr/local/mysql/bin 경로 진입
4. sudo ./mysql -p 실행 (임시 발급받은 비밀번호 꼭 복사해두기)
5. SET PASSWORD = PASSWORD('root'); 비밀번호 변경하기
6. flush privileges; 적용
7. exit; mysql 종료
~~~
> ; 을 날려줘야 명령어가 실행 됨
> create database 데이터베이스이름; DB생성
> workbench를 사용하여 손쉽게 접근 가능 (schemas 에서 접근)
> mac은 한글 설정 꼭 해주기. (UTF-8)

 
