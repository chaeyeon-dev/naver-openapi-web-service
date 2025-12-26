<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Java의 표준 라이브러리에서 제공되는 java.net 및 java.io 패키지의 클래스 -->
<%@ page import="java.net.HttpURLConnection, java.net.URL, java.io.InputStreamReader, java.io.BufferedReader" %>
<%@ page import="com.google.gson.Gson, com.google.gson.JsonObject, com.google.gson.JsonArray" %> <!-- google-gson의 라이브러리 -->
<%@ page import="java.sql.*" %> <!-- java.sql 라이브러리 -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>네이버 카페글 검색</title>
    
    <!-- Google Fonts 및 Bootstrap CSS -->
    <!-- Google Fonts에서 "Noto Sans KR" 폰트를 가져오는 링크 -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <!-- CSS 파일을 인터넷에서 제공하는 공용 서버(CDN)를 통해 웹 페이지에서 바로 가져와 사용하는 코드 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    
    <style>
        /* 기본 스타일, 전체 배경과 글꼴 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0; /* 기본 여백 없음 */
            padding: 0; /* 안쪽 여백 없음*/
            background: linear-gradient(135deg, #A8FF78, #78FFBB); /* 부드러운 그라디언트 배경 */
        }
        
        /* 웹 페이지 상단 바 */
         .header {
            background-color: #009900; /* 녹색 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* 아래쪽 그림자 효과 */
            padding: 10px 20px; /* 콘텐츠와 헤더 테두리 사이 위/아래 10px 좌/우 20px */
            display: flex; /* 플렉스박스(Flexbox) 레이아웃으로 설정 */
            justify-content: space-between; /* 헤더 내부 콘텐츠를 좌우로 최대한 떨어뜨려 배치 */
            align-items: center; /* 플렉스 컨테이너의 아이템(헤더 내부 요소)을 수직 방향 중앙 정렬 */
        }

		/* 웹 페이지 상단 부분 네이버 카페 */
        .header h1 {
            margin: 0;
            color: white;
            font-size: 24px;
        }

		/* 상단 바 위에 '로그아웃'과 '도움말' 스타일 */
        .header nav a {
            text-decoration: none; /* 링크에 있는 디폴트 밑줄 제거 */
            margin-left: 10px;  /* 링크 간의 간격 */
            padding: 8px 12px; /* 링크 내부의 텍스트와 테두리 사이에 세로 8px, 가로 12px의 간격을 추가 */
            color: white; 
            border: 1px solid white; /* 링크를 감싸는 흰색 테두리(border)를 추가하여 버튼처럼 보이게 */
            border-radius: 4px; /* 테두리 모서리 둥글게 4px */
            font-size: 14px;
            transition: all 0.3s ease; /* 링크에 적용된 모든 스타일 변화를 0.3초 동안 부드럽게 전환 */
        }

		/* 상단 바 위에 '로그아웃'과 '도움말'에 마우스를 올려놓을 시 */
        .header nav a:hover {
            background-color: white;
            color: #009900; /* 녹색 */
        }
        
        
        /* 상단 검색 영역 스타일 */
        
        /* 검색 창 바깥 부분 */
        .search-section {
            background-color: #1ec800; /* 네이버 브랜드 색 */
            color: white;
            padding: 60px 20px; /* 위/아래: 60px, 좌/우: 20px */
            text-align: center; /* 글자 중앙 정렬 */
            box-shadow: 0px 10px 15px rgba(0, 0, 0, 0.1); /* 0px(수평 위치) 10px(수직 위치) 15px(흐림 반경) */
            border-radius: 12px; /* 박스 모서리 둥글게 */
            margin: 20px auto; /* 바깥쪽 여백 (위/아래: 20px, 좌/우: 중앙 정렬) */
            max-width: 800px; /* 최대 너비 800px로 크기 고정 */
        }

		/* '네이버 카페글 검색'의 제목*/
        .search-section h1 {
            font-size: 36px;
            font-weight: bold;
            margin-bottom: 20px; /* 제목 아래 20px 여백 추가*/
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3); /* 2px(수평 위치) 2px(수직 위치) 4px(흐림 반경) */
        }

		/* 검색 입력창과 검색 버튼을 감싸고 있는 폼 */
        .search-section .search-form {
            display: flex; /* Flexbox 레이아웃 */
            justify-content: center; /* 내부 요소(입력창과 버튼)를 가로 방향 중앙 정렬 */
            align-items: center; /* 입력창과 버튼이 세로로 같은 높이 */
            margin-top: 20px; /* 폼 전체 위쪽에 20px 여백 추가 */
        }

		/* 검색창(input 요소) 스타일 지정 - 기본 상태*/
        .search-section input[type="text"] {
            width: 70%; /* 검색 창 너비 70% 조정 */
            padding: 15px; /* 입력창 안의 텍스트와 테두리 사이의 간격 */
            border-radius: 50px; /* 입력창 타원형 */
            border: none; /* 기본 테두리 제거 */
            font-size: 16px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease; /* 모든 변화에 부드러운 전환 효과 0.3초 추가 */
            margin-right: 10px; /* 입력창 오른쪽에 10px의 여백을 추가 */
        }

		/* 검색창(input 요소) 스타일 지정 - 포커스(클릭하거나 입력 중 상태) */
        .search-section input[type="text"]:focus {
            outline: none; /* 아웃라인(윤곽선)을 제거 */
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.2);
        }
		
		/* '검색'버튼 */
        .search-section button {
            padding: 15px 30px; /* 세로 여백: 15px, 가로 여백: 30px. */
            border-radius: 50px; /* 버튼 모서리 50px*/
            border: none; /* 버튼 기본 테두리 제거 */
            background-color: #009900;
            color: white; /* 텍스트 색상 */
            font-size: 16px;
            font-weight: bold;
            cursor: pointer; /* 마우스를 버튼 위로 가져가면 포인터 커서(손 모양)로 변경 */
            transition: background-color 0.3s ease, transform 0.3s ease; /* 배경색과 크기 변화에 부드러운 애니메이션 효과(0.3초)를 추가 */
        }
		
		/* '검색'버튼 위에 마우스 올렸을 때 */
        .search-section button:hover {
            background-color: #007700; /* 색상 더 어둡게 */
            transform: scale(1.1); /* 버튼 크기를 1.1배 확대 */
        }

        /* 결과 영역 스타일, 전체 컨테이너 박스 */
        .container {
            display: block; 
    		padding: 20px; /* 내부 카드와 컨테이너 경계 사이 위/아래 20px */
        }

        /* 카드 스타일 */
        .card-container {
		    display: grid; /* CSS Grid로 변경 */
		    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); /* auto-fit으로 남는 공간 제거, 최소 300px로 자동 크기 조정 */
		    gap: 20px; /* 카드 간의 간격 */
		    padding: 20px; /* 내부 여백 */
		    max-width: 1200px; /* 카드 컨테이너의 최대 너비 제한 */
		    margin: 0 auto; /* 카드 컨테이너 중앙 정렬 */
		    justify-content: center; /* 카드들을 컨테이너 중앙에 정렬 */
		    place-items: center; /* Grid 안에서 카드 위치를 중앙으로 */
    		text-align: center; /* 카드들이 컨테이너 안에서 중앙 정렬 */
		}
        

		/* 검색 결과의 개별 카드 한 부분 */
        .card {
            background: linear-gradient(145deg, #fff, #f4f4f4); /* 부드러운 그라디언트 */
            border-radius: 15px; /* 카드 모서리 15px 둥글게 */
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1); /* 0px(수평 위치) 12px(수직 위치) 24px(흐림 반경) */
            overflow: hidden; /* 카드 내부 콘텐츠가 카드 경계를 벗어나지 않도록 잘라냄 */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* 카드가 크기 변화(확대) 또는 그림자 효과 변화가 있을 때 부드럽게 전환 */
            max-width: 300px; /* 카드의 최대 너비로 300p 크기 고정 */
            width: 100%; /* width: 100%는 카드가 부모 컨테이너(350px) 너비에 맞춰 조정  */
        }
		
		/* 카드에 마우스 올렸을 때 */
        .card:hover {
            transform: scale(1.05); /* 크기 확대 */
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* 그림자 강조 */
        }

		/* 카드 안쪽 여백 설정 */
        .card-body {
            padding: 20px; /* 카드 내용(제목과 설명)과 카드 테두리 사이에 20px의 간격 */
        }

		/* 카드 안에 있는 제목 */
        .card-title {
            font-size: 20px;
            font-weight: bold;
            color: #333333;
            margin-bottom: 10px; /* 제목 아래에 10px의 여백 추가 */
            text-transform: uppercase; /* 제목 텍스트를 대문자로 변환 */
            letter-spacing: 1px; /* 글자 사이 간격 1px 넓힘 */
        }

		/* 카드 안에 본문 내용 */
        .card-text {
            color: #666666;
            font-size: 14px;
            margin-bottom: 15px; /* 본문 내용 아래에 15px의 여백 추가 */
            line-height: 1.5; /* 본문 텍스트의 줄 간격을 1.5배 */
            text-overflow: ellipsis; /* 본문 텍스트가 너무 길어서 박스를 벗어나면 ...으로 잘라서 표시 */
            overflow: hidden; /* 박스 너비를 넘어가는 텍스트를 숨김 */
            white-space: nowrap; /* 본문 텍스트가 한 줄로 표시되도록 설정 */
        }

		/* 카드 하단 배경 스타일 */
        .card-footer {
            background-color: #f3f3f3; /* 밝은 회색 */
            text-align: center; /* 카드 하단 내용 가운데 정렬*/
            padding: 10px; /* 카드 하단 내부 여백 */
            border-top: 1px solid #e0e0e0; /* 연한 회색 색상 위쪽 테두리 추가 */
        }
		
		/* '자세히 보기'' 링크 스타일 */
        .card-footer a {
            color: #1ec800; /* 초록 */
            text-decoration: none; /* 기본 링크에 적용된 밑줄 제거 */
            font-weight: bold;
            transition: color 0.3s ease; /* 링크 색상이 바뀔 때 0.3초 동안 부드럽게 전환 */
        }

		/* 마우스를 올렸을 때 링크 효과 */
        .card-footer a:hover {
            color: #009900; /* 더 진한 초록색 */
        }
		
		/* 검색 결과가 없을 때 */
        .no-results {
            text-align: center; /* 가로 방향 중앙 정렬 */
            font-size: 20px;
            color: #888888; /* 색상 회색 */
            margin-top: 50px; /* 상단에 50px 여백 추가 */
            font-weight: bold;
        }

        /* 반응형 디자인 */
        
        /* 화면 너비가 768px(=100%) 이하일 때 스타일 적용 */
        @media screen and (max-width: 768px) {
        
            .search-section h1 {
                font-size: 30px; /* 기본 36px -> 30px 줄임 */
            }
		
            .search-section input[type="text"] {
                width: 80%; /* 검색 입력창의 너비를 기본값(70%)에서 80%로 늘림 */
            }

            .search-section button {
                width: 30%; /* 검색 버튼의 너비를 줄여서 작은 화면에서 입력창과 함께 적절히 배치 */
            	
            }

            .card-container {
                grid-template-columns: repeat(auto-fit, minmax(120%, 1fr)); /* 카드 너비를 컨테이너 너비의 120%로 설정 */
        		gap: 15px; /* 카드 간의 간격 */
            }
            
            .card {
		        max-width: 120%; /* 카드 너비를 화면의 120%로 설정 */
		        margin: 0 auto; /* 중앙 정렬 */
		    }
            
        }

		 /* 화면 너비가 480px(=62.5%) 이하일 때 스타일 적용 */
        @media screen and (max-width: 480px) {
            .search-section h1 {
                font-size: 24px; /* 제목 글자 크기를 30px->24px로 줄임 */
            }

            .search-section input[type="text"] {
                width: 70%; /* 검색 버튼의 너비를 부모 컨테이너의 40%로 설정 */
            }

            .search-section button {
                width: 40%; /* 검색 버튼의 너비를 부모 컨테이너의 40%로 설정 */
            }

            .card-container {
                flex-direction: column; /* 카드 그룹을 가로 정렬에서 세로 정렬로 변경 */
                gap: 15px; /* 카드들 사이에 15px의 간격 추가 */
            }
            
            .card {
        		max-width: 100%; /* 카드의 최대 너비를 화면에 맞게 설정 */
    		}
        }
    </style>
</head>
<body>

<div class="header">
        <h1>네이버 카페 검색</h1>
        
        <!-- 헤더 내에서 링크(탐색 메뉴)를 감싸는 요소. -->
        <nav>
            <a href="logout.jsp">로그아웃</a>
            <a href="help.jsp">도움말</a>
        </nav>
        
</div>
<%
	String query = request.getParameter("_query");  // 사용자가 입력한 검색어
	if(query == null){
		query = "";
}
%>

<div class="search-section">
    <h1>네이버 카페글 검색</h1>
    <form action="productList.jsp" method="get" class="search-form">
    <!-- placehoder는 입력창 안에 표시되는 힌트 텍스트, required 입력이 비어있을 시, 폼 제출 안되도록 -->
        <input type="text" name="_query" placeholder="검색어를 입력하세요" required value="<%=query %>">
        <button type="submit">검색</button>
    </form>
</div>

<div class="container">
    <%
        String clientId = "0ZOx7vHDHKmqGlbbVFHO";  // 네이버 Open API 클라이언트 ID
        String clientSecret = "hgsWZiQ_qk";  // 네이버 Open API 클라이언트 Secret
        String displayNum = "100";  // 출력할 카페글 개수
        
        if (query != null && !query.isEmpty()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL JDBC 드라이버를 로드
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_b", "root", "1234");
                // MySQL DB 연결 생성(DB 주소, DB 사용자명, DB 비밀번호) 
                Statement stmt = conn.createStatement(); // DB에서 SQL문을 실행하기 위한 객체(Statement) 생성 

                try {
                    stmt.executeUpdate("DROP TABLE IF EXISTS cafedata"); // cafedata 테이블 존재시, 테이블 삭제(기존 테이블 초기화)
                } catch (SQLException e) {
                    // 테이블이 없는 경우 무시
                }
                
                // cafedata 테이블 생성
                String createTableSQL = 
                    "CREATE TABLE cafedata (" +
                    "    id INT PRIMARY KEY," +
                    "    cftitle VARCHAR(255)," +
                    "    cflink VARCHAR(255)," +
                    "    cfdescription TEXT," +
                    "    cfcafename VARCHAR(100))";
                
                stmt.executeUpdate(createTableSQL); // SQL명령어 실행하는 메서드

                String encodedQuery = java.net.URLEncoder.encode(query, "UTF-8"); // 검색어를 URL 형식에 맞게 변환
                String apiURL = "https://openapi.naver.com/v1/search/cafearticle.json?query=" + encodedQuery + "&display=" + displayNum; 
                // 네이버 API에서 카페 글 검색 결과를 반환

                URL url = new URL(apiURL); // URL 객체 생성
                HttpURLConnection con = (HttpURLConnection) url.openConnection();
                /* 네이버 API 서버와 통신 준비중
                   openConnection()은 url 객체를 통해 네이버 API서버와 연결 생성
                   HttpURLConnection()은 HTTP 프로토콜을 사용하는 연결 객체로, GET/POST 요청을 설정 */
                con.setRequestMethod("GET"); // HTTP 요청 방식을 GET방식으로 설정
                con.setRequestProperty("X-Naver-Client-Id", clientId); // setRequestProperty("네이버 API 인증하기 위해 제공된 클라이언트 ID", 클라이언트 ID 값)
                con.setRequestProperty("X-Naver-Client-Secret", clientSecret); // setRequestProperty("네이버 API 인증하기 위해 제공된 클라이언트 Secret",클라이언트 Secret 값)

                int responseCode = con.getResponseCode(); // API 호출에 대한 HTTP 응답 코드
                BufferedReader br; // API 응답을 읽어오는 객체
                
                // 200: 성공, 다른 값: 실패 
                if (responseCode == 200) { 
                	// 성공 시 con.getInputStream()에서 데이터를 읽음
                    br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
                } else {
                	// 실패 시 con.getErrorStream()에서 에러 메시지 읽음
                    br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8")); 
                }

                StringBuilder responseBuffer = new StringBuilder(); // API 응답 데이터를 한 줄씩 읽어와 누적
                String inputLine; // API 응답에서 읽어온 한 줄의 데이터를 저장하기위한 변수
                while ((inputLine = br.readLine()) != null) {
                    responseBuffer.append(inputLine); // 데이터를 한 줄씩 단위씩 읽으면서 null이 아닐 경우 반복
                }
                br.close();

                // google에서 제공하는 json 라이브러리
                Gson gson = new Gson(); // Gson 객체 생성
                String jsonResponse = responseBuffer.toString(); 
                /* 1. httpURLConnection으로 데이터를 읽어 responseBuffer에 저장
                   2. responseBuffer.toString()으로 JSON 데이터를 문자열(String jsonRsponse)로 변환 */
                JsonObject responseObject = gson.fromJson(jsonResponse, JsonObject.class); 
                /* gson.fromJson(JSON 데이터가 담긴 문자열, 변환할 Java 객체 타입)
                   JSON 문자열을 Java 객체(JsonObject)로 변환 */
                JsonArray items = responseObject.getAsJsonArray("items");
				/* getAsJsonArray("items")를 사용해 items 키의 값을 가져오고, 이것을 JsonArray로 변환
				   JsonArray는 Gson 라이브러리가 제공하는 Json 배열 표현 클래스 */
				   
                if (items != null && items.size() > 0) {
                    out.println("<div class='card-container'>");
                    for (int i = 0; i < items.size(); i++) {
                        JsonObject item = items.get(i).getAsJsonObject(); // 배열 요소(items.get(i))를 JSON 객체(JsonObject)로 변환
                        
                        // item에서 데이터 추출
                        String title = item.get("title").getAsString().replaceAll("<[^>]*>", "").replaceAll("['\"]", "");
                        String link = item.get("link").getAsString();
                        String description = item.get("description").getAsString().replaceAll("<[^>]*>", "").replaceAll("['\"]", "");
                        String cafeName = item.get("cafename").getAsString().replaceAll("<[^>]*>", "").replaceAll("['\"]", "");
						/*  item.get("title")은 Gson 라이브러리에서 "title"이라는 키 값을 가져온거임. (link, description, cafeName도 동일)
						   .getAsString은 value 타입의 데이터를 문자열로 변환함.
						   .replaceAll은 문자열의 특정 패턴을 다른 문자열로 바꾸는 메서드. 
						   <[^>]*>는 정규식 HTML 태그를 의미하며, ['\"]는 문자열에서 ' 또는 "를 찾음.
                        */
                        
                        // 검색시 출력되는 카드들
                        out.println("<div class='card'>"); // 카드 전체를 감싸는 컨테이너
                        
                        	out.println("<div class='card-body'>"); // 카드 내용부를 감싸는 태그, 제목(tilte)과 설명(descrption) 포함
	                        out.println("<h5 class='card-title'>" + title + "</h5>"); // 카드 제목 표시
	                        out.println("<p class='card-text'>" + description + "</p>"); // 카드의 간략한 설명 표시
	                        out.println("</div>");
	                        
	                        out.println("<div class='card-footer text-center'>"); // 카드 하단에 있는 링크를 감싸는 부분
	                        out.println("<a href='" + link + "' target='_blank'>자세히 보기</a>"); // 자세히 보기 링크 열기
	                        out.println("</div>");
                        
	                    out.println("</div>");
						
	                    // INSERT를 SQL문을 실행해 DBMS에 데이터를 삽입하고, 삽입된 데이터는 이후 사용자에게 보여줄수 있도록 저장함.
                        stmt.executeUpdate("INSERT INTO cafedata (id, cftitle, cflink, cfdescription, cfcafename) VALUES ('" + (i+1) + "','" + title + "','" + link + "','" + description + "','" + cafeName + "');");
                    }
                    out.println("</div>"); // card-container의 div
                } else {
                    out.println("<div class='no-results'>검색 결과가 없습니다.</div>");
                }
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<div class='no-results'>오류 발생: " + e.getMessage() + "</div>");
            }
        }
    %>
</div> <!-- container의 div -->

<!-- JavaScript 라이브러리를 HTML 문서에 포함하는 태그 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
