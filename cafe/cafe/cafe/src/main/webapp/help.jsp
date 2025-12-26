<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>도움말</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">
    <style>
    	/* 전체 배경 */
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            padding: 20px;
            line-height: 1.6;
            background: #f9f9f9;
        }
        
        /* 페이지 중앙에 위치한 흰색 박스 */
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        /* 제목 */
        h1 {
            text-align: center;
            color: #1ec800;
        }
        h2 {
            color: #009900;
            margin-top: 20px;
        }
        
        /* 문단 텍스트 */
        p {
            margin-bottom: 15px;
            color: #333;
        }
        
        /* 링크 */
        a {
            color: #009900;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        
        /* 버튼 감싸는 컨테이너 */
        .button-group {
            text-align: center; /* 중앙 정렬 */
            margin-top: 20px; /* 버튼 위쪽에 20px의 간격을 추가 */
        }
        
        .button-group button {
            background-color: #1ec800; /* 버튼 배경색 밝은 초록 */
            color: white; /* 텍스트 색상 흰색 */
            padding: 10px 20px;
            border: none; /* 버튼 기본 테두리 제거 */
            border-radius: 5px; /* 버튼 모서리 5px 둥글게 */
            font-size: 16px; /* 텍스트와 버튼 사이 위/아래 10px 왼쪽/오른쪽 20px 여백 추가 */
            cursor: pointer; /* 버튼 위에 마우스를 올리면 커서 모양이 손가락 모양으로 변경 */
        }
        .button-group button:hover {
            background-color: #009900; /* 버튼 올리면 더 진한 초록색으로 */
        }
        
    </style>
    <script>
        function goBack() {
            window.history.back(); // 이전 페이지로 이동
        }
    </script>
</head>

<body>
<div class="container">
    <h1>네이버 카페 검색 도움말</h1>
    <h2>1. 네이버 카페 검색 사용법</h2>
    <p>검색어를 입력하고 "검색" 버튼을 클릭하면 관련된 카페 글을 확인할 수 있습니다. </p>
    <p>검색 결과는 네이버 카페 API를 통해 제공됩니다.</p>
    <p>검색 결과에서 카페보기를 클릭하면 해당 카페 글로 이동합니다.</p>
    
    <h2>2. API 사용 정보</h2>
    <p>본 프로젝트는 네이버 Open API를 사용하여 카페 글 검색 결과를 제공합니다. </p>
    <p> <a href="https://developers.naver.com/main/" target="_blank">네이버 API 문서</a>에서 자세한 정보를 확인하세요.</p>
    <p>사용된 주요 API:</p>
    <ul>
        <li>엔드포인트: <code>/v1/search/cafearticle.json</code></li>
        <li>필수 헤더: <code>X-Naver-Client-Id</code>, <code>X-Naver-Client-Secret</code></li>
    </ul>
    
    <h2>3. 자주 묻는 질문 (FAQ)</h2>
    <p><strong>Q1: 검색 결과가 나오지 않아요.</strong></p>
    <p>A1: 검색어가 정확한지 확인하거나 네이버 API 사용 제한이 초과되지 않았는지 확인하세요.</p>
    
    <p><strong>Q2: 특정 카페만 검색할 수 있나요?</strong></p>
    <p>A2: 현재 기능은 네이버 전체 카페의 검색 결과를 제공합니다.</p>
    <p>특정 카페를 지정하는 기능은 네이버 API의 지원 여부에 따라 구현할 수 있습니다.</p>
    
    <h2>4. 추가 정보</h2>
	<p>더 많은 정보를 원하시면 네이버 API 문서를 참고하거나 최신 업데이트 내용을 확인해 보세요.</p>
    
    <div class="button-group">
        <!-- 뒤로가기 버튼 -->
        <button onclick="goBack()">뒤로가기</button>
    </div>
</div>
</body>
</html>
