/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.AClass;
import Model.Learner;
import Model.Subject;
import Model.Tutor;
import java.util.Date;
import java.util.Vector;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TRANG
 */
public class AClassDAO extends DBContext {

    TutorDAO tutordao = new TutorDAO();
    SubjectDAO sdao = new SubjectDAO();

    public Vector<AClass> displayAllClasses() {
        Vector<AClass> vector = new Vector<>();
        String sql = "SELECT * FROM Class";
        try {
            PreparedStatement state = connection.prepareStatement(sql);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int learnerId = rs.getInt("learnerId");
                int tutorId = rs.getInt("tutorId");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");

                Learner learner = new LearnerDAO().getStudentById(learnerId); // Assuming LearnerDAO is implemented
                Tutor tutor = new TutorDAO().getTutorById(tutorId); // Assuming TutorDAO is implemented

                AClass aClass = new AClass(learner, tutor, totalSession, startDate, endDate, status);
                aClass.setId(id);
                vector.add(aClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    // Method to get a class by ID
    public AClass getClassById(int id) {
        String sql = "SELECT * FROM Class WHERE id = ?";
        try {
            PreparedStatement state = connection.prepareStatement(sql);
            state.setInt(1, id);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                int idCLass = rs.getInt("id");
                int learnerId = rs.getInt("learnerId");
                int tutorId = rs.getInt("tutorId");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                int subjectId = rs.getInt("subjectId");
                System.out.println(subjectId);
                Subject subject = sdao.getSubjectById(subjectId);
                Learner learner = new LearnerDAO().getStudentById(learnerId); // Assuming LearnerDAO is implemented
                Tutor tutor = tutordao.getTutorById(tutorId); // Assuming TutorDAO is implemented

                AClass aClass = new AClass(learner, tutor, totalSession, startDate, endDate, status, subject);
                aClass.setId(idCLass);
                System.out.println(aClass.getSubject());
                return aClass;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public AClassDAO() {
    }

    // Method to add a new class
    public int addClass(AClass aClass) {
        int n = 0;
        String sql = "INSERT INTO Class (learnerId, subjectId, tutorId, totalSession, startDate, endDate, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pre = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pre.setInt(1, aClass.getLearner().getId());
            pre.setInt(2, aClass.getSubject().getId());
            pre.setInt(3, aClass.getTutor().getId());
            pre.setInt(4, aClass.getTotalSession());
            pre.setDate(5, new java.sql.Date(aClass.getStartDate().getTime()));
            pre.setDate(6, new java.sql.Date(aClass.getEndDate().getTime()));
            pre.setString(7, aClass.getStatus());
            n = pre.executeUpdate();

            // If you need to retrieve the generated key (id) after insert
            try (ResultSet generatedKeys = pre.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    n = generatedKeys.getInt(1); // Assuming the id is the first column in the generated keys
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    // Method to update a class
    public int updateClass(AClass aClass) {
        int n = 0;
        String sql = "UPDATE Class SET learnerId = ?, tutorId = ?, totalSession = ?, startDate = ?, endDate = ?, status = ? WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, aClass.getLearner().getId());
            pre.setInt(2, aClass.getTutor().getId());
            pre.setInt(3, aClass.getTotalSession());
            pre.setDate(4, new java.sql.Date(aClass.getStartDate().getTime()));
            pre.setDate(5, new java.sql.Date(aClass.getEndDate().getTime()));
            pre.setString(6, aClass.getStatus());
            pre.setInt(7, aClass.getId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int UpdateStatusClass(String status, int id) {
        String sql = "UPDATE [dbo].[Class] SET [status] = ? WHERE id = ?";
        int rowsUpdated = 0;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            rowsUpdated = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rowsUpdated;
    }

    // Method to delete a class
    public int removeClass(int classId) {
        int n = 0;
        String sql = "DELETE FROM Class WHERE id = ?";
        try {
            PreparedStatement state = connection.prepareStatement(sql);
            state.setInt(1, classId);
            n = state.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public Vector<AClass> getClassesByLearnerId(int learnerId) {
        Vector<AClass> vector = new Vector<>();
        String sql = "SELECT * FROM Class WHERE learnerId = ?";
        try {
            PreparedStatement state = connection.prepareStatement(sql);
            state.setInt(1, learnerId);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int tutorId = rs.getInt("tutorId");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");

                Learner learner = new LearnerDAO().getStudentById(learnerId); // Assuming LearnerDAO is implemented
                Tutor tutor = new TutorDAO().getTutorById(tutorId); // Assuming TutorDAO is implemented

                AClass aClass = new AClass(learner, tutor, totalSession, startDate, endDate, status);
                aClass.setId(id);
                vector.add(aClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public int getLatestClassId() {
        String sql = "SELECT TOP 1 id FROM Class ORDER BY id DESC";
        try {
            PreparedStatement state = connection.prepareStatement(sql);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int countClassByStatus(String status, int id) {
        int n = 0;
        String sql = "Select count(*) as count_class from class where status = ? and tutorId = ? ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, status);
            pre.setInt(2, id);

            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                n = rs.getInt("count_class");
                return n;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int countClassByStatusLearner(String status, int id) {
        int n = 0;
        String sql = "Select count(*) as count_class from class where status = ? and learnerId = ? ";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, status);
            pre.setInt(2, id);

            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                n = rs.getInt("count_class");
                return n;
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public Vector<AClass> getClassesByTutorId(int tutorId) {
        Vector<AClass> classes = new Vector<>();
        LearnerDAO lDao = new LearnerDAO();
        TutorDAO tDao = new TutorDAO();
        SubjectDAO sDao = new SubjectDAO();
        String sql = "SELECT c.id, c.learnerId, c.totalSession, c.startDate, c.endDate, c.status "
                + "FROM Class c "
                + "WHERE c.tutorId = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, tutorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AClass aClass = new AClass();
                aClass.setId(rs.getInt("id"));
                aClass.setLearner(lDao.getLearnerById(rs.getInt("learnerId")));
                aClass.setTutor(tDao.getTutorById(tutorId));
//                aClass.setSubject(sDao.getSubjectById(rs.getInt("subjectId")));
                aClass.setStatus(rs.getString("status"));
                aClass.setTotalSession(rs.getInt("totalSession"));
                aClass.setStartDate(rs.getDate("startDate"));
                aClass.setEndDate(rs.getDate("endDate"));

                classes.add(aClass);
            }
        } catch (SQLException e) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return classes;
    }

    public Vector<AClass> getClassesBySTudentId(int studentId) {
        Vector<AClass> classes = new Vector<>();
        LearnerDAO lDao = new LearnerDAO();
        TutorDAO tDao = new TutorDAO();
        SubjectDAO sDao = new SubjectDAO();
        String sql = """
                    SELECT c.id, c.learnerId, c.tutorId, c.totalSession, c.startDate  
                      FROM Class c    
                      WHERE c.learnerId = ?""";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, studentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AClass aClass = new AClass();
                aClass.setId(rs.getInt("id"));
                aClass.setLearner(lDao.getLearnerById(rs.getInt("learnerId")));
                aClass.setTutor(tDao.getTutorById(rs.getInt("tutorId")));
//                aClass.setSubject(sDao.getSubjectById(rs.getInt("subjectId")));
                aClass.setTotalSession(rs.getInt("totalSession"));
                aClass.setStartDate(rs.getDate("startDate"));

                classes.add(aClass);
            }
        } catch (SQLException e) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return classes;
    }

    public int getFinishedSessions(int classId) {
        int finishedSessions = 0;
        String sql = "SELECT COUNT(*) AS finishedSessions FROM Lesson WHERE classId = ? AND status = 'Finished'";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, classId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                finishedSessions = rs.getInt("finishedSessions");
            }
        } catch (SQLException e) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return finishedSessions;
    }

    public int updateClassStatus(int classId, String newStatus) {
        int n = 0;
        String sql = "UPDATE Class SET status = ? WHERE id = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, newStatus);
            pre.setInt(2, classId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;

    }

    public Vector<AClass> getClassesByLearnerIdAndStatus(int learnerId, String status) {
        Vector<AClass> vector = new Vector<>();
        String sql = "SELECT * FROM Class WHERE learnerId = ? AND status = ?";
        try {
            PreparedStatement state = connection.prepareStatement(sql);
            state.setInt(1, learnerId);
            state.setString(2, status);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int tutorId = rs.getInt("tutorId");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");

                Learner learner = new LearnerDAO().getStudentById(learnerId); // Assuming LearnerDAO is implemented
                Tutor tutor = new TutorDAO().getTutorById(tutorId); // Assuming TutorDAO is implemented

                AClass aClass = new AClass(learner, tutor, totalSession, startDate, endDate, status);
                aClass.setId(id);
                vector.add(aClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;

    }

    public Vector<AClass> getClassesByTutorIdAndStatus(int tutorId, String status) {
        Vector<AClass> vector = new Vector<>();
        String sql = "SELECT * FROM Class WHERE tutorId = ? AND status = ?";
        try {
            PreparedStatement state = connection.prepareStatement(sql);
            state.setInt(1, tutorId);
            state.setString(2, status);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int learnerId = rs.getInt("learnerId");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");

                Learner learner = new LearnerDAO().getStudentById(learnerId); // Assuming LearnerDAO is implemented
                Tutor tutor = new TutorDAO().getTutorById(tutorId); // Assuming TutorDAO is implemented

                AClass aClass = new AClass(learner, tutor, totalSession, startDate, endDate, status);
                aClass.setId(id);
                vector.add(aClass);
            }
        } catch (SQLException ex) {
            Logger.getLogger(AClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return vector;

    }

    public static void main(String[] args) {
        AClassDAO dao = new AClassDAO();
        System.out.println(dao.getClassById(15).getSubject());
    }
}
