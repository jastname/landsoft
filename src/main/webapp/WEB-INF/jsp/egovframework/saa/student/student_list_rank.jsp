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
    display: flex;
    justify-content: center;
    align-items: center;
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

.content-inner {
    width: 100%;
    max-width: 800px; /* 콘텐츠 너비 제한 */
    text-align: center;

}

.content-inner h3 {
    margin-bottom: 20px;
}

.selectbox, .dataTable, .sectionDiv {
    margin: 0 auto 20px auto; /* 요소를 가로로 중앙에 배치 */
}

.dataTable {
    width: 100%;
    max-width: 100%; /* 테이블이 콘텐츠 너비를 넘지 않도록 */
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
    margin-left: auto; /* 버튼을 오른쪽으로 정렬 */
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

    document.addEventListener("DOMContentLoaded", function() {
        const subjectSelect = document.getElementById("subjectSelect");
        if (subjectSelect) {
            subjectSelect.innerHTML = ""; // 기존 옵션 초기화
            const option = document.createElement("option");
            option.value = "";
            option.textContent = "학년을 선택하세요";
            subjectSelect.appendChild(option);
        }
    });

    function updateSubjects() {
        const gradeSelect = document.getElementById("gradeSelect");
        const subjectSelect = document.getElementById("subjectSelect");

        if (!gradeSelect || !subjectSelect) {
            console.error("필요한 요소를 찾을 수 없습니다.");
            return;
        }

        const grade = gradeSelect.value;

        if (!grade) {
            subjectSelect.innerHTML = ""; // 기존 옵션을 초기화
            const option = document.createElement("option");
            option.value = "";
            option.textContent = "학년을 선택하세요";
            subjectSelect.appendChild(option);
            return;
        }

        const url = '/student/getSubjectsByGrade.do?grade=' + grade;

        fetch(url)
            .then(response => {
                if (!response.ok) {
                    throw new Error('네트워크 응답에 문제가 있습니다.');
                }
                return response.json();
            })
            .then(data => {
                subjectSelect.innerHTML = ""; // 기존 옵션을 초기화
                data.forEach(subject => {
                    const option = document.createElement("option");
                    option.value = subject.subjectId;
                    option.textContent = subject.subjectName;
                    subjectSelect.appendChild(option);
                });
            })
            .catch(error => {
                console.error('과목을 불러오는 중 오류 발생:', error);
                subjectSelect.innerHTML = ""; // 오류 시에도 초기화
                const option = document.createElement("option");
                option.value = "";
                option.textContent = "과목을 불러오는 중 오류 발생";
                subjectSelect.appendChild(option);
            });
    }
</script>
</head>
<body>
<div class="container">
    <jsp:include page="menu.jsp"/>
    <div class="content">
        <div class="content-inner">
            <h3>학생 순위</h3>
            <form action="student_list_rank.do" style="margin-bottom: 20px;">
                <table style="border: none;" class="selectbox">
                    <tr>
                        <!-- 학년 선택 -->
                        <td style="border: none;"><select name="grade" id="gradeSelect" onchange="updateSubjects()" style="text-align: center;">
                            <option value="">학년을 선택하세요</option>
                            <option value="1">1학년</option>
                            <option value="2">2학년</option>
                            <option value="3">3학년</option>
                        </select></td>
                        <!-- 학기 선택 -->
                        <td style="border: none;"><select name="semester">
                            <option value="1">1학기</option>
                            <option value="2">2학기</option>
                        </select></td>
                        <!-- 시험 구분 선택 -->
                        <td style="border: none;"><select name="examType">
                            <option value="M">중간고사</option>
                            <option value="F">기말고사</option>
                        </select></td>
                        <!-- 과목 선택 -->
                        <td style="border: none;"><select name="subject" id="subjectSelect" style="text-align: center;">
                            <!-- Ajax를 통해 옵션이 동적으로 생성됩니다 -->
                        </select></td>
                        <!-- 검색 버튼 -->
                        <td style="border: none;"><input type="submit" value="검색"></td>
                    </tr>
                </table>
            </form>

            <table class="dataTable">
                <thead>
                    <tr class='thc'>
                    	<th>순위</th>
                        <th>학생번호</th>
                        <th>학생이름</th>
                        <th>점수</th>
                        <th>등급</th>
                        <th>성취도</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="list" items="${studentList}" varStatus="status">
                        <tr>
                        	<td class="tac"><c:out value="${list.rank}" /></td>
                            <td class="tac"><c:out value="${list.studentId}" /></td>
                            <td class="tac"><c:out value="${list.studentName}" /></td>
                            <td class="tac"><c:out value="${list.scores}" /></td>
                            <td class="tac"><c:out value="${list.rating}" /></td>
                            <td class="tac"><c:out value="${list.achievement}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="sectionDiv">
                <div id="paging" class="pagination">
                    <ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
