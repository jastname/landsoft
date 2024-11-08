package egovframework.saa.module.student.service.impl;

import java.sql.SQLException;
import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

import egovframework.saa.module.student.service.StudentService;

@Service("studentService")
public class StudentServiceImpl extends EgovAbstractServiceImpl implements StudentService {

    @Resource(name = "studentMapper")
    private StudentMapper studentMapper;

    public List<EgovMap> selectStudentList(EgovMap paramMap) throws DataAccessException, SQLException {
        return studentMapper.selectStudentList(paramMap);
    }

    public void insertStudent(EgovMap studentData) throws DataAccessException, SQLException {
        studentMapper.insertStudent(studentData);
    }

    public EgovMap studentView(EgovMap paramMap) throws DataAccessException, SQLException {
        return studentMapper.selectStudentView(paramMap);
    }

    @Override
    public int getTotalStudentCount() {
        return studentMapper.countStudents(); // 매퍼 메서드 호출
    }

    public List<EgovMap> selectStudentScore(EgovMap paramMap) throws DataAccessException, SQLException {
        return studentMapper.selectStudentScore(paramMap);
    }
    public List<EgovMap> selectStudentScore2(EgovMap paramMap) throws DataAccessException, SQLException {
        return studentMapper.selectStudentScore2(paramMap);
    }
    public List<EgovMap> selectStudentScore3(EgovMap paramMap) throws DataAccessException, SQLException {
    	return studentMapper.selectStudentScore3(paramMap);
    }

    public void updateStudentView(EgovMap paramMap) throws DataAccessException, SQLException {
        studentMapper.updateStudentView(paramMap);
    }

    public void deleteStudent(EgovMap paramMap) throws DataAccessException, SQLException {
    	studentMapper.deleteStudent(paramMap);
    }

    public List<EgovMap> selectStudentSubject(EgovMap paramMap) throws DataAccessException, SQLException {
        return studentMapper.selectStudentSubject(paramMap);
    }
    public List<EgovMap> selectStudentRank(EgovMap paramMap) throws DataAccessException, SQLException {
    	return studentMapper.selectStudentRank(paramMap);
    }

    public void insertScore(EgovMap studentData) throws DataAccessException, SQLException {
        studentMapper.insertScore(studentData);
    }

    public int countScore() {
        return studentMapper.countScore(); // 매퍼 메서드 호출
    }


    public void updateScore(EgovMap paramMap) throws DataAccessException, SQLException {
        studentMapper.updateScore(paramMap);
    }

    public void insertStudentView(EgovMap paramMap) throws DataAccessException, SQLException {
        studentMapper.insertStudentView(paramMap);
    }
}