<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>학생 성적 수정</title>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link href="/css/style.css" rel="stylesheet">
<style>
    body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        flex-direction: column;
    }
    h3 {
        text-align: center;
        margin-bottom: 20px;
    }
    table.dataTable {
        border-collapse: collapse;
        width: 100%;
        max-width: 600px;
        font-size: 16px;
        margin: auto;
        background-color: #f9f9f9;
    }
    table.dataTable th, table.dataTable td {
        padding: 8px;
        border: 1px solid #ddd;
        text-align: left;
    }
    table.dataTable th {
        background-color: #bafdff;
        color: #333;
        text-align: center;
    }
    table.dataTable tr:hover {
        background-color: #f1f1f1;
    }
    input[type="text"] {
        width: 100%;
        padding: 6px;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .radio-group {
        text-align: center;
    }
    .radio-group label {
        margin-right: 15px;
    }
    .button-container {
        text-align: center;
        margin-top: 20px;
    }
    .button-container a {
        display: inline-block;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border-radius: 4px;
        font-weight: bold;
    }
    .button-container a:hover {
        background-color: #45a049;
    }
</style>
<script>
    function fn_saveScore() {
        var frm = document.studentFrm;

        // Check if semester is selected
        if (!$("input[name='semester']:checked").val()) {
            alert("학기를 선택하세요.");
            $("input[name='semester']").focus();
            return;
        }

        // Check if score division is selected
        if (!$("input[name='score_divion']:checked").val()) {
            alert("시험 구분을 선택하세요.");
            $("input[name='score_divion']").focus();
            return;
        }

        // Check if all scores are entered
        let allScoresEntered = true;
        $("input[name^='score_']").each(function() {
            if ($(this).val() === "") {
                alert("모든 과목의 성적을 입력하세요.");
                $(this).focus(); // Focus on the empty field
                allScoresEntered = false;
                return false; // Exit loop
            }
        });

        if (!allScoresEntered) {
            return;
        }

        // Submit the form if all validations pass
        frm.submit();
    }
</script>
</head>
<body>
    <h3>학생 성적 수정</h3>
    <form name="studentFrm" id="studentFrm" method="post" action="score_edit_proc.do">
        <input type="hidden" name="grade" value="${param.grade}" />
        <input type="hidden" name="scoreIds" value="${param.scoreIds}" />
        <table class="dataTable">
            <tr>
                <th>학생아이디</th>
                <td><input type="text" value="${studentView.studentId}" name="studentId" readonly></td>
            </tr>
            <tr>
                <th>학기</th>
                <td>
                    <label><input type="radio" name="semester" value="1" <c:if test="${scoreSemester == 1}">checked="checked"</c:if> /> 1학기</label>
                    <label><input type="radio" name="semester" value="2" <c:if test="${scoreSemester == 2}">checked="checked"</c:if> /> 2학기</label>
                </td>
            </tr>
            <tr>
                <th>시험 년도</th>
                <td><input type="text" name="score_year" value="${scoreYear}"></td>
            </tr>
            <tr>
                <th>구분</th>
                <td>
                    <label><input type="radio" name="score_divion" value="M" <c:if test="${param.scoreDivion == 'M'}">checked="checked"</c:if> /> 중간고사</label>
                    <label><input type="radio" name="score_divion" value="F" <c:if test="${param.scoreDivion == 'F'}">checked="checked"</c:if> /> 기말고사</label>
                </td>
            </tr>

            <c:forEach var="subject" items="${studentSubject}">
                <tr>
                    <th><c:out value="${subject.subjectName}" /></th>
                    <!-- Initialize score -->
                    <c:set var="score" value="" />
                    <!-- Find the score for the subject from studentScore list -->
                    <c:forEach var="scoreMap" items="${studentScore}">
                        <c:if test="${scoreMap.subjectId == subject.subjectId}">
                            <c:set var="score" value="${scoreMap.scores}" />
                        </c:if>
                    </c:forEach>
                    <!-- Score input field -->
                    <td><input type="text" name="score_${fn:escapeXml(subject.subjectId)}" value="${score}" /></td>
                </tr>
            </c:forEach>
        </table>
    </form>

    <div class="button-container">
        <a href="#" onclick="fn_saveScore();">수정</a>
    </div>
</body>
</html>
