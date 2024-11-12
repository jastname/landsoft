<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생목록</title>
<link href="/css/style.css" rel="stylesheet">
<style>
body {
    font-family: Arial, sans-serif;
    display: flex;
    flex-direction: column;
}

h2, h3 {
    text-align: center;
}

.container {
    display: flex;
    width: 100%;
   height: 100%;
}

.sidebar {
    width: 200px;
    background-color: #f8f9fa;
    padding: 15px;
    box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
    height: 100vh;
}

.content {
    flex-grow: 1;
    padding: 20px;
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

.dataTable {
    margin: auto;
    border-collapse: collapse;
    width: 80%;
}

.dataTable th, .dataTable td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: center;
}

.button-container {
    text-align: center;
    margin-top: 20px;
}

.selectbox {
    text-align: center;
    margin: 20px auto;
}

.selectbox select {
    padding: 5px;
}
</style>
<script>
    function changeLangSelect() {
        var selectedValue = document.getElementById("selectbox").value;
        var form = document.getElementById("gradeForm");
        form.action = "student_view.do?grade=" + selectedValue;
        form.submit();
    }
    function openScoreInputPopup(studentId, grade) {
        var scores = [];
        var subjectIds = [];

        document.querySelectorAll('td[data-subject-id]').forEach(function(td) {
            var scoreInput = td.querySelector('input');
            var subjectId = td.getAttribute('data-subject-id');
            if (scoreInput && scoreInput.value.trim() !== "") {
                scores.push(scoreInput.value);
                subjectIds.push(subjectId);
            }
        });

        var url = "score_input.do?studentId=" + studentId + "&grade=" + grade
                + "&scores=" + encodeURIComponent(scores.join(','))
                + "&subjectIds=" + encodeURIComponent(subjectIds.join(','));
        var popupName = "ScoreInputPopup";
        var specs = "width=800,height=600,resizable=yes,scrollbars=yes";

        window.open(url, popupName, specs);
    }

    function openScoreEditPopup(studentId, grade, semester, scoreYear, scoreDivion, btn) {
        var scoreIds = [];
        var scores = [];
        var subjectIds = [];

        var row = btn.closest('tr');
        row.querySelectorAll('td[data-score-id]').forEach(function(td) {
            var scoreId = td.getAttribute('data-score-id');
            var scoreInput = td.querySelector('input');
            var subjectId = td.getAttribute('data-subject-id');

            if (scoreId && scoreId.trim() !== "") {
                scoreIds.push(scoreId);
                if (scoreInput) {
                    scores.push(scoreInput.value);
                    subjectIds.push(subjectId);
                }
            }
        });

        if (scoreIds.length === 0) {
            alert("점수 아이디가 존재하지 않습니다.");
            return;
        }
        if (scoreDivion == "기말") {
            scoreDivion = "F";
        } else {
            scoreDivion = "M";
        }
        var url = "score_edit.do?studentId=" + studentId + "&grade=" + grade
                + "&semester=" + semester + "&scoreYear="+ scoreYear + "&scoreDivion=" + scoreDivion
                + "&scoreIds=" + encodeURIComponent(scoreIds.join(','))
                + "&scores=" + encodeURIComponent(scores.join(','))
                + "&subjectIds=" + encodeURIComponent(subjectIds.join(','));
        var popupName = "ScoreEditPopup";
        var specs = "width=800,height=600,resizable=yes,scrollbars=yes";
        window.open(url, popupName, specs);
    }

    function confirmDelete() {
        return confirm("정말 삭제하시겠습니까?");
    }
</script>
</head>
<body>

<div class="container">
    <!-- 사이드바 -->
        <jsp:include page="menu.jsp"/>

    <!-- 메인 콘텐츠 -->
    <div class="content">
        <h2>학생 상세 정보</h2>
        <h3>학생 개인정보</h3>
        <c:if test="${not empty studentView}">
            <table class="dataTable">
                <tr>
                    <th>학생 ID</th>
                    <th>학생 이름</th>
                    <th>전화번호</th>
                    <th>주민등록번호</th>
                    <th>주소</th>
                    <th>생년월일</th>
                    <th>비상 연락처</th>
                </tr>
                <tr>
                    <td>${studentView.studentId}</td>
                    <td>${studentView.studentName}</td>
                    <td>${studentView.phoneNumber}</td>
                    <td>${studentView.residentRegistrationNumber}</td>
                    <td>${studentView.address}</td>
                    <td>${studentView.birthDate}</td>
                    <td>${studentView.emergencyPhoneNumber}</td>
                </tr>
            </table>
        </c:if>

        <div class="button-container">
            <a href="student_edit.do?studentId=${studentView.studentId}">수정</a>
        </div>

        <c:if test="${empty studentView}">
            <p style="text-align: center;">학생 정보가 없습니다.</p>
            <div class="button-container">
                <a href="student_view_input.do?studentId=${param.studentId}&name=${param.name}">등록</a>
            </div>
        </c:if>

        <h3>학생 성적</h3>
        <div class="selectbox">
            <form id="gradeForm" method="GET">
                <select id="selectbox" name="grade" onchange="changeLangSelect()">
                    <option value="1" <c:if test="${param.grade == '1'}">selected</c:if>>1학년</option>
                    <option value="2" <c:if test="${param.grade == '2'}">selected</c:if>>2학년</option>
                    <option value="3" <c:if test="${param.grade == '3'}">selected</c:if>>3학년</option>
                </select> <input type="hidden" name="studentId"
                    value="${studentView.studentId}" />
            </form>
        </div>

        <c:if test="${not empty studentScore}">
            <table class="dataTable" style="margin: auto;">
                <tr class="thc">
                    <th>년도</th>
                    <th>학기</th>
                    <th>구분</th>
                    <c:forEach var="subject" items="${studentSubject}"
                        varStatus="status">
                        <c:if test="${param.grade == subject.studentGrade}">
                            <th><c:out value="${subject.subjectName}" /></th>
                        </c:if>
                    </c:forEach>
                    <th>총점</th>
                    <th>평균</th>
                    <th>관리</th>
                </tr>
                <c:set var="previousSemester" value="" />
                <c:set var="previousScoreDivion" value="" />
                <c:set var="rowCount" value="0" />

                <c:forEach var="list" items="${studentScore}" varStatus="status">
                    <c:if test="${rowCount < 4 && (list.semester != previousSemester || list.scoreDivion != previousScoreDivion)}">
                        <tr>
                            <td>${list.scoreYear}</td>
                            <td>${list.semester}</td>
                            <td>${list.scoreDivion}</td>
                            <c:forEach var="subject" items="${studentSubject}">
                                <td data-subject-id="${subject.subjectId}"
                                    <c:forEach var="score" items="${studentScore}">
                                    <c:if test="${list.semester == score.semester && list.scoreDivion == score.scoreDivion && subject.subjectId == score.subjectId}">
                                        data-score-id="${score.scoresId}"
                                    </c:if>
                                </c:forEach>>
                                    <c:set var="subjectScore" value="" />
                                    <c:forEach var="score" items="${studentScore}">
                                        <c:if test="${list.semester == score.semester && list.scoreDivion == score.scoreDivion && subject.subjectId == score.subjectId}">
                                            <c:set var="subjectScore" value="${score.scores}" />
                                        </c:if>
                                    </c:forEach>
                                    <c:choose>
                                        <c:when test="${not empty subjectScore}">
                                            <c:out value="${subjectScore}" />
                                        </c:when>
                                        <c:otherwise>&nbsp;</c:otherwise>
                                    </c:choose>
                                </td>
                            </c:forEach>
                            <td>${list.totalScore}</td>
                            <td>${list.average}</td>
                            <td><c:choose>
                                    <c:when test="${empty list.totalScore}">
                                        <button type="button" onclick="openScoreInputPopup('${studentView.studentId}', '${param.grade}')">등록</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" onclick="openScoreEditPopup('${studentView.studentId}', '${param.grade}','${list.semester}','${list.scoreYear}','${list.scoreDivion}', this)">수정</button>
                                    </c:otherwise>
                                </c:choose></td>
                        </tr>
                        <c:set var="previousSemester" value="${list.semester}" />
                        <c:set var="previousScoreDivion" value="${list.scoreDivion}" />
                        <c:set var="rowCount" value="${rowCount + 1}" />
                    </c:if>
                </c:forEach>

                <c:set var="emptyRows" value="${4 - rowCount}" />
                <c:if test="${emptyRows > 0}">
                    <c:forEach var="i" begin="0" end="${emptyRows - 1}">
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <c:forEach var="subject" items="${studentSubject}">
                                <td></td>
                            </c:forEach>
                            <td></td>
                            <td></td>
                            <td><button type="button" onclick="openScoreInputPopup('${studentView.studentId}', '${param.grade}')">등록</button></td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </c:if>

        <c:if test="${empty studentScore}">
            <p style="text-align: center;">학생의 "${param.grade}"학년 성적 정보가 없습니다.</p>
            <table class="dataTable" style="margin: auto;">
                <tr class="thc">
                    <th>년도</th>
                    <th>학기</th>
                    <th>구분</th>
                    <c:forEach var="subject" items="${studentSubject}">
                        <c:if test="${param.grade == subject.studentGrade}">
                            <th><c:out value="${subject.subjectName}" /></th>
                        </c:if>
                    </c:forEach>
                    <th>총점</th>
                    <th>평균</th>
                    <th>관리</th>
                </tr>
                <c:forEach var="i" begin="0" end="3">
                    <tr>
                        <c:forEach var="j" begin="1" end="${fn:length(studentSubject) + 5}">
                            <td></td>
                        </c:forEach>
                        <td><button type="button" onclick="openScoreInputPopup('${studentView.studentId}', '${param.grade}')">등록</button></td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>

        <div class="button-container">
            <a href="student_list.do">목록</a>
            <a href="student_delete.do?studentId=${studentView.studentId}" onclick="return confirmDelete();">삭제</a>
        </div>
    </div>
</div>

</body>
</html>
