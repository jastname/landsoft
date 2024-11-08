<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<!DOCTYPE html>
<html>
<head>
    <title>파일 다운로드</title>
    <link href="/css/style.css" rel="stylesheet">
    <style>
        .container {
            width: 80%;
            margin: auto;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        th {
            background-color: #bafdff;
        }
        a.button {
            text-decoration: none;
            background-color: #4caf50;
            color: white;
            padding: 5px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        a.button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>업로드된 파일 목록</h1>
        <table>
            <thead>
                <tr>
                    <th>파일 이름</th>
                    <th>다운로드</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String uploadDir = "C:/uploads/";
                    File dir = new File(uploadDir);
                    if (dir.exists() && dir.isDirectory()) {
                        File[] files = dir.listFiles();
                        if (files != null) {
                            for (File file : files) {
                                if (file.isFile()) {
                %>
                                    <tr>
                                        <td><%= file.getName() %></td>
                                        <td><a href="download.do?fileName=<%= file.getName() %>" class="button" target="_blank">다운로드</a></td>
                                    </tr>
                <%
                                }
                            }
                        } else {
                %>
                            <tr>
                                <td colspan="2">업로드된 파일이 없습니다.</td>
                            </tr>
                <%
                        }
                    } else {
                %>
                        <tr>
                            <td colspan="2">업로드 디렉토리가 존재하지 않습니다.</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
