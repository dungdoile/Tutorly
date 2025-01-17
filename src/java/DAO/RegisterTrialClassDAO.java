/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Config.EmailConfig;
import static Controller.RegisterTrialCotroller.getNearestDayOfWeek;
import Model.Learner;
import Model.RegisterTrialClass;
import Model.Session;
import Model.Subject;
import Model.Tutor;
import java.util.Vector;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author TRANG
 */
public class RegisterTrialClassDAO extends DBContext {

    UserDAO udao = new UserDAO();
    EmailConfig config = new EmailConfig();

    public int updateStatusWithSpecificCriteria(int tutorId, String session, int idAccept, String Date) {
        String sql = "UPDATE RegisterTrialClass SET status = 'denied' WHERE status = 'wait'  and tutorId = ? AND [session] = ? AND startDate = ? AND id <> ? ";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            state.setInt(1, tutorId);
            state.setString(2, session);
            state.setString(3, Date);
            state.setInt(4, idAccept);
            int rowsAffected = state.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Update successful. " + rowsAffected + " rows affected.");
                return rowsAffected;
            } else {
                System.out.println("No records found with the given criteria.");
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int sendEmailsForUpdatedRecords(int tutorId, String session, int idAccept, String Date) {
        String sql = "SELECT learnerId FROM RegisterTrialClass WHERE status = 'wait'  and tutorId = ? AND [session] = ? AND startDate = ? AND id <> ? ";
        int status = 0;
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            state.setInt(1, tutorId);
            state.setString(2, session);
            state.setString(3, Date);
            state.setInt(4, idAccept);
            ResultSet rs = state.executeQuery();

            while (rs.next()) {
                int learnerId = rs.getInt("learnerId");
                Learner learner = new LearnerDAO().getLearnerById(learnerId);
                String recipientEmail = udao.getUserById(learner.getId()).getEmail();
                String learnerName = learner.getName();
                config.MailDenyTrial("nguyenducanhqbz@gmail.com", learnerName);
                System.out.println("send succes :" + learnerId);
                status++;
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return status;
    }

    public Vector<RegisterTrialClass> displayAllTrialClasses() {
        Vector<RegisterTrialClass> vector = new Vector<>();
        String sql = "SELECT * FROM RegisterTrialClass";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int learnerId = rs.getInt("learnerId");
                int tutorId = rs.getInt("tutorId");
                int subjectId = rs.getInt("subjectId");
                String sessionId = rs.getString("session");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String readed = rs.getString("readed");

                Learner learner = new LearnerDAO().getLearnerById(learnerId);
                Tutor tutor = new TutorDAO().getTutorById(tutorId);
                Subject subject = new SubjectDAO().getSubjectById(subjectId);
                Session session = new SessionDAO().getSessionById(sessionId);

                RegisterTrialClass trialClass = new RegisterTrialClass(id, learner, tutor, session, totalSession, startDate, endDate, status, subject, readed);
                vector.add(trialClass);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public ArrayList<RegisterTrialClass> getTrialClassByTutorId(int id) {
        ArrayList<RegisterTrialClass> list = new ArrayList<>();
        String sql = "SELECT * FROM RegisterTrialClass WHERE tutorId = ?";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            state.setInt(1, id);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int idTRial = rs.getInt("id");
                int learnerId = rs.getInt("learnerId");
                int tutorId = rs.getInt("tutorId");
                int subjectId = rs.getInt("subjectId");
                String sessionId = rs.getString("session");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String readed = rs.getString("readed");

                Learner learner = new LearnerDAO().getLearnerById(learnerId);
                Tutor tutor = new TutorDAO().getTutorById(tutorId);
                Subject subject = new SubjectDAO().getSubjectById(subjectId);
                Session session = new SessionDAO().getSessionById(sessionId);
                list.add(new RegisterTrialClass(idTRial, learner, tutor, session, totalSession, startDate, endDate, status, subject, readed));

            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public RegisterTrialClass getTrialClassById(int id) {
        String sql = "SELECT * FROM RegisterTrialClass WHERE id = ?";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            state.setInt(1, id);
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                int learnerId = rs.getInt("learnerId");
                int tutorId = rs.getInt("tutorId");
                int subjectId = rs.getInt("subjectId");
                String sessionId = rs.getString("session");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String readed = rs.getString("readed");

                Learner learner = new LearnerDAO().getLearnerById(learnerId);
                Tutor tutor = new TutorDAO().getTutorById(tutorId);
                Subject subject = new SubjectDAO().getSubjectById(subjectId);
                Session session = new SessionDAO().getSessionById(sessionId);

                return new RegisterTrialClass(id, learner, tutor, session, totalSession, startDate, endDate, status, subject, readed);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public int addTrialClass(RegisterTrialClass trialClass) {
        String sql = "INSERT INTO RegisterTrialClass (learnerId, tutorId, subjectId, session, totalSession, startDate, endDate, status, readed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, trialClass.getLearner().getId());
            pre.setInt(2, trialClass.getTutor().getId());
            pre.setInt(3, trialClass.getSubject().getId());
            pre.setString(4, trialClass.getSession().getId());
            pre.setInt(5, trialClass.getTotalSession());
            pre.setDate(6, new java.sql.Date(trialClass.getStartDate().getTime()));
            pre.setDate(7, new java.sql.Date(trialClass.getEndDate().getTime()));
            pre.setString(8, trialClass.getStatus());
            pre.setString(9, trialClass.getReaded());
            return pre.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int updateTrialClass(RegisterTrialClass trialClass) {
        String sql = "UPDATE RegisterTrialClass SET learnerId = ?, tutorId = ?, subjectId = ?, session = ?, totalSession = ?, startDate = ?, endDate = ?, status = ?, readed = ? WHERE id = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setInt(1, trialClass.getLearner().getId());
            pre.setInt(2, trialClass.getTutor().getId());
            pre.setInt(3, trialClass.getSubject().getId());
            pre.setString(4, trialClass.getSession().getId());
            pre.setInt(5, trialClass.getTotalSession());
            pre.setDate(6, new java.sql.Date(trialClass.getStartDate().getTime()));
            pre.setDate(7, new java.sql.Date(trialClass.getEndDate().getTime()));
            pre.setString(8, trialClass.getStatus());
            pre.setString(9, trialClass.getReaded());
            pre.setInt(10, trialClass.getId());
            return pre.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int removeTrialClass(int classId) {
        String sql = "DELETE FROM RegisterTrialClass WHERE id = ?";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            state.setInt(1, classId);
            return state.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public Vector<RegisterTrialClass> getTrialClassesByLearnerId(int learnerId) {
        Vector<RegisterTrialClass> vector = new Vector<>();
        String sql = "SELECT * FROM RegisterTrialClass WHERE learnerId = ?";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            state.setInt(1, learnerId);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int tutorId = rs.getInt("tutorId");
                int subjectId = rs.getInt("subjectId");
                String sessionId = rs.getString("session");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String readed = rs.getString("readed");

                Learner learner = new LearnerDAO().getLearnerById(learnerId);
                Tutor tutor = new TutorDAO().getTutorById(tutorId);
                Subject subject = new SubjectDAO().getSubjectById(subjectId);
                Session session = new SessionDAO().getSessionById(sessionId);

                RegisterTrialClass trialClass = new RegisterTrialClass(id, learner, tutor, session, totalSession, startDate, endDate, status, subject, readed);
                vector.add(trialClass);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public Vector<RegisterTrialClass> getTrialClassesByTutorId(int tutorId) {
        Vector<RegisterTrialClass> vector = new Vector<>();
        String sql = "SELECT * FROM RegisterTrialClass WHERE tutorId = ?";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            state.setInt(1, tutorId);
            ResultSet rs = state.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("id");
                int learnerId = rs.getInt("learnerId");
                int subjectId = rs.getInt("subjectId");
                String sessionId = rs.getString("session");
                int totalSession = rs.getInt("totalSession");
                Date startDate = rs.getDate("startDate");
                Date endDate = rs.getDate("endDate");
                String status = rs.getString("status");
                String readed = rs.getString("readed");

                Learner learner = new LearnerDAO().getLearnerById(learnerId);
                Tutor tutor = new TutorDAO().getTutorById(tutorId);
                Subject subject = new SubjectDAO().getSubjectById(subjectId);
                Session session = new SessionDAO().getSessionById(sessionId);

                RegisterTrialClass trialclass = new RegisterTrialClass(id, learner, tutor, session, totalSession, startDate, endDate, status, subject, readed);
                vector.add(trialclass);

            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return vector;
    }

    public int getLatestTrialClassId() {
        String sql = "SELECT TOP 1 id FROM RegisterTrialClass ORDER BY id DESC";
        try (PreparedStatement state = connection.prepareStatement(sql)) {
            ResultSet rs = state.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");

            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int countTrialClassesByStatusAndLearner(String status, int learnerId) {
        String sql = "SELECT COUNT(*) AS count_class FROM RegisterTrialClass WHERE status = ? AND learnerId = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, status);
            pre.setInt(2, learnerId);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return rs.getInt("count_class");

            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public int updateTrialClassStatus(int classId, String newStatus) {
        String sql = "UPDATE RegisterTrialClass SET status = ? WHERE id = ?";
        try (PreparedStatement pre = connection.prepareStatement(sql)) {
            pre.setString(1, newStatus);
            pre.setInt(2, classId);
            return pre.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(RegisterTrialClassDAO.class
                    .getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public static void main(String[] args) {
        // Assume connection is established
        LearnerDAO lDAO = new LearnerDAO();
        LessonDAO lessonDAO = new LessonDAO();
        SessionDAO sDAO = new SessionDAO();
        Date today = new Date();
        TutorDAO tDAO = new TutorDAO();
        SubjectDAO sbDAO = new SubjectDAO();
        Session session = sDAO.getSessionById("M2");
        Tutor tutor = tDAO.getTutorById(8);
        RegisterTrialClassDAO trialClassDAO = new RegisterTrialClassDAO();
        int result = trialClassDAO.updateStatusWithSpecificCriteria(10, "SU5", 42, "2024-07-28");
        System.out.println("Update result: " + result);
//        RegisterTrialClass rClass = new RegisterTrialClass(
//                lDAO.getLearnerById(1),
//                tutor,
//                session,
//                1,
//                getNearestDayOfWeek(today, sDAO.getSessionById("M2").getDayOfWeek()),
//                getNearestDayOfWeek(today, sDAO.getSessionById("M2").getDayOfWeek()),
//                "wait",
//                tutor.getSubject(),
//                "unreaded"
//        );
//        trialClassDAO.addTrialClass(rClass);
//        // Example: Get trial classes by learner ID
//
//        Vector<RegisterTrialClass> trialClasses = trialClassDAO.getTrialClassesByTutorId(7);
//        System.out.println(trialClasses.size());
//        System.out.println(trialClassDAO.getTrialClasswithDateAndId());
    }
}
