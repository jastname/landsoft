<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생목록</title>
<link href="/css/style.css" rel="stylesheet">
<style>
    body {
        display: flex;
        min-height: 100vh;
        margin: 0;
    }
    .sidebar {
        width: 200px;
        background-color: #f8f9fa;
        padding: 15px;
        box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
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
    }
    .sidebar a:hover {
        background-color: #ddd;
    }
    .content {
        flex-grow: 1;
        display: flex;
        justify-content: center;
        align-items: flex-start;
        padding: 20px;
    }
    .content-inner {
        width: 100%;
        max-width: 800px; /* Limit content width */
        text-align: center;
    }
    .content-inner h3 {
        margin-bottom: 20px;
    }
    .selectbox, .dataTable, .sectionDiv {
        margin: 0 auto 20px auto; /* Center elements horizontally */
    }
    .dataTable {
        width: 100%;
        max-width: 100%; /* Ensure table doesn't exceed content width */
    }
    .sectionDiv {
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .pagination {
        text-align: center;
    }
    .bt {
        margin-left: auto; /* Pushes the buttons to the far right */
    }
    .bt a {
        margin: 0 5px;
        text-decoration: none;
    }
</style>
<script type="text/javascript">
    function fn_egov_link_page(pageNo) {
        var form = document.createElement("form");
        form.setAttribute("method", "GET");
        form.setAttribute("action", "student_list.do");
        var inputPage = document.createElement("input");
        inputPage.setAttribute("type", "hidden");
        inputPage.setAttribute("name", "page");
        inputPage.setAttribute("value", pageNo);
        form.appendChild(inputPage);
        var schFld = document.querySelector("select[name='schFld']").value;
        var schStr = document.querySelector("input[name='schStr']").value;
        if (schFld) {
            var inputSchFld = document.createElement("input");
            inputSchFld.setAttribute("type", "hidden");
            inputSchFld.setAttribute("name", "schFld");
            inputSchFld.setAttribute("value", schFld);
            form.appendChild(inputSchFld);
        }
        if (schStr) {
            var inputSchStr = document.createElement("input");
            inputSchStr.setAttribute("type", "hidden");
            inputSchStr.setAttribute("name", "schStr");
            inputSchStr.setAttribute("value", schStr);
            form.appendChild(inputSchStr);
        }
        document.body.appendChild(form);
        form.submit();
    }
    function openUploadPopup() {
        window.open(
            'upload_show.do',
            '파일 업로드',
            'width=600,height=400,scrollbars=yes,resizable=yes'
        );
    }
</script>
</head>
<body>
    <div class="sidebar">
        <h3>메뉴</h3>
        <a href="student_list.do">학생 목록</a>
        <a href="student_input.do">학생 등록</a>
        <a href="student_list_rank.do">학생 성적 순위</a>
        <a href="javascript:openUploadPopup()">파일 업로드</a>
    </div>
    <div class="content">
        <div class="content-inner">
            <h3>학생 목록</h3>
            <form action="student_list.do" style="margin-bottom: 20px;">
                <table style="border: none;" class="selectbox">
                    <tr>
                        <td style="border: none;">
                            <select name="schFld">
                                <option value="all">전체</option>
                                <option value="name">이름</option>
                                <option value="dept">학과</option>
                            </select>
                        </td>
                        <td style="border: none;"><input type="text" name="schStr" value=""></td>
                        <td style="border: none;"><input type="submit" value="검색"></td>
                    </tr>
                </table>
            </form>
            <table class="dataTable">
                <thead>
                    <tr class='thc'>
                        <th>학생번호</th>
                        <th>학생이름</th>
                        <th>재적상태</th>
                        <th>입학/전학일자</th>
                        <th>성별</th>
                        <th>학과</th>
                        <th>학년</th>
                        <th>반</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="list" items="${studentList}" varStatus="status">
                        <tr>
                            <td class="tac"><a href="student_view.do?studentId=${list.studentId}&grade=${list.studentGrade}&name=${list.studentName}" style="text-decoration: none;"><c:out value="${list.studentId}" /></a></td>
                            <td class="tac"><c:out value="${list.studentName}" /></td>
                            <td class="tac"><c:out value="${list.state}" /></td>
                            <td class="tac"><c:out value="${list.entrance}" /></td>
                            <td class="tac"><c:out value="${list.studentSex}" /></td>
                            <td class="tac"><c:out value="${list.studentDepartment}" /></td>
                            <td class="tac"><c:out value="${list.studentGrade}" /></td>
                            <td class="tac"><c:out value="${list.studentClass}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="sectionDiv">
                <div id="paging" class="pagination">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
                </div>
                <div class="bt">
                    <a href="student_input.do">등록</a>
                    <a href="javascript:openUploadPopup()">업로드</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

