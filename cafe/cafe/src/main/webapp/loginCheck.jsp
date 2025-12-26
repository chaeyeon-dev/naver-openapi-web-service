<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.security.MessageDigest" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>
<%
    // 입력 값 가져오기
    String username = request.getParameter("username").trim(); // trim()은 앞뒤에 공백문자 제거
    String password = request.getParameter("password").trim();

    // 비밀번호 해시화 (SHA-256 사용)
    MessageDigest md = MessageDigest.getInstance("SHA-256"); 
    /* SHA-256 알고리즘을 사용하기 위한 객체를 생성
       MessageDigest는 자바에서 암호화 해시 함수를 구현한 클래스
       SHA-256은 고정 길이(256비트, 즉 64자리 16진수) 해시 값을 생성하는 암호화 해시 알고리즘 */
    byte[] hash = md.digest(password.getBytes("UTF-8")); // 입력된 비밀번호를 바이트 배열로 변환하고, SHA-256 해시를 계산
    StringBuilder hexString = new StringBuilder(); // 16진수 문자열을 저장할 객체(StringBuilder)를 생성
    for (byte b : hash) { // 해시 값(바이트 배열)을 하나씩 읽음
        hexString.append(String.format("%02x", b)); // 각 바이트(b)를 2자리 16진수 문자열로 변환한 뒤, hexString에 추가
    }
    String hashedPassword = hexString.toString(); // hashedPassword는 최종적으로 암호화된 비밀번호를 저장

    // 데이터베이스 연결 정보
    String dbURL = "jdbc:mysql://localhost:3306/testdb_b"; // 데이터베이스 이름
    String dbUser = "root"; // 데이터베이스 사용자
    String dbPassword = "1234"; // 데이터베이스 비밀번호

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        // 데이터베이스 연결
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);
        

        // 테이블 존재 여부 확인
        DatabaseMetaData dbm = conn.getMetaData();
        ResultSet tables = dbm.getTables(null, null, "users", null);
        
        Statement stmt = conn.createStatement();
        boolean exists = false;
        rs = stmt.executeQuery("SHOW TABLES LIKE 'users'");
        exists = rs.next(); // 결과가 있으면 true, 없으면 false
        
        if (!exists) {
            // users 테이블이 없으면 생성
            try {
                String createTableSQL = "CREATE TABLE users ("
                    + "id INT PRIMARY KEY AUTO_INCREMENT,"
                    + "name VARCHAR(100),"
                    + "username VARCHAR(100) UNIQUE,"
                    + "password VARCHAR(64),"
                    + "email VARCHAR(100) UNIQUE" // UNIQUE 중복 허용 안되도록 
                    + ")";
                stmt.executeUpdate(createTableSQL);  // SQL명령어 실행하는 메서드

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        tables.close();
        
        String sql = "SELECT password FROM users WHERE username = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();
        
        // 결과 확인
        if (rs.next()) {
            // 데이터베이스에서 가져온 비밀번호
            String retrievedPassword = rs.getString("password");

            // 입력된 비밀번호와 비교
            if (retrievedPassword.equals(hashedPassword)) {
                // 로그인 성공 -> 세션에 사용자 정보 저장
                session.setAttribute("username", username);

                // productList.jsp로 리다이렉트
                response.sendRedirect("productList.jsp");
            } else {
                // 비밀번호 불일치
                out.println("<script>");
                out.println("alert('비밀번호가 일치하지 않습니다.');"); // 경고 메시지 창(alert box)를 표시
                out.println("history.back();"); // 이전 페이지로 돌아가는 동작을 수행
                out.println("</script>");
            }
        } else {
            // 사용자 이름이 존재하지 않는 경우
            out.println("<script>");
            out.println("alert('존재하지 않는 아이디입니다.');");
            out.println("history.back();");
            out.println("</script>");
        }
    } catch (ClassNotFoundException e) {
        // 드라이버 로드 실패
        out.println("<script>"); // 스크립트
        out.println("alert('JDBC 드라이버 로드에 실패했습니다: " + e.getMessage() + "');");
        out.println("history.back();");
        out.println("</script>");
        e.printStackTrace();
    } catch (SQLException e) {
        // SQL 오류
        out.println("<script>");
        out.println("alert('데이터베이스 처리 중 오류가 발생했습니다: " + e.getMessage() + "');");
        out.println("history.back();");
        out.println("</script>");
        e.printStackTrace();
    } finally {
        // 리소스 해제
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
