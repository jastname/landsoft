<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>학생 등록</title>
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
			margin: 0 10px;
			padding: 8px 16px;
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
		function fn_saveStudent() {
			var frm = document.studentFrm;
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
			if (!frm.state.value) {
				alert("재적상태를 선택하세요.");
				return;
			}
			if (!frm.student_sex.value) {
				alert("성별을 선택하세요.");
				return;
			}
			if (!frm.student_grade.value) {
				alert("학년을 선택하세요.");
				return;
			}
			if (!frm.student_department.value.trim()) {
				alert("학과를 입력하세요.");
				frm.student_department.focus();
				return;
			}
			if (!frm.student_class.value.trim()) {
				alert("반을 입력하세요.");
				frm.student_class.focus();
				return;
			}
			if (!frm.student_number.value.trim()) {
				alert("번호를 입력하세요.");
				frm.student_number.focus();
				return;
			}
			frm.submit();
		}
	</script>
</head>
<body>
	<h3>학생 등록</h3>
	<form name="studentFrm" id="studentFrm" method="post" action="student_input_proc.do">
		<table class="dataTable">
			<tr>
				<th>학생번호</th>
				<td><input type="text" name="student_id" id="student_id" /></td>
			</tr>
			<tr>
				<th>학생이름</th>
				<td><input type="text" name="student_name" id="student_name" /></td>
			</tr>
			<tr>
				<th>재적상태</th>
				<td class="radio-group">
					<label><input type="radio" name="state" value="A" /> 재학</label>
					<label><input type="radio" name="state" value="B" /> 전학</label>
					<label><input type="radio" name="state" value="C" /> 자퇴</label>
					<label><input type="radio" name="state" value="D" /> 유급</label>
				</td>
			</tr>
			<tr>
				<th>입학/전입날짜</th>
				<td><input type="text" name="entrance" id="entrance" /></td>
			</tr>
			<tr>
				<th>졸업/전출날짜</th>
				<td><input type="text" name="graduation" id="graduation" /></td>
			</tr>
			<tr>
				<th>휴학년도</th>
				<td><input type="text" name="leave_year" id="leave_year" /></td>
			</tr>
			<tr>
				<th>퇴학년도</th>
				<td><input type="text" name="expelled_year" id="expelled_year" /></td>
			</tr>
			<tr>
				<th>성별</th>
				<td class="radio-group">
					<label><input type="radio" name="student_sex" value="남" /> 남</label>
					<label><input type="radio" name="student_sex" value="여" /> 여</label>
				</td>
			</tr>
			<tr>
				<th>학년</th>
				<td class="radio-group">
					<label><input type="radio" name="student_grade" value="1" /> 1학년</label>
					<label><input type="radio" name="student_grade" value="2" /> 2학년</label>
					<label><input type="radio" name="student_grade" value="3" /> 3학년</label>
				</td>
			</tr>
			<tr>
				<th>학과</th>
				<td><input type="text" name="student_department" id="student_department" /></td>
			</tr>
			<tr>
				<th>반</th>
				<td><input type="text" name="student_class" id="student_class" /></td>
			</tr>
			<tr>
				<th>번호</th>
				<td><input type="text" name="student_number" id="student_number" /></td>
			</tr>
		</table>
	</form>

	<div class="button-container">
		<a href="student_list.do">목록</a>
		<a href="#" onclick="fn_saveStudent();">등록</a>
	</div>
</body>
</html>
