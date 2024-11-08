<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
    <title>파일 업로드</title>
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
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .file-input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        input[type="file"] {
            margin-bottom: 15px;
        }
        .cancel-icon {
            display: none;
            margin-left: 10px;
            cursor: pointer;
            color: #f44336;
            font-size: 16px;
        }
        button {
            background-color: #4caf50;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
    <script>
        function showCancelIcon() {
            const fileInput = document.getElementById('fileInput');
            const cancelIcon = document.getElementById('cancelIcon');
            if (fileInput.value) {
                cancelIcon.style.display = 'inline';
            } else {
                cancelIcon.style.display = 'none';
            }
        }

        function cancelUpload() {
            document.getElementById('fileInput').value = '';
            document.getElementById('cancelIcon').style.display = 'none';
        }
        function openDownloadPopup() {
            var popup = window.open('file_show.do', 'DownloadPopup', 'width=800,height=600,resizable=yes,scrollbars=yes');
            if (!popup) {
                alert('팝업 차단이 활성화되어 있습니다. 팝업을 허용해 주세요.');
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>파일 업로드</h1>
        <form method="POST" action="upload.do" enctype="multipart/form-data">
            <div class="file-input-wrapper">
                <input type="file" id="fileInput" name="file" onchange="showCancelIcon()" />
                <span id="cancelIcon" class="cancel-icon" onclick="cancelUpload()">&#10006;</span>
            </div>
            <button type="submit">업로드</button>

        </form>
        <button onclick="openDownloadPopup()">파일 다운로드 페이지 열기</button><br><br>
        <a href="javascript:history.back()" class="button">돌아가기</a>


    </div>
</body>
</html>
