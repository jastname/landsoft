package egovframework.saa.module.student.service;

import java.sql.SQLException;
import java.util.List;

import org.egovframe.rte.psl.dataaccess.util.EgovMap;

public interface StudentService {

    List<EgovMap> selectStudentList(EgovMap paramMap) throws SQLException;

    // 학생 등록 메서드 추가
    void insertStudent(EgovMap studentData) throws SQLException;


    EgovMap studentView(EgovMap paramMap) throws SQLException;

    int getTotalStudentCount();

    List<EgovMap> selectStudentScore(EgovMap paramMap) throws SQLException;

    List<EgovMap> selectStudentScore2(EgovMap paramMap) throws SQLException;

    List<EgovMap> selectStudentScore3(EgovMap paramMap) throws SQLException;

    void updateStudentView(EgovMap paramMap) throws SQLException;

    void deleteStudent(EgovMap paramMap) throws SQLException;

    List<EgovMap> selectStudentSubject(EgovMap paramMap) throws SQLException;

    List<EgovMap> selectStudentRank(EgovMap paramMap) throws SQLException;

    void insertScore(EgovMap studentData) throws SQLException;

    int countScore();

    void updateScore(EgovMap paramMap) throws SQLException;

    void insertStudentView (EgovMap paramMap) throws SQLException;
}
