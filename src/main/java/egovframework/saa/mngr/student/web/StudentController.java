package egovframework.saa.mngr.student.web;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.core.io.FileSystemResource;
import org.springframework.dao.DataAccessException;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import egovframework.saa.module.student.service.StudentService;

import javax.servlet.http.HttpServletResponse;

@Controller
public class StudentController {

	/** studentService */
	@Resource(name = "studentService")
	private StudentService studentService;

	private static final Logger LOGGER = LogManager.getLogger(StudentController.class);

	@RequestMapping(value = "/student/student_list.do")
	public String selectStudentList(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 목록");

		String page = request.getParameter("page") == null ? "1" : request.getParameter("page");
		String schFld = request.getParameter("schFld") == null ? "" : request.getParameter("schFld");
		String schStr = request.getParameter("schStr") == null ? "" : request.getParameter("schStr");

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(Integer.parseInt(page));
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);
		EgovMap egovMap = new EgovMap();
		egovMap.put("schFld", schFld);
		egovMap.put("schStr", schStr);
		egovMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
		egovMap.put("lastIndex", paginationInfo.getLastRecordIndex());
		LOGGER.info("egovMap ::: " + egovMap);

		// 학생 목록 가져오기

		try {
			List<EgovMap> studentList = studentService.selectStudentList(egovMap);

			model.addAttribute("studentList", studentList);

			/** pageing data setting */
			LOGGER.info("end" + studentList.get(0));
			int totCnt = ((Long) studentList.get(0).get("totcnt")).intValue();
			LOGGER.info("end 2");
			paginationInfo.setTotalRecordCount(totCnt);
			// JSP 데이타 전달
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paramMap", egovMap);
			LOGGER.info("end ");
			LOGGER.info("학생 조회 성공");
		}catch (RuntimeException e) {
			LOGGER.error("실행중학생 조회 실패: " + e.getMessage(), e);
			// 오류 발생 시 사용자에게 알리기 위해 모델에 오류 메시지 추가
			model.addAttribute("errorMessage", "실행중 학생 조회 중 오류가 발생했습니다.");
			return "saa/student/student_input"; // 오류가 발생한 경우 입력 페이지로 돌아가기
		}catch (Exception e) {
			LOGGER.error("학생 조회 실패: " + e.getMessage(), e);
			// 오류 발생 시 사용자에게 알리기 위해 모델에 오류 메시지 추가
			model.addAttribute("errorMessage", "학생 조회 중 오류가 발생했습니다.");
			return "saa/student/student_input"; // 오류가 발생한 경우 입력 페이지로 돌아가기
		}
		return "saa/student/student_list";
	}
	@RequestMapping(value = "/student/student_list_rank.do")
	public String selectStudentListRank(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 목록");

		String page = request.getParameter("page") == null ? "1" : request.getParameter("page");
		String schFld = request.getParameter("schFld") == null ? "" : request.getParameter("schFld");
		String schStr = request.getParameter("schStr") == null ? "" : request.getParameter("schStr");
		String semester = request.getParameter("semester") == null ? "1" : request.getParameter("semester");
		String examType = request.getParameter("examType") == null ? "M" : request.getParameter("examType");
		String subject = request.getParameter("subject") == null ? "SUB001" : request.getParameter("subject");
		String grade = request.getParameter("grade") == null ? "1" : request.getParameter("grade");

		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(Integer.parseInt(page));
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);
		EgovMap egovMap = new EgovMap();
		egovMap.put("schFld", schFld);
		egovMap.put("semester", semester);
		egovMap.put("scoreDivion", examType);
		egovMap.put("schStr", schStr);
		egovMap.put("subject", subject);
		egovMap.put("grade", grade);
		egovMap.put("firstIndex", paginationInfo.getFirstRecordIndex());
		egovMap.put("lastIndex", paginationInfo.getLastRecordIndex());
		LOGGER.info("egovMap ::: " + egovMap);


		EgovMap subjectMap = new EgovMap();
		subjectMap.put("studentGrade", grade);
		// 학생 목록 가져오기

		try {
			List<EgovMap> studentList = studentService.selectStudentRank(egovMap);
			List<EgovMap> studentSubject = studentService.selectStudentSubject(subjectMap);
			model.addAttribute("studentList", studentList);
			// JSP 데이타 전달
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("paramMap", egovMap);
			model.addAttribute("studentSubject", studentSubject);
			LOGGER.info("end ");
			LOGGER.info("학생 순위 조회 성공");
		} catch (RuntimeException e) {
			LOGGER.error("실행중 학생 조회 실패: " + e.getMessage(), e);
		// 오류 발생 시 사용자에게 알리기 위해 모델에 오류 메시지 추가
			model.addAttribute("errorMessage", "실행중 학생 순위 조회 중 오류가 발생했습니다.");
		return "saa/student/student_list_rank";
		}catch (Exception e) {
			LOGGER.error("학생 등록 실패: " + e.getMessage(), e);
			// 오류 발생 시 사용자에게 알리기 위해 모델에 오류 메시지 추가
			model.addAttribute("errorMessage", "학생 순위 조회 중 오류가 발생했습니다.");
			return "saa/student/student_list_rank";
		}
		return "saa/student/student_list_rank";
	}

	@RequestMapping(value = "/student/student_input.do")
	public String inputStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 등록");

		EgovMap egovMap = new EgovMap();
		LOGGER.info("egovMap ::: " + egovMap);

		return "saa/student/student_input";
	}

	@RequestMapping(value = "/student/student_input_proc.do")
	public String inputStudentProc(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 등록 처리");

		EgovMap egovMap = new EgovMap();
		String studentId = request.getParameter("student_id");
		String studentName = request.getParameter("student_name");
		String state = request.getParameter("state");
		String entrance = request.getParameter("entrance");
		String graduation = request.getParameter("graduation");
		String leaveYear = request.getParameter("leave_year");
		String expelledYear = request.getParameter("expelled_year");
		String studentSex = request.getParameter("student_sex");
		String studentGrade = request.getParameter("student_grade");
		String studentDepartment = request.getParameter("student_department");
		String studentClass = request.getParameter("student_class");
		String studentNumber = request.getParameter("student_number");

		// egovMap에 학생 데이터 채우기
		egovMap.put("studentId", studentId);
		egovMap.put("studentName", studentName);
		egovMap.put("state", state);
		egovMap.put("entrance", entrance);
		egovMap.put("graduation", graduation);
		egovMap.put("leaveYear", leaveYear);
		egovMap.put("expelledYear", expelledYear);
		egovMap.put("studentSex", studentSex);
		egovMap.put("studentGrade", studentGrade);
		egovMap.put("studentDepartment", studentDepartment);
		egovMap.put("studentClass", studentClass);
		egovMap.put("studentNumber", studentNumber);

		LOGGER.info("egovMap ::: " + egovMap);

		try {
			// 학생 정보를 저장하기 위해 서비스 메서드 호출
			studentService.insertStudent(egovMap);
			LOGGER.info("학생 등록 성공");
		} catch (Exception e) {
			LOGGER.error("학생 등록 실패: " + e.getMessage(), e);
			// 오류 발생 시 사용자에게 알리기 위해 모델에 오류 메시지 추가
			model.addAttribute("errorMessage", "학생 등록 중 오류가 발생했습니다.");
			return "saa/student/student_input"; // 오류가 발생한 경우 입력 페이지로 돌아가기
		}

		return "redirect:./student_list.do"; // 성공적으로 등록된 후 학생 목록 페이지로 리다이렉트
	}

	@RequestMapping(value = "/student/student_view.do")
	public String studentView(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 정보 조회");

		String studentId = request.getParameter("studentId"); // 학생 번호를 요청 파라미터에서 가져옴
		String studentGrade = request.getParameter("grade");
		LOGGER.info("조회할 학생 번호: " + studentId);

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		EgovMap scoreMap2 = new EgovMap();
		scoreMap2.put("studentId", studentId); // 성적 (총합, 평균
		scoreMap2.put("studentGrade", studentGrade);
		EgovMap subjectMap = new EgovMap(); // 과목
		subjectMap.put("studentId", studentId);
		subjectMap.put("studentGrade", studentGrade);
		EgovMap scoreMap = new EgovMap(); // 성적 (개별 과목당 점수
		scoreMap.put("studentId", studentId);
		scoreMap.put("studentGrade", studentGrade);

		try {
			// 학생 정보를 조회하기 위해 서비스 메서드 호출
			EgovMap studentView = studentService.studentView(egovMap);
			List<EgovMap> studentScore = studentService.selectStudentScore(scoreMap2);
			List<EgovMap> studentSubject = studentService.selectStudentSubject(subjectMap);

			studentSubject
					.sort((map1, map2) -> map1.get("subjectId").toString().compareTo(map2.get("subjectId").toString()));
			model.addAttribute("studentView", studentView); // 조회된 학생 정보를 모델에 추가
			model.addAttribute("studentScore", studentScore);
			model.addAttribute("studentSubject", studentSubject);
			model.addAttribute("studentId", studentId);
			LOGGER.info("학생 정보 조회 성공: " + studentView);
			LOGGER.info("학생 성적 조회 성공: " + studentScore);
			LOGGER.info("과목 조회 성공: " + studentSubject);
			LOGGER.info("과목 리스트: " + studentSubject);

		} catch (RuntimeException e) {
			LOGGER.error("실행중 학생 정보 조회 실패: " + e.getMessage(), e);
			model.addAttribute("errorMessage", "학생 정보 조회 중 오류가 발생했습니다.");
			return "saa/student/student_view"; // 오류가 발생한 경우 상세 페이지로 돌아가기
		} catch (Exception f) {
			LOGGER.error("학생 정보 조회 실패: " + f.getMessage(), f);
			model.addAttribute("errorMessage", "학생 정보 조회 중 오류가 발생했습니다.");
			return "saa/student/student_view"; // 오류가 발생한 경우 상세 페이지로 돌아가기
		}

		return "saa/student/student_view"; // 학생 정보 페이지로 이동
	}

	@RequestMapping(value = "/student/student_edit.do")
	public String editStudentView(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 정보 수정");

		String studentId = request.getParameter("studentId"); // 학생 상세페이지에서 보낸 학생 번호 받기
		LOGGER.info("수정할 학생 번호: " + studentId);

		EgovMap egovMap = new EgovMap();
		egovMap.put("studentId", studentId);
		LOGGER.info("egovMap ::: " + egovMap);

		try {
			// 학생 정보를 조회하기 위해 서비스 메서드 호출
			EgovMap studentView = studentService.studentView(egovMap);
			model.addAttribute("studentView", studentView); // 조회된 학생 정보를 모델에 추가
			LOGGER.info("학생 정보 조회 성공: " + studentView);
		} catch (RuntimeException e) {
			LOGGER.error("실행중 학생 정보 조회 실패: " + e.getMessage(), e);
			model.addAttribute("errorMessage", "학생 정보 조회 중 오류가 발생했습니다.");
			return "saa/student/student_view"; // 오류가 발생한 경우 상세 페이지로 돌아가기
		} catch (Exception f) {
			LOGGER.error("학생 정보 조회 실패: " + f.getMessage(), f);
			model.addAttribute("errorMessage", "학생 정보 조회 중 오류가 발생했습니다.");
			return "saa/student/student_view"; // 오류가 발생한 경우 상세 페이지로 돌아가기
		}

		return "saa/student/student_view_edit";
	}

	@RequestMapping(value = "/student/student_edit_proc.do")
	public String updateStudentProc(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 정보 수정 처리");

		EgovMap egovMap = new EgovMap();
		String studentId = request.getParameter("student_id");
		String studentName = request.getParameter("student_name");
		String phoneNumber = request.getParameter("phone_number");
		String residentRegistrationNumber = request.getParameter("resident_registration_number");
		String address = request.getParameter("address");
		String birthDate = request.getParameter("birth_date");
		String emergencyPhoneNumber = request.getParameter("emergency_phone_number");

		egovMap.put("studentId", studentId);
		egovMap.put("studentName", studentName);
		egovMap.put("phoneNumber", phoneNumber);
		egovMap.put("residentRegistrationNumber", residentRegistrationNumber);
		egovMap.put("address", address);
		egovMap.put("birthDate", birthDate);
		egovMap.put("emergencyPhoneNumber", emergencyPhoneNumber);

		LOGGER.info("egovMap ::: " + egovMap);

		try {
			studentService.updateStudentView(egovMap);
			LOGGER.info("학생 정보 수정 성공");
		} catch (RuntimeException e) {
			LOGGER.error("실행중 학생 정보 수정 실패: " + e.getMessage(), e);
			model.addAttribute("errorMessage", "학생 정보 수정 중 오류가 발생했습니다.");
			return "saa/student/student_view_update";
		} catch (Exception f) {
			LOGGER.error("학생 정보 수정 실패: " + f.getMessage(), f);
			model.addAttribute("errorMessage", "학생 정보 수정 중 오류가 발생했습니다.");
			return "saa/student/student_view_update";
		}

		return "redirect:./student_list.do";
	}

	@RequestMapping(value = "/student/student_delete.do")
	public String deleteStudent(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 정보 삭제 처리");

		EgovMap egovMap = new EgovMap();
		String studentId = request.getParameter("studentId");
		LOGGER.info(studentId);
		egovMap.put("studentId", studentId);

		LOGGER.info("egovMap ::: " + egovMap);

		try {
			studentService.deleteStudent(egovMap);
			LOGGER.info("학생 정보 삭제 성공");
		} catch (RuntimeException e) {
			LOGGER.error("실행중 학생 정보 삭제 실패: " + e.getMessage(), e);
			model.addAttribute("errorMessage", "학생 정보 삭제 중 오류가 발생했습니다.");
			return "saa/student/student_view_update";
		} catch (Exception f) {
			LOGGER.error("학생 정보 삭제 실패: " + f.getMessage(), f);
			model.addAttribute("errorMessage", "학생 정보 삭제 중 오류가 발생했습니다.");
			return "saa/student/student_view_update";
		}

		return "redirect:./student_list.do";
	}

	@RequestMapping(value = "/student/score_input.do")
	public String inputScore(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {

		String studentGrade = request.getParameter("grade");
		LOGGER.info("학생 성적 등록");
		String studentId = request.getParameter("studentId");

		LOGGER.info("학생 성적 등록");
		EgovMap subjectMap = new EgovMap();// 과목 조회
		subjectMap.put("studentGrade", studentGrade);
		subjectMap.put("studentId", studentId);
		EgovMap viewMap = new EgovMap(); // 학생 조회
		viewMap.put("studentId", studentId);
		List<EgovMap> studentsubject = studentService.selectStudentSubject(subjectMap);
		EgovMap studentView = studentService.studentView(viewMap);
		model.addAttribute("studentView", studentView);
		model.addAttribute("studentSubject", studentsubject);
		LOGGER.info("egovMap ::: " + subjectMap);

		return "saa/student/score_input";
	}

	@RequestMapping(value = "/student/score_input_proc.do")
	public String insertScoreProc(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("점수 삽입 처리");

		EgovMap scoreMap = new EgovMap();
		EgovMap subjectMap = new EgovMap();
		String studentId = request.getParameter("studentId");
		String grade = request.getParameter("grade"); // 학년 파라미터 추가
		String semester = request.getParameter("semester");
		String scoreYear = request.getParameter("score_year");
		String scoreDivion = request.getParameter("score_divion");

		LOGGER.info("Student ID: " + studentId);
		LOGGER.info("Semester: " + semester);
		LOGGER.info("grade: " + grade);
		LOGGER.info("Score Year: " + scoreYear);
		LOGGER.info("Score Division: " + scoreDivion);

		subjectMap.put("studentGrade", grade);
		subjectMap.put("studentId", studentId);
		// 학년별로 과목 ID 설정
		List<EgovMap> studentSubject = studentService.selectStudentSubject(subjectMap);
		// 예시 코드에서 EgovMap에 담긴 필드명이 올바르게 설정되어 있는지 확인
		String[] subjectIds = studentSubject.stream().map(student -> (String) student.get("subjectId"))
				.toArray(String[]::new);
		// 현재 있는 점수의 갯수를 가져오고, 그 갯수에 1을 더한 값이 새로운 점수 번호가 됨
		int currentScoreCount = studentService.countScore(); // 점수 개수를 가져옴
		int scoreNumber = currentScoreCount + 1; // 점수 번호는 현재 점수 개수 + 1
		LOGGER.info(scoreNumber);

		// 점수 파라미터 처리 및 반복적인 삽입
		for (String subjectId : subjectIds) {
			String scoreParam = request.getParameter("score_" + subjectId); // 과목별 점수를 받아옴
			if (scoreParam != null && !scoreParam.isEmpty()) {
				// 점수 정보를 egovMap에 추가
				scoreMap.put("scoresId", scoreNumber); // 각 점수마다 고유한 ID
				scoreMap.put("studentId", studentId); // 학생 ID
				scoreMap.put("semester", semester); // 학기
				scoreMap.put("scoreYear", scoreYear); // 연도
				scoreMap.put("scoreDivion", scoreDivion); // 중간/기말 구분
				scoreMap.put("subjectId", subjectId); // 과목 ID
				scoreMap.put("score", scoreParam); // 점수

				try {
					// 각각의 점수 삽입
					studentService.insertScore(scoreMap);
					LOGGER.info("과목 " + subjectId + "에 대한 점수 삽입 성공");
				} catch (RuntimeException e) {
					LOGGER.error("실행중 과목 " + subjectId + "에 대한 점수 삽입 실패: " + e.getMessage(), e);
					model.addAttribute("errorMessage", "과목 " + subjectId + " 점수 삽입 중 오류가 발생했습니다.");
					return "saa/student/student_view_update";
				} catch (Exception f) {
					LOGGER.error("점수 삽입 실패: " + f.getMessage(), f);
					model.addAttribute("errorMessage", "학생 정보 삽입 중 오류가 발생했습니다.");
					return "saa/student/student_view_update";
				}

				scoreNumber++; // 점수 번호 증가 (다음 과목을 위해)
			}
		}

		// 삽입이 완료되면 창을 닫는 자바스크립트 호출
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("if (window.opener) {");
		out.println("  window.opener.location.reload();"); // 부모 창 새로고침
		out.println("  window.close();"); // 현재 창 닫기
		out.println("}");
		out.println("</script>");
		out.flush();

		return null; // 뷰를 반환하지 않고 바로 응답 처리
	}

	@RequestMapping(value = "/student/score_edit.do")
	public String editScore(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 성적 수정");

		String studentGrade = request.getParameter("grade");
		String studentId = request.getParameter("studentId");
		String semester = request.getParameter("semester");
		String scoreDivion = request.getParameter("scoreDivion");
		LOGGER.info("학생 성적 등록");
		String[] scoreIdList = request.getParameter("scoreIds").split(",");
		LOGGER.info("학생 성적 등록");

		LOGGER.info("학생 성적 수정" + Arrays.toString(scoreIdList));
		EgovMap subjectMap = new EgovMap(); // 과목 조회
		subjectMap.put("studentGrade", studentGrade);
		subjectMap.put("studentId", studentId);
		EgovMap viewMap = new EgovMap();
		viewMap.put("studentId", studentId);
		EgovMap scoreMap = new EgovMap(); // 성적
		scoreMap.put("studentId", studentId);
		scoreMap.put("studentGrade", studentGrade);
		scoreMap.put("semester", semester);
		scoreMap.put("scoreDivion", scoreDivion);

		try {
			LOGGER.info("studentId: " + studentId); // studentId 값을 로깅
			EgovMap studentView = studentService.studentView(viewMap);
			List<EgovMap> studentSubject = studentService.selectStudentSubject(subjectMap);
			List<EgovMap> studentScore = studentService.selectStudentScore3(scoreMap);

			// subjects나 score에 있는 subjectId가 제대로 문자열로 처리되는지 확인

			model.addAttribute("studentScore", studentScore);
			model.addAttribute("studentView", studentView);
			model.addAttribute("studentSubject", studentSubject);
		} catch (RuntimeException e) {
			LOGGER.error("실행중 학생 정보 조회 실패: " + e.getMessage(), e);
			model.addAttribute("errorMessage", "학생 정보 조회 중 오류가 발생했습니다.");
			return "saa/student/student_view_update"; // 오류가 발생한 경우 상세 페이지로 돌아가기
		} catch (Exception f) {
			LOGGER.error("학생 정보 조회 실패: " + f.getMessage(), f);
			model.addAttribute("errorMessage", "학생 정보 조회 중 오류가 발생했습니다.");
			return "saa/student/student_view_update";
		}

		return "saa/student/score_edit"; // 성적 입력 페이지로 이동
	}

	@RequestMapping(value = "/student/score_edit_proc.do")
	public String updateScoreProc(ModelMap model, HttpServletRequest request, HttpServletResponse response)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("점수 수정 처리");

		EgovMap scoreMap = new EgovMap();
		String studentId = request.getParameter("studentId");
		String grade = request.getParameter("grade");
		String semester = request.getParameter("semester");
		String scoreYear = request.getParameter("score_year");
		String scoreDivion = request.getParameter("score_divion");

		LOGGER.info("Student ID: " + studentId);
		LOGGER.info("Semester: " + semester);
		LOGGER.info("grade: " + grade);
		LOGGER.info("scoreYear: " + scoreYear);
		LOGGER.info("scoreDivision: " + scoreDivion);
		EgovMap subjectMap = new EgovMap(); // 과목 조회
		subjectMap.put("studentGrade", grade);
		subjectMap.put("studentId", studentId);
		// scoreIds 가져오기 및 빈 값 예외 처리
		String[] scoreIdList = request.getParameter("scoreIds").split(",");
		Arrays.sort(scoreIdList);
		if (scoreIdList == null || scoreIdList.length == 0 || scoreIdList[0].isEmpty()) {
			LOGGER.error("scoreIds가 비어 있습니다.");
			model.addAttribute("errorMessage", "점수 아이디가 비어 있습니다.");
			return "saa/student/score_input"; // 오류 페이지로 돌아가기
		}
		LOGGER.info("scoresId: " + Arrays.toString(scoreIdList));

		// 학년별로 과목 ID 설정

		List<EgovMap> studentSubject = studentService.selectStudentSubject(subjectMap);
		// 예시 코드에서 EgovMap에 담긴 필드명이 올바르게 설정되어 있는지 확인
		String[] subjectIds = studentSubject.stream().map(student -> (String) student.get("subjectId"))
				.toArray(String[]::new);

		// 디버깅용으로 조회된 각 EgovMap 객체를 출력하여 확인

		LOGGER.info("subjectIds: " + Arrays.toString(subjectIds));
		// 점수 파라미터 처리 및 반복적인 삽입
		for (int i = 0; i < subjectIds.length; i++) {
			String subjectId = subjectIds[i];
			String scoreId = scoreIdList[i];
			String scoreParam = request.getParameter("score_" + subjectId);

			if (scoreParam != null && !scoreParam.isEmpty()) {
				scoreMap.put("studentId", studentId);
				scoreMap.put("semester", semester);
				scoreMap.put("scoreYear", scoreYear);
				scoreMap.put("scoreDivion", scoreDivion);
				scoreMap.put("subjectId", subjectId);
				scoreMap.put("scoreId", scoreId);
				scoreMap.put("score", scoreParam);

				try {
					studentService.updateScore(scoreMap);
					LOGGER.info("과목 " + subjectId + "에 대한 점수 수정 성공");
				} catch (RuntimeException e) {
					LOGGER.error("실행중 과목 " + subjectId + "에 대한 점수 수정 실패: " + e.getMessage(), e);
					model.addAttribute("errorMessage", "과목 " + subjectId + " 점수 삽입 중 오류가 발생했습니다.");
					return "saa/student/score_input"; // 오류 페이지로 돌아가기
				} catch (Exception f) {
					LOGGER.error("학생 점수 수정 실패: " + f.getMessage(), f);
					model.addAttribute("errorMessage", "학생 점수 수정 중 오류가 발생했습니다.");
					return "saa/student/student_view_update";
				}
			}
		}

		// 수정 완료 후 알림 및 창 닫기
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println("<script type='text/javascript'>");
		out.println("if (window.opener) {");
		out.println("  window.opener.location.reload();");
		out.println("  window.close();");
		out.println("}");
		out.println("</script>");
		out.flush();

		return null;
	}

	@RequestMapping(value = "/student/student_view_input.do")
	public String inputStudentView(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 정보 등록");

		String studentId = request.getParameter("studentId");

		model.addAttribute("studentView", studentId);
		return "saa/student/student_view_input";
	}

	@RequestMapping(value = "/student/student_view_input_proc.do")
	public String inputStudentViewProc(ModelMap model, HttpServletRequest request)
			throws DataAccessException, RuntimeException, IOException, SQLException {
		LOGGER.info("학생 정보 수정 처리");

		EgovMap egovMap = new EgovMap();
		String studentId = request.getParameter("student_id");
		String studentName = request.getParameter("student_name");
		String phoneNumber = request.getParameter("phone_number");
		String residentRegistrationNumber = request.getParameter("resident_registration_number");
		String address = request.getParameter("address");
		String birthDate = request.getParameter("birth_date");
		String emergencyPhoneNumber = request.getParameter("emergency_phone_number");

		egovMap.put("studentId", studentId);
		egovMap.put("studentName", studentName);
		egovMap.put("phoneNumber", phoneNumber);
		egovMap.put("residentRegistrationNumber", residentRegistrationNumber);
		egovMap.put("address", address);
		egovMap.put("birthDate", birthDate);
		egovMap.put("emergencyPhoneNumber", emergencyPhoneNumber);

		LOGGER.info("egovMap ::: " + egovMap);

		try {
			studentService.insertStudentView(egovMap);
			LOGGER.info("학생 정보 수정 성공");
		} catch (RuntimeException e) {
			LOGGER.error("실행중 학생 정보 수정 실패: " + e.getMessage(), e);
			model.addAttribute("errorMessage", "학생 정보 수정 중 오류가 발생했습니다.");
			return "saa/student/student_view_update";
		} catch (Exception f) {
			LOGGER.error("학생 정보 수정 실패: " + f.getMessage(), f);
			model.addAttribute("errorMessage", "학생 정보 수정 중 오류가 발생했습니다.");
			return "saa/student/student_view_update";
		}

		return "redirect:./student_list.do"; // 성공적으로 등록된 후 학생 목록 페이지로 리다이렉트
	}

	@RequestMapping(value= "/student/upload_show.do")
	public String showUploadPage() {
		LOGGER.info("업로드페이지 실행");
		return "saa/student/upload";
	}

	@RequestMapping(value = "/student/upload.do")
	public String uploadFile(@RequestParam("file") MultipartFile file, Model model) {
		if (file.isEmpty()) {
			model.addAttribute("message", "파일을 선택하지 않았습니다.");
			return "saa/student/upload";
		}

		try {
			String uploadDir = "C:/uploads/"; // 파일 저장 경로
			File destinationFile = new File(uploadDir + file.getOriginalFilename());
			file.transferTo(destinationFile);
			model.addAttribute("message", "파일 업로드 성공: " + file.getOriginalFilename());
		} catch (RuntimeException e) {
			e.printStackTrace();
			model.addAttribute("message", "실행중파일 업로드 실패.");
			return "saa/student/upload";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("message", "파일 업로드 실패.");
			return "saa/student/upload";
		}

		return "saa/student/sucsess";
	}

	@RequestMapping(value= "/student/file_show.do")
	public String showFileListPage() {
		LOGGER.info("업로드 파일 리스트 페이지 실행");
		return "saa/student/file_list";
	}
	private static final String UPLOAD_DIR = "C:/uploads/";

	@RequestMapping(value= "/student/download.do")
    public ResponseEntity<FileSystemResource> downloadFile(@RequestParam("fileName") String fileName) {
        try {
            // 파일 객체 생성
            File file = new File(UPLOAD_DIR + fileName);
            if (!file.exists()) {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
            }

            // 파일 리소스를 가져옴
            FileSystemResource resource = new FileSystemResource(file);

            // 파일 이름을 브라우저에 맞게 인코딩
            String encodedFileName = URLEncoder.encode(fileName, "UTF-8").replace("+", "%20");

            // HTTP 헤더 설정
            HttpHeaders headers = new HttpHeaders();
            headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + encodedFileName + "\"");
            headers.add(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()));

            return ResponseEntity.ok()
                    .headers(headers)
                    .body(resource);
        } catch (UnsupportedEncodingException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
        }
    }

    @RequestMapping(value = "/student/getSubjectsByGrade.do", method = RequestMethod.GET)
    @ResponseBody
    public List<EgovMap> getSubjectsByGrade(@RequestParam("grade") String grade) {
        LOGGER.info("학년별 과목 목록 조회: " + grade);

        EgovMap subjectMap = new EgovMap();
        subjectMap.put("studentGrade", grade);

        try {
            // 학년에 따른 과목 목록을 가져오기
            List<EgovMap> subjects = studentService.selectStudentSubject(subjectMap);
            LOGGER.info("과목 목록 조회 성공: " + subjects);
            return subjects; // JSON 형식으로 반환됨
        } catch (Exception e) {
            LOGGER.error("과목 목록 조회 실패: " + e.getMessage(), e);
            return new ArrayList<>(); // 오류 시 빈 목록 반환
        }
    }

}
