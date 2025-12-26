<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
    	/* 웹 페이지 전체 */
        body {
            display: flex; /* Flexbox 레이아웃 */
            justify-content: center;  /* 수평 가운데 정렬 */
            align-items: center; /* 수직 가운데 정렬 */
            height: 100vh; /* 페이지의 화면 높이 100% */
            margin: 0; /* 기본 여백 제거 */
            background-color: #A0E687;  /* 연한 초록 배경색 */
        }
        
        /* 로그인 박스 */
        .login-box {
            background-color: #00C73C; /* 밝은 초록색 배경 */
            padding: 40px; /* 로그인 박스 내부 콘텐츠(제목, 입력 필드, 버튼)와 박스 테두리 사이에 40px의 여백 추가 */
            border-radius: 15px; /* 박스 모서리 15px */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            text-align: center; /* 모든 텍스트와 요소 가로 방향 중앙 정렬 */
            width: 300px; /* 로그인 박스의 너비를 300px로 고정 */
        }
        
        /* 로그인 박스의 '로그인' */
        .login-box h2 {
            color: white;
            margin-bottom: 20px; /* 제목과 입력 필드 사이에 간격 20px 추가 */
        }
        
        /* 로그인 박스 내부의 '아이디:', '비밀번호:' */
        .login-box label {
            color: white;
            font-size: 14px;
            display: block; /* 레이블 요소를 블록(block) 요소 */
            margin-top: 10px; /* 레이블 위쪽에 10px의 여백을 추가 */
        }
        
        
        /* 아이디, 비밀번호 입력 텍스트 */
        .login-box input[type="text"],
        .login-box input[type="password"] {
            width: 100%; /* 입력 필드의 너비를 부모 요소의 100%로 설정 */
            padding: 10px; /* 입력 필드 안쪽 여백 10px 설정 */
            border-radius: 20px; /* 모서리 둥글게 20px */
            border: none; /* 기본 테두리 제거 */
            margin-top: 5px; /* 입력 필드 위쪽에 5px의 간격을 추가 */
            box-sizing: border-box;
        }
        
        /* 로그인 버튼 디자인 */
        .login-box button {
            width: 100%;
            padding: 10px; /* 버튼 내부의 텍스트와 버튼 테두리 사이의 간격을 10px로 설정 */
            border-radius: 20px;
            border: none;
            background-color: #008000; /* 어두운 초록색 */
            color: white; /* 버튼 텍스트 흰색 */
            font-size: 16px;
            margin-top: 15px; /* 버튼 위쪽에 간격 추가 */
            cursor: pointer; /* 마우스 커서를 손 모양으로 변경 */
        }
        
        /* '회원가입' 링크 디자인 */
        .login-box a {
            display: block;
            color: white;
            font-size: 12px;
            margin-top: 10px; /* 링크 위쪽에 10px의 여백을 추가 */
            text-decoration: none; /* 링크 기본 밑줄 제거 */
        }
        
        /* '회원가입' 링크에 마우스를 올릴 시 */
        .login-box a:hover {
            text-decoration: underline; /* 밑줄 표시 */
        }
        
    </style>
</head>
<body>
    <div class="login-box">
        <h2>로그인</h2>
        <form action="loginCheck.jsp" method="post">
        	<!-- 아이디 입력 필드를 설명하는 레이블 -->
            <label for="username">아이디:</label>
            <input type="text" id="username" name="username" required> <!-- required는 비워두고 제출 불가능 -->
            
            <!-- 비밀번호 입력 필드를 설명하는 레이블 -->
            <label for="password">비밀번호:</label>
            <input type="password" id="password" name="password" required>
            <a href="register.jsp">회원가입</a>
            <button type="submit">로그인</button>
        </form>
    </div>
</body>
</html>
