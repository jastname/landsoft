<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>업로드 상태</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 400px;
            text-align: center;
        }
        h1 {
            font-size: 24px;
            margin-bottom: 20px;
            color: #333;
        }
        p {
            font-size: 16px;
            color: #555;
            margin-bottom: 20px;
        }
        .button {
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            text-decoration: none;
            font-size: 16px;
            display: inline-block;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>업로드 상태</h1>
        <p>${message}</p>
        <a href="javascript:history.back()" class="button">돌아가기</a>
    </div>
</body>
</html>
