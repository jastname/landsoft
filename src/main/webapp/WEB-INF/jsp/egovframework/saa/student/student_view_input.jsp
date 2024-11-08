<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생 등록</title>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<link href="/css/style.css" rel="stylesheet">
	<style>
		table.dataTable {
			border-collapse: collapse;

			font-size: 18px;
			text-align: left;
		}
		table.dataTable th, table.dataTable td {
			padding: 0px;
			border: 1px solid #ddd;
		}
		table.dataTable th {
			background-color: #bafdff; /* 왼쪽 부분 배경색 설정 */
			color: #333;
			text-align: center;
		}
		/* table.dataTable tr:nth-child(even) {
			background-color: #f9f9f9;
		} */
		table.dataTable tr:hover {
			background-color: #f1f1f1;
		}
		input[type="text"]{
			border: none;
			width: 100%;
			padding: 8px;
			box-sizing: border-box;
		}
		.radio-group{
			text-align: center;
		}
	</style>
	<script>
	function fn_saveStudent() {
	    var frm = document.studentFrm;

	    // 필수 입력 필드 유효성 검사
	    if (!frm.student_id.value.trim()) {
	        alert("학생번호를 입력하세요.");
	        frm.student_id.focus();
	        return;
	    }

	    if (!frm.student_name.value.trim()) {
	        alert("학생이름을 입력하세요.");
	        frm.student_name.focus();
	        return;
	    }

	    if (!frm.phone_number.value.trim()) {
	        alert("전화번호를 입력하세요.");
	        frm.phone_number.focus();
	        return;
	    }

	    if (!frm.resident_registration_number.value.trim()) {
	        alert("주민등록번호를 입력하세요.");
	        frm.resident_registration_number.focus();
	        return;
	    }

	    if (!frm.address.value.trim()) {
	        alert("주소를 입력하세요.");
	        frm.address.focus();
	        return;
	    }

	    if (!frm.birth_date.value.trim()) {
	        alert("생년월일을 입력하세요.");
	        frm.birth_date.focus();
	        return;
	    }

	    if (!frm.emergency_phone_number.value.trim()) {
	        alert("비상 연락처를 입력하세요.");
	        frm.emergency_phone_number.focus();
	        return;
	    }

	    // 모든 필드가 올바르게 입력된 경우 폼 제출
	    frm.submit();
	}

	</script>
</head>
<body>
	<div>
		<h3>학생 정보 수정2</h3>
		<form name="studentFrm" id="studentFrm" method="post" action="student_view_input_proc.do">
		<table class="dataTable">
			<tr>
				<th>학생 ID</th>
				<td><input type="text" name="student_id" id="student_id" size="50" value="${param.studentId}"/></td>
			</tr>
			<tr>
				<th>학생이름</th>
				<td><input type="text" name="student_name" id="student_name" size="50" value="${param.name}"/></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><input type="text" name="phone_number" id="phone_number" size="50"/></td>
			</tr>
			<tr>
				<th>주민등록번호</th>
				<td><input type="text" name="resident_registration_number" id="resident_registration_number" size="50"/></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="address" id="address" size="10"/></td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td><input type="text" name="birth_date" id="birth_date" size="10"/></td>
			</tr>
			<tr>
				<th>비상 연락처</th>
				<td><input type="text" name="emergency_phone_number" id="emergency_phone_number" size="10"/></td>
			</tr>
		</table>
		</form>
	</div>

	<div>
		<a href="#" onclick="fn_saveStudent();">등록</a>
	</div>

</body>
</html>
