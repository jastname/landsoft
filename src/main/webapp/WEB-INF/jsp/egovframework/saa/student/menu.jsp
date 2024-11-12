<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.sidebar {
    width: 200px;
    background-color: #f8f9fa;
    padding: 15px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    height: 100vh;
}

.sidebar a {
    display: block;
    padding: 10px;
    color: #333;
    text-decoration: none;
    font-weight: bold;
    margin-bottom: 10px;
    border-radius: 5px;
    cursor: pointer;
}

.sidebar a:hover {
    background-color: #ddd;
}

.dropdown-content {
    max-height: 0;
    overflow: hidden;
    background-color: #f1f1f1;
    transition: max-height 0.3s ease-out;
    padding-left: 15px;
}

.dropdown-content a {
    color: #333;
    padding: 8px 0;
    text-decoration: none;
    display: block;
}

.dropdown-content a:hover {
    background-color: #ddd;
}
</style>
</head>
<body>
<script type="text/javascript">
function openUploadPopup() {
    window.open(
        'upload_show.do',
        '파일 업로드',
        'width=600,height=400,scrollbars=yes,resizable=yes'
    );
}

document.addEventListener("DOMContentLoaded", function() {
    const dropdowns = document.querySelectorAll(".dropdown");

    dropdowns.forEach(dropdown => {
        const toggle = dropdown.querySelector("a");
        const content = dropdown.querySelector(".dropdown-content");

        toggle.addEventListener("click", function(event) {
            event.preventDefault(); // 기본 링크 동작 방지
            // 슬라이드 토글 효과
            if (content.style.maxHeight) {
                content.style.maxHeight = null;
            } else {
                content.style.maxHeight = content.scrollHeight + "px";
            }
        });
    });
});
</script>
<div class="sidebar">
    <h3>메뉴</h3>

    <div class="dropdown">
        <a href="#">학생 목록</a>
        <div class="dropdown-content">
            <a href="student_list.do">전체 목록</a>
            <a href="student_list_by_grade.do">학년별 목록</a>
        </div>
    </div>

    <div class="dropdown">
        <a href="#">학생 등록</a>
        <div class="dropdown-content">
            <a href="student_input.do">등록 양식</a>
            <a href="student_input_bulk.do">대량 등록</a>
        </div>
    </div>

    <div class="dropdown">
        <a href="#">학생 성적 순위</a>
        <div class="dropdown-content">
            <a href="student_list_rank.do">전체 순위</a>
            <a href="student_list_rank_by_class.do">반별 순위</a>
        </div>
    </div>

    <div class="dropdown">
        <a href="javascript:openUploadPopup()">파일 업로드</a>
        <div class="dropdown-content">
            <a href="upload.do">단일 파일 업로드</a>
            <a href="upload_multiple.do">다중 파일 업로드</a>
        </div>
    </div>
</div>
</body>
</html>
