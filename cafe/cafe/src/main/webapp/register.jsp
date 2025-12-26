<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
    
        /* 기본 스타일, 전체 배경과 글꼴 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0; /* 기본 여백 없음 */
            padding: 0; /* 안쪽 여백 없음*/
            
            /* 페이지의 중앙에 모든 내용을 배치 */
            display: flex;
            justify-content: center;
            align-items: center;
            
            height: 100vh; /* 브라우저 창의 전체 높이 사용 */
            background: linear-gradient(135deg, #A8FF78, #78FFBB); /* 페이지 배경색 그라데이션 */
        }

		/* 회원가입 폼 전체를 감싸는 흰색 사각형 박스 */
        .register-container {
			display: flex;
    		flex-direction: column; /* 세로 배치 */
    		align-items: center;    /* 가로 중앙 정렬 */   
        
            background-color: #ffffff; /* 박스의 배경색을 흰색으로 설정 */
            width: 400px; /* 박스의 너비를 400px 고정 */
            padding: 40px; /* 박스 내부의 콘텐츠(입력 필드와 버튼 등)와 경계선 사이의 40px 여백 */
            border-radius: 12px; /* 박스의 모서리를 둥글게 12px */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
            text-align: center; /* 박스 내부 텍스트와 폼 요소 가운데 정렬 */
        }

		/* 흰색 박스 안 '회원가입' 제목 */
        .register-container h2 {
            font-size: 32px;
            color: #1ec800; /* 녹색 */
            margin-bottom: 20px; /* 제목과 아래 입력 필드 사이 20px */
        }

		/* 회원가입 폼의 모든 입력 필드(이름, 아이디, 비밀번호, 이메일) */
        .register-form input[type="text"],
        .register-form input[type="password"],
        .register-form input[type="email"] {
            width: 90%; /* 컨테이너 폭의 90%로 설정 */
            padding: 12px; /* 입력 필드 내부의 텍스트와 필드 경계 사이에 12px 여백 설정 */
            margin: 8px 0; /* 입력 필드 위아래에 8px의 공간 */
            border-radius: 25px; /* 입력 필드의 모서리를 25px 둥글게 */
            border: 1px solid #ddd; /* 입력 필드에 얇은 테두리 추가 */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과로 약간 떠있게 */
            font-size: 16px;
            transition: all 0.3s ease; /* 입력 필드에 초점이 맞춰질 때(focus) 부드러운 효과 3초 추가 */
            box-sizing: border-box; /* 패딩, 테두리를 포함한 크기 계산 */
        }

		/* 입력 필드에 초점이 맞춰졌을 때(사용자가 클릭하거나 타이핑 시) */
        .register-form input[type="text"]:focus,
        .register-form input[type="password"]:focus,
        .register-form input[type="email"]:focus {
            outline: none; /* 기본적으로 브라우저가 제공하는 파란 초점 테두리를 제거 */
            border-color: #1ec800; /* 테두리 색 녹색으로 변경 */
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2); /* 그림자 크기를 키워 시각적 강조 */
        }

		/* 회원가입 폼의 '회원가입' 버튼 */
        .register-form button {
            width: 100%; /* 버튼이 입력 필드와 같은 너비로 표시 */
            padding: 12px; /* 버튼 내부 텍스트와 버튼 경계 사이의 12px 여백 */
            border-radius: 25px; /* 버튼 모서리를 25px 둥글게 */
            border: none; /* 기본 테두리를 제거 */
            background-color: #1ec800; /* 배경색 녹색 */
            color: #ffffff; /* 버튼 텍스트 색 흰색 */
            font-size: 18px;
            font-weight: bold;
            cursor: pointer; /* 마우스를 올렸을 때 커서 모양을 손가락으로 변경 */
            transition: background-color 0.3s ease, transform 0.3s ease; /* 버튼에 마우스를 올렸을 때 배경색과 크기 변화가 부드럽게 진행 */
            margin-top: 20px; /* 버튼과 위 입력 필드 사이의 여백을 설정 */
        }

		/* 버튼에 마우스를 올렸을 때 */
        .register-form button:hover {
            background-color: #009900; /* 배경색 더 짙은 녹색 */
            transform: scale(1.05); /* 버튼 크기를 5% 키움 */
        }

		/* 하단의 "이미 계정이 있으신가요? 로그인하기" 링크 */
        .login-link {
            display: block; /* 링크가 블록 요소처럼 한 줄 전체를 차지 */
            margin-top: 20px; /* 위 버튼과의 간격을 설정 */
            font-size: 14px;
            color: #555555; /* 텍스트 색상 회색 */
            text-decoration: none; /* 링크의 기본 밑줄을 제거 */
            transition: color 0.3s ease; /* 마우스 올려놓았을 때 색상이 부드럽게 변화 */
        }
	
		/* 링크에 마우스를 올렸을 때 */
        .login-link:hover {
            color: #1ec800; /* 녹색 */
        }
    </style>
</head>
<body>

<div class="register-container">
    <h2>회원가입</h2>
    <form action="registerProcess.jsp" method="post" class="register-form"> <!-- class는 <form>요소에 대해 css 적용 -->
    
        <input type="text" name="name" placeholder="이름" required> <!-- required는 비워두고 제출 불가능 -->
        <input type="text" name="username" placeholder="아이디" required>
        <input type="password" name="password" placeholder="비밀번호" required>
        <input type="password" name="confirm_password" placeholder="비밀번호 확인" required>
        <input type="email" name="email" placeholder="이메일" required>
        <button type="submit">회원가입</button>
    </form>
    <a href="login.jsp" class="login-link">이미 계정이 있으신가요? 로그인하기</a>
</div>

</body>
</html>
