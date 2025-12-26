<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.security.MessageDigest" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 처리</title>
</head>
<body>
<%
    // 회원가입 데이터 가져오기
    String name = request.getParameter("name").trim();
    String username = request.getParameter("username").trim(); // trim()은 앞뒤에 공백문자 제거
    String password = request.getParameter("password").trim();
    String email = request.getParameter("email").trim();

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
    String dbURL = "jdbc:mysql://localhost:3306/testdb_b?useUnicode=true&characterEncoding=UTF-8";
    String dbUser = "root";
    String dbPassword = "1234"; 

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
                stmt.executeUpdate(createTableSQL);

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        tables.close();
        // 아이디 중복 확인
        String checkUsernameSql = "SELECT COUNT(*) FROM users WHERE username = ?";
        pstmt = conn.prepareStatement(checkUsernameSql);
        pstmt.setString(1, username);
        rs = pstmt.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            // 중복된 아이디가 있는 경우
            out.println("<script>alert('중복된 아이디입니다.'); history.back();</script>");
        } 
        String checkUseremailSql = "SELECT COUNT(*) FROM users WHERE email = ?";
        pstmt = conn.prepareStatement(checkUseremailSql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (rs.next() && rs.getInt(1) > 0) {
            // 중복된 아이디가 있는 경우
            out.println("<script>alert('중복된 이메일입니다.'); history.back();</script>");
        }
        
        else {
            // 비밀번호 해시화 후 저장
            String sql = "INSERT INTO users (name ,username, password, email) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, username);
            pstmt.setString(3, hashedPassword);  // 해시화된 비밀번호 저장
            pstmt.setString(4, email);

            int result = pstmt.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='login.jsp';</script>"); // 경고 메시지 창(alert box)를 표시
            } else {
                out.println("<script>alert('회원가입 실패. 다시 시도해주세요.'); history.back();</script>"); // 이전 페이지로 돌아가는 동작을 수행
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('회원가입 중 오류가 발생했습니다.'); history.back();</script>");
    } finally {
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
