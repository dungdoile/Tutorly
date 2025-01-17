--CREATE DATABASE Tutorly;
GO
--drop database Tutorly

--go
--use Tutorly
--drop database Tutorly
CREATE TABLE [User] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    [password] VARCHAR(255) NOT NULL,
    [role] VARCHAR(50) NOT NULL,
    createdAt DATETIME DEFAULT GETDATE()
);


CREATE TABLE Learner (
    id INT PRIMARY KEY,
    [name] NVARCHAR(255) NOT NULL,
    image VARCHAR(255)
);


CREATE TABLE [Subject] (
    id INT IDENTITY(1,1) PRIMARY KEY,
    [name] NVARCHAR(255) NOT NULL
);

CREATE TABLE Tutor (
    id INT PRIMARY KEY,
    subjectId INT,
    [name] NVARCHAR(255) NOT NULL,
    gender BIT,
    [image] VARCHAR(255),
    bio NTEXT,
    edu NVARCHAR(255),
    price FLOAT,
    bank VARCHAR(255),
    [status] VARCHAR(50),
	Linkmeet nvarchar(100),
	FOREIGN KEY (subjectId) REFERENCES [Subject](id)
);

CREATE TABLE Manager (
	id INT PRIMARY KEY,
	[name] NVARCHAR(255) NOT NULL,
	approvedTutor INT,
	rejectedTutor INT,
	blockedTutor INT,
	[status] VARCHAR(50) --update & noupdate
);

CREATE TABLE ManageTutor (
	id INT IDENTITY(1,1) PRIMARY KEY,
	tutorId INT,
	managerId INT,
	[status] VARCHAR(50), --approve, reject, blocked
	updatedAt DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (tutorId) REFERENCES Tutor(id),
	FOREIGN KEY (managerId) REFERENCES Manager(id)
);

CREATE TABLE [Certificate] (
	id INT IDENTITY(1,1) PRIMARY KEY,
	tutorId INT,
	[image] VARCHAR(255),
	FOREIGN KEY (tutorId) REFERENCES Tutor(id)
);


CREATE TABLE Rating (
    id INT IDENTITY(1,1) PRIMARY KEY,
	learnerId INT,
    tutorId INT,
    rating INT,
    review NVARCHAR(255),
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (tutorId) REFERENCES Tutor(id),
    FOREIGN KEY (learnerId) REFERENCES Learner(id)
);

CREATE TABLE SavedTutor (
	id INT IDENTITY(1,1) PRIMARY KEY,
	learnerId INT,
    tutorId INT,
	FOREIGN KEY (tutorId) REFERENCES Tutor(id),
    FOREIGN KEY (learnerId) REFERENCES Learner(id)
);
CREATE TABLE Income (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    tax FLOAT,
    amount FLOAT,
	Total as amount-(tax*amount),
    createdAt DATETIME DEFAULT GETDATE(),
	DayPaid DATETIME,
    [status] VARCHAR(20),
    tutorID INT,
    FOREIGN KEY (tutorID) REFERENCES Tutor(id)
);

CREATE TABLE Class (
    id INT IDENTITY(1,1) PRIMARY KEY,
    learnerId INT,
    tutorId INT,
	subjectId INT,
    totalSession INT,
    startDate DATE,
    endDate DATE,
    [status] VARCHAR(50), --ongoing, finished, trial
    FOREIGN KEY (learnerId) REFERENCES Learner(id),
    FOREIGN KEY (tutorId) REFERENCES Tutor(id)
);

CREATE TABLE [Session] (
    id VARCHAR(10) PRIMARY KEY,
    startTime TIME,
    endTime TIME,
    [dayOfWeek] VARCHAR(50)
);

CREATE TABLE lesson (
    id INT IDENTITY(1,1) PRIMARY KEY,
    classId INT,
    sessionId VARCHAR(10),
    [date] DATE,
    [status] VARCHAR(50),
    FOREIGN KEY (classId) REFERENCES Class(id),
    FOREIGN KEY (sessionId) REFERENCES [Session](id)
);

CREATE TABLE TutorAvailability (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tutorId INT,
    sessionId VARCHAR(10),
	[status] VARCHAR(50),
    FOREIGN KEY (tutorId) REFERENCES Tutor(id),
    FOREIGN KEY (sessionId) REFERENCES [Session](id)
);

CREATE TABLE Payment (
    id INT IDENTITY(1,1) PRIMARY KEY,
    classId INT,
    amount REAL,
    [date] date,
    FOREIGN KEY (classId) REFERENCES Class(id)
);

CREATE TABLE Quiz (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
    lessonId INT,
    [fileName] NVARCHAR(255),
    filePath VARCHAR(255),
    score FLOAT,
    [status] VARCHAR(20),
    createdAt DATETIME DEFAULT GETDATE(),
    timeOfQuiz INT,
    startedOn DATETIME,
    completedOn DATETIME,
    timeTaken INT,
    numberOfTimeDone INT DEFAULT 0,
    FOREIGN KEY (lessonId) REFERENCES Lesson(id)
);
CREATE TABLE Question (
    quizId BIGINT,
    questionNumber INT,
    questionText VARCHAR(255),
    answerA VARCHAR(100),
    answerB VARCHAR(100),
    answerC VARCHAR(100),
    answerD VARCHAR(100),
    correctAnswer VARCHAR(100),
    chooseAnswer VARCHAR(100),
    PRIMARY KEY (quizId, questionNumber),
    FOREIGN KEY (quizId) REFERENCES Quiz(id)
);
CREATE TABLE Assignment (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
	lessonId INT,
    [fileName] NVARCHAR(255),
    filePath VARCHAR(255),
	score FLOAT,
	[status] VARCHAR(20),
    createdAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (lessonId) REFERENCES lesson(id)
);
CREATE TABLE Material (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
	lessonId INT,
    [fileName] NVARCHAR(255),
    filePath varBinary(max),
    fileType VARCHAR(50),
    uploadedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (lessonId) REFERENCES lesson(id)
);
CREATE TABLE Video (
    id BIGINT IDENTITY(1,1) PRIMARY KEY,
	lessonId INT,
    [fileName] NVARCHAR(255),
    filePath nvarchar(255),
    fileType VARCHAR(50),
    uploadedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (lessonId) REFERENCES lesson(id)
);
CREATE TABLE RegisterTrialClass (
    id INT IDENTITY(1,1) PRIMARY KEY,
    learnerId INT,
    tutorId INT,
    subjectId INT,
    session VARCHAR(50),
    totalSession INT,
    startDate DATE,
    endDate DATE,
    status VARCHAR(50), --wait, accepted, denied
    readed VARCHAR(50), -- read, unread
    FOREIGN KEY (learnerId) REFERENCES Learner(id),
    FOREIGN KEY (tutorId) REFERENCES Tutor(id),
    FOREIGN KEY (subjectId) REFERENCES Subject(id)
);

CREATE TABLE Transactions (
    id INT IDENTITY(1,1) PRIMARY KEY,
    userId INT NOT NULL,
    transactionDate DATETIME NOT NULL,
    amount int NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    transaction_type VARCHAR(50) NOT NULL,
    status VARCHAR(50) NOT NULL,
    description TEXT,
    FOREIGN KEY (userId) REFERENCES [User](id)
);


-- Insert into User table
INSERT INTO [User] (email, [password], [role], createdAt)
VALUES 
('learner1@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'learner', GETDATE()), --Password = 1
('learner2@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'learner', GETDATE()),--Password = 1 
('learner3@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'learner', GETDATE()),--Password = 1
('learner4@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'learner', GETDATE()),--Password = 1
('learner5@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'learner', GETDATE()),--Password = 1
('learner6@gmail.com', 'c4ca4238a0b923820dcc509a6f75849b', 'learner', GETDATE()),--Password = 1
('tutor1@example.com', 'c81e728d9d4c2f636f067f89cc14862c', 'tutor', GETDATE()),--Password = 2
('tutor2@example.com', 'c81e728d9d4c2f636f067f89cc14862c', 'tutor', GETDATE()),--Password = 2
('tutor3@example.com', 'c81e728d9d4c2f636f067f89cc14862c', 'tutor', GETDATE()),--Password = 2
('tutor4@example.com', 'c81e728d9d4c2f636f067f89cc14862c', 'tutor', GETDATE()),--Password = 2
('tutor5@example.com', 'c81e728d9d4c2f636f067f89cc14862c', 'tutor', GETDATE()),--Password = 2
('tutor6@example.com', 'c81e728d9d4c2f636f067f89cc14862c', 'tutor', GETDATE()),--Password = 2
('manager1@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()),
('manager2@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()),
('manager3@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()), 
('manager4@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()),
('manager5@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()),
('manager6@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()),
('manager7@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()),
('manager8@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'manager', GETDATE()), 
('admin1@example.com', 'eccbc87e4b5ce2fe28308fd9f2a7baf3', 'admin', GETDATE());--Password = 3


-- Insert into Manager table
INSERT INTO Manager (id, [name], approvedTutor, rejectedTutor, blockedTutor, [status])
VALUES
(13, 'Manager 1', 0, 0, 0, 'noUpdate'),
(14, 'Manager 2', 0, 0, 0, 'noUpdate'),
(15, 'Manager 3', 0, 0, 0, 'noUpdate'),
(16, 'Manager 4', 0, 0, 0, 'noUpdate'),
(17, 'Manager 5', 0, 0, 0, 'noUpdate'),
(18, 'Manager 6', 0, 0, 0, 'noUpdate'),
(19, 'Manager 7', 0, 0, 0, 'noUpdate'),
(20, 'Manager 8', 0, 0, 0, 'noUpdate'); 


-- Insert into Learner table
INSERT INTO Learner (id, [name], [image])
VALUES 
(1, N'Nam Nguyễn', 'learner1.jpg'),
(2, N'Trang Trần', 'learner2.jpg'),
(3, N'Đức Anh', 'learner3.jpg'),
(4, N'Lê Dũng', 'learner4.jpg'),
(5, N'Tiến Dũng', 'learner5.jpg'),
(6, N'Tùng Dương', 'learner6.jpg')

-- Insert into Subject table
INSERT INTO Subject ([name])
VALUES 
(N'Maths 10'),
(N'Maths 11'),
(N'Maths 12'),
(N'Physics 10'),
(N'Physics 11'),
(N'Physics 12'),
(N'Chemistry 10'),
(N'Chemistry 11'),
(N'Chemistry 12'),
(N'English 10'),
(N'English 11'),
(N'English 12'),
(N'Literature 10'),
(N'Literature 11'),
(N'Literature 12')
-- Insert into Tutor table
	INSERT INTO Tutor (id, subjectId, [name], gender, [image], bio, edu, price, bank, [status],Linkmeet)
VALUES 
(7, 2, N'Đặng Anh Hiển', 1, 'tutor1.jpg', 
    N'Với hơn 15 năm kinh nghiệm giảng dạy Toán học tại các trường đại học hàng đầu, tôi, Đặng Anh Hiển, luôn tự hào về khả năng giúp học sinh nắm vững kiến thức và đạt điểm cao trong các kỳ thi. Phương pháp giảng dạy của tôi không chỉ tập trung vào việc giải thích các khái niệm khó một cách dễ hiểu mà còn khơi gợi sự hứng thú và đam mê học tập ở mỗi học sinh. Tôi tin rằng mỗi học sinh đều có tiềm năng và nhiệm vụ của tôi là giúp các em phát huy tối đa khả năng của mình.', 
    N'Đại học FPT', 300000, 'Bank1', 'Active','https://meet.google.com/msp-qqda-dnq'),
(8, 4, N'Trương Gia Bình', 1, 'tutor2.jpg',
    N'Tôi là Trương Gia Bình, một chuyên gia Vật lý với hơn 20 năm kinh nghiệm giảng dạy và nghiên cứu. Với niềm đam mê và sự kiên trì, tôi luôn nỗ lực truyền đạt những kiến thức vật lý phức tạp một cách đơn giản và thú vị. Tôi đã có nhiều công trình nghiên cứu được công bố trên các tạp chí khoa học uy tín, và tôi tin rằng, sự hiểu biết sâu rộng cùng phương pháp giảng dạy sáng tạo của mình sẽ giúp học sinh không chỉ học tốt mà còn yêu thích môn Vật lý.', 
    N'Đại học Bách Khoa Hà Nội', 250000, 'Bank2', 'Active',' https://meet.google.com/msp-qqda-dnq'),
(9, 13, N'Nguyễn Phương', 0, 'tutor3.jpg', 
    N'Tôi là Nguyễn Phương, một giáo viên dạy văn với 10 năm kinh nghiệm. Tôi luôn tin rằng văn học không chỉ là môn học mà còn là cách để học sinh hiểu và trân trọng cuộc sống. Với phương pháp giảng dạy nhiệt huyết và tận tâm, tôi đã giúp nhiều học sinh đạt giải cao trong các kỳ thi học sinh giỏi văn cấp quốc gia. Tôi luôn cố gắng tạo ra một môi trường học tập đầy cảm hứng để các em có thể phát triển toàn diện kỹ năng ngôn ngữ và tư duy.', 
    N'Đại học Kinh tế Quốc dân', 400000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(10, 15, N'Nguyễn Xuân', 0, 'tutor4.jpg', 
    N'Với phương châm "Từ zero đến hero", tôi, Nguyễn Xuân, đã giúp đỡ nhiều học sinh từ mất gốc trở thành xuất sắc trong môn học. Phong cách giảng dạy của tôi linh hoạt, phù hợp với từng đối tượng học sinh, và tôi luôn sẵn sàng hỗ trợ các em vượt qua mọi khó khăn trong học tập. Tôi tin rằng sự nỗ lực và kiên trì sẽ đem lại kết quả tốt đẹp cho mọi học sinh.', 
    N'Đại học Kinh tế Quốc dân', 350000, 'Bank2', 'Active',' https://meet.google.com/msp-qqda-dnq'),
(11, 10, N'Phạm Quang Huy', 1, 'tutor5.jpg', 
    N'Tôi là Phạm Quang Huy, giáo viên dạy Tiếng Anh với hơn 12 năm kinh nghiệm. Tôi đã giúp nhiều học sinh đạt được chứng chỉ tiếng Anh quốc tế như IELTS, TOEFL với điểm số cao. Với phương pháp giảng dạy sáng tạo và sử dụng nhiều công cụ hiện đại, tôi luôn cố gắng mang đến cho học viên những bài học thú vị và hiệu quả. Tôi tin rằng với sự hướng dẫn của mình, các em sẽ tự tin hơn trong việc sử dụng tiếng Anh và đạt được mục tiêu của mình.', 
    N'Đại học Ngoại thương', 300000, 'Bank3', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(12, 11, N'Trần Hữu Dũng', 1, 'tutor6.jpg', 
    N'Tôi là Trần Hữu Dũng, giảng viên Vật lý ứng dụng với hơn 18 năm kinh nghiệm. Tôi tin rằng việc kết hợp lý thuyết với thực hành là cách tốt nhất để học sinh hiểu và yêu thích môn Vật lý. Tôi luôn tìm cách áp dụng các hiện tượng vật lý vào thực tiễn, giúp học sinh không chỉ học tốt mà còn thấy được sự kỳ diệu và ứng dụng của Vật lý trong cuộc sống hàng ngày.', 
    N'Đại học Sư phạm Hà Nội', 320000, 'Bank3', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(13, 5, N'Nguyễn Phương', 0, 'tutor3.jpg', 
    N'Tôi là Nguyễn Phương, một giáo viên dạy văn với 10 năm kinh nghiệm. Tôi luôn tin rằng văn học không chỉ là môn học mà còn là cách để học sinh hiểu và trân trọng cuộc sống. Với phương pháp giảng dạy nhiệt huyết và tận tâm, tôi đã giúp nhiều học sinh đạt giải cao trong các kỳ thi học sinh giỏi văn cấp quốc gia. Tôi luôn cố gắng tạo ra một môi trường học tập đầy cảm hứng để các em có thể phát triển toàn diện kỹ năng ngôn ngữ và tư duy.', 
    N'Đại học Kinh tế Quốc dân', 400000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(14, 1, N'Vũ Thanh Hải', 1, 'tutor7.jpg', 
    N'Tôi là Vũ Thanh Hải, giáo viên Toán với 10 năm kinh nghiệm. Tôi luôn nỗ lực giúp học sinh hiểu sâu và nắm vững các khái niệm Toán học, giúp các em đạt được điểm cao trong các kỳ thi.', 
    N'Đại học Sư phạm Hà Nội', 280000, 'Bank1', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(15, 2, N'Lê Thị Minh', 0, 'tutor8.jpg', 
    N'Giáo viên Lê Thị Minh, chuyên giảng dạy Toán lớp 11 với 8 năm kinh nghiệm. Tôi luôn mong muốn mang đến phương pháp học hiệu quả và tạo động lực học tập cho các em.', 
    N'Đại học Sư phạm TP.HCM', 290000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(16, 3, N'Phạm Văn Cường', 1, 'tutor9.jpg', 
    N'Phạm Văn Cường, giáo viên Toán lớp 12, với phương pháp giảng dạy sinh động và trực quan, giúp học sinh hiểu rõ bản chất của các khái niệm toán học.', 
    N'Đại học Quốc gia Hà Nội', 300000, 'Bank3', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(17, 4, N'Trần Thu Hà', 0, 'tutor10.jpg', 
    N'Tôi là Trần Thu Hà, chuyên gia Vật lý với 15 năm kinh nghiệm. Tôi luôn khơi gợi sự hứng thú và niềm đam mê Vật lý cho học sinh.', 
    N'Đại học Khoa học Tự nhiên', 260000, 'Bank1', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(18, 5, N'Nguyễn Minh Tú', 1, 'tutor11.jpg', 
    N'Nguyễn Minh Tú, giáo viên Vật lý lớp 11 với 12 năm kinh nghiệm. Tôi luôn cố gắng mang đến phương pháp học hiệu quả nhất cho học sinh.', 
    N'Đại học Bách Khoa Đà Nẵng', 270000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(19, 6, N'Hoàng Văn Anh', 1, 'tutor12.jpg', 
    N'Hoàng Văn Anh, giáo viên Vật lý lớp 12. Tôi đã giúp nhiều học sinh đạt điểm cao trong các kỳ thi quốc gia.', 
    N'Đại học Bách Khoa Hà Nội', 280000, 'Bank3', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(20, 7, N'Phạm Ngọc Linh', 0, 'tutor13.jpg', 
    N'Phạm Ngọc Linh, giáo viên Hóa học lớp 10 với 10 năm kinh nghiệm. Tôi luôn mang đến những bài học thú vị và sáng tạo.', 
    N'Đại học Khoa học Tự nhiên', 250000, 'Bank1', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(21, 8, N'Nguyễn Hữu Đức', 1, 'tutor14.jpg', 
    N'Nguyễn Hữu Đức, giáo viên Hóa học lớp 11. Tôi luôn cố gắng giúp học sinh hiểu rõ bản chất và yêu thích môn học.', 
    N'Đại học Sư phạm Hà Nội', 260000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(22, 9, N'Vũ Thị Hương', 0, 'tutor15.jpg',
    N'Vũ Thị Hương, giáo viên Hóa học lớp 12. Tôi luôn giúp học sinh nắm vững kiến thức và tự tin trong các kỳ thi.', 
    N'Đại học Sư phạm TP.HCM', 270000, 'Bank3', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(23, 10, N'Nguyễn Thị Lan', 0, 'tutor16.jpg', 
    N'Nguyễn Thị Lan, giáo viên Tiếng Anh lớp 10 với 8 năm kinh nghiệm. Tôi giúp học sinh cải thiện kỹ năng giao tiếp và đạt điểm cao trong các kỳ thi.', 
    N'Đại học Ngoại thương', 300000, 'Bank1', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(24, 11, N'Trần Văn Hùng', 1, 'tutor17.jpg', 
    N'Trần Văn Hùng, giáo viên Tiếng Anh lớp 11. Tôi đã giúp nhiều học sinh đạt chứng chỉ IELTS và TOEFL với điểm số cao.', 
    N'Đại học Khoa học Xã hội và Nhân văn', 310000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(25, 12, N'Phạm Thị Thanh', 0, 'tutor18.jpg', 
    N'Phạm Thị Thanh, giáo viên Tiếng Anh lớp 12. Tôi luôn mang đến phương pháp học tập hiệu quả và sáng tạo.', 
    N'Đại học Hà Nội', 320000, 'Bank3', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(26, 13, N'Vũ Văn Dũng', 1, 'tutor19.jpg', 
    N'Vũ Văn Dũng, giáo viên Văn học lớp 10 với 12 năm kinh nghiệm. Tôi luôn giúp học sinh yêu thích và đạt điểm cao trong môn Văn.', 
    N'Đại học Sư phạm Hà Nội', 280000, 'Bank1', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(27, 14, N'Nguyễn Thu Trang', 0, 'tutor20.jpg', 
    N'Nguyễn Thu Trang, giáo viên Văn học lớp 11. Tôi luôn nỗ lực mang đến những bài học thú vị và sáng tạo cho học sinh.', 
    N'Đại học Sư phạm TP.HCM', 290000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(28, 15, N'Trần Văn Nam', 1, 'tutor21.jpg', 
    N'Trần Văn Nam, giáo viên Văn học lớp 12. Tôi luôn cố gắng giúp học sinh nắm vững kiến thức và đạt điểm cao trong các kỳ thi.', 
    N'Đại học Quốc gia Hà Nội', 300000, 'Bank3', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(29, 1, N'Lê Văn Quang', 1, 'tutor22.jpg', 
    N'Lê Văn Quang, giáo viên Toán học lớp 10 với 10 năm kinh nghiệm. Tôi giúp học sinh nắm vững kiến thức và đạt điểm cao trong các kỳ thi.', 
    N'Đại học Khoa học Tự nhiên', 290000, 'Bank1', 'Pending',' https://meet.google.com/msp-qqda-dnq'),
(30, 2, N'Nguyễn Thị Hoa', 0, 'tutor23.jpg', 
    N'Nguyễn Thị Hoa, giáo viên Toán học lớp 11. Tôi luôn cố gắng mang đến phương pháp học tập hiệu quả nhất cho học sinh.', 
    N'Đại học Sư phạm Hà Nội', 300000, 'Bank2', 'Pending',' https://meet.google.com/msp-qqda-dnq');


-- Insert into Rating table
INSERT INTO Rating (learnerId, tutorId, rating, review, createdAt)
VALUES 
(1, 7, 5, N'Thầy dạy hay, vui tính', GETDATE()),
(2, 8, 4, N'Thầy dạy vui tính, hay', GETDATE()),
(3, 9, 5, N'Cô rất nhiệt tình và dễ hiểu', GETDATE()),
(4, 10, 3, N'Bài giảng còn hơi nhanh', GETDATE()),
(5, 11, 4, N'Thầy dạy rất tận tâm', GETDATE()),
(6, 12, 5, N'Bài giảng chi tiết và dễ hiểu', GETDATE());
--(1, 13, 4, N'Rất hài lòng với phương pháp giảng dạy của cô', GETDATE()),
--(2, 14, 3, N'Bài giảng cần chậm hơn', GETDATE()),
--(3, 15, 5, N'Thầy giảng rất dễ hiểu và vui tính', GETDATE()),
--(4, 16, 4, N'Thầy rất nhiệt tình', GETDATE()),
--(5, 17, 5, N'Cô giáo rất tận tình và chi tiết', GETDATE()),
--(6, 18, 4, N'Rất hài lòng', GETDATE()),
--(1, 19, 5, N'Thầy dạy rất dễ hiểu và tận tâm', GETDATE()),
--(2, 20, 3, N'Bài giảng cần chi tiết hơn', GETDATE()),
--(3, 21, 4, N'Cô dạy rất nhiệt tình', GETDATE()),
--(4, 22, 5, N'Bài giảng chi tiết và dễ hiểu', GETDATE()),
--(5, 23, 4, N'Thầy rất nhiệt tình và dễ hiểu', GETDATE()),
--(6, 24, 3, N'Cần thêm bài tập thực hành', GETDATE()),
--(1, 25, 5, N'Thầy giảng rất dễ hiểu và nhiệt tình', GETDATE()),
--(2, 26, 4, N'Rất hài lòng với phương pháp giảng dạy', GETDATE()),
--(3, 27, 5, N'Thầy rất tận tâm và nhiệt tình', GETDATE()),
--(4, 28, 4, N'Rất hài lòng', GETDATE()),
--(5, 29, 5, N'Thầy dạy rất dễ hiểu và tận tâm', GETDATE()),
--(6, 30, 3, N'Bài giảng cần chậm hơn', GETDATE());






-- Insert into Class table
INSERT INTO Class (learnerId, tutorId, subjectId, totalSession, startDate, endDate, [status])
VALUES 
(1, 7, 2, 10, '2024-05-01', '2024-05-30', 'finished'),
(2, 8, 4, 5, '2024-06-01', '2024-06-30', 'ongoing');

-- Insert into Slot table
INSERT INTO [Session] (id, startTime, endTime, [dayOfWeek])
VALUES 
('M1', '08:00:00', '09:30:00', 'Monday'),
('M2', '10:00:00', '11:30:00', 'Monday'),
('M3', '14:00:00', '15:30:00', 'Monday'),
('M4', '16:00:00', '17:30:00', 'Monday'),
('M5', '19:00:00', '20:30:00', 'Monday'),
('T1', '08:00:00', '09:30:00', 'Tuesday'),
('T2', '10:00:00', '11:30:00', 'Tuesday'),
('T3', '14:00:00', '15:30:00', 'Tuesday'),
('T4', '16:00:00', '17:30:00', 'Tuesday'),
('T5', '19:00:00', '20:30:00', 'Tuesday'),
('W1', '08:00:00', '09:30:00', 'Wednesday'),
('W2', '10:00:00', '11:30:00', 'Wednesday'),
('W3', '14:00:00', '15:30:00', 'Wednesday'),
('W4', '16:00:00', '17:30:00', 'Wednesday'),
('W5', '19:00:00', '20:30:00', 'Wednesday'),
('R1', '08:00:00', '09:30:00', 'Thursday'),
('R2', '10:00:00', '11:30:00', 'Thursday'),
('R3', '14:00:00', '15:30:00', 'Thursday'),
('R4', '16:00:00', '17:30:00', 'Thursday'),
('R5', '19:00:00', '20:30:00', 'Thursday'),
('F1', '08:00:00', '09:30:00', 'Friday'),
('F2', '10:00:00', '11:30:00', 'Friday'),
('F3', '14:00:00', '15:30:00', 'Friday'),
('F4', '16:00:00', '17:30:00', 'Friday'),
('F5', '19:00:00', '20:30:00', 'Friday'),
('SA1', '08:00:00', '09:30:00', 'Saturday'),
('SA2', '10:00:00', '11:30:00', 'Saturday'),
('SA3', '14:00:00', '15:30:00', 'Saturday'),
('SA4', '16:00:00', '17:30:00', 'Saturday'),
('SA5', '19:00:00', '20:30:00', 'Saturday'),
('SU1', '08:00:00', '09:30:00', 'Sunday'),
('SU2', '10:00:00', '11:30:00', 'Sunday'),
('SU3', '14:00:00', '15:30:00', 'Sunday'),
('SU4', '16:00:00', '17:30:00', 'Sunday'),
('SU5', '19:00:00', '20:30:00', 'Sunday');

-- Insert into Class_Slot table
INSERT INTO lesson (classId, sessionId, [date], [status])
VALUES 
(1, 'M1', '2024-05-06', 'Finished'),
(1, 'M1', '2024-05-13', 'Finished'),
(1, 'M1', '2024-05-20', 'Finished'),
(1, 'M1', '2024-05-27', 'Finished'),
(1, 'M1', '2024-06-03', 'Finished'),
(1, 'M1', '2024-06-10', 'Scheduled'),
(1, 'M1', '2024-06-17', 'Scheduled'),
(1, 'M1', '2024-06-24', 'Scheduled'),
(1, 'M1', '2024-07-01', 'Scheduled'),
(2, 'SA1', '2024-05-11', 'Finished'),
(2, 'SA1', '2024-05-18', 'Finished'),
(2, 'SA1', '2024-05-25', 'Finished'),
(2, 'SA1', '2024-06-01', 'Finished'),
(2, 'SA1', '2024-06-08', 'Scheduled'),
(2, 'SA1', '2024-06-15', 'Scheduled'),
(2, 'SA1', '2024-06-22', 'Scheduled');


-- Insert into TutorAvailability table
INSERT INTO TutorAvailability (tutorId, sessionId, [status])
VALUES 
(7, 'M1', 'Available'),
(7, 'M4', 'Available'),
(7, 'T2', 'Available'),
(7, 'SA1', 'Available'),
(8, 'SU3', 'Available'),
(8, 'F5', 'Available'),
(8, 'R3', 'Available'),
(8, 'M4', 'Available'),
(9, 'T3', 'Available'),
(9, 'W1', 'Available'),
(9, 'SA5', 'Available'),
(9, 'F5', 'Available'),
(10, 'T2', 'Available'),
(10, 'F4', 'Available'),
(10, 'SU5', 'Available'),
(10, 'SA5', 'Available'),
(10, 'M5', 'Available');

INSERT INTO Quiz (id,[fileName], filePath, score, [status], createdAt, lessonId, completedOn, startedOn,timeOfQuiz,timeTaken )

VALUES 
(1,N'Quiz1', 'path/to/Quiz1.docx', 9.5, 'done', GETDATE(), 1, null, null, 900,null),
(2,N'Quiz2', 'path/to/Quiz2.docx', 8.5, 'done', GETDATE(), 2, null, null, 900,null),
(3,N'Quiz3', 'path/to/Quiz3.docx', 7.5, 'done', GETDATE(), 3, null, null, 900,null),
(4,N'Quiz4', 'path/to/Quiz4.docx', 6.5, 'done', GETDATE(), 4, null, null, 900,null),
(5,N'Quiz5', 'path/to/Quiz5.docx', 5.5, 'done', GETDATE(), 5, null, null, 900,null),
(6,N'Quiz6', 'path/to/Quiz6.docx', null, 'todo', GETDATE(), 6, null, null, 900,null),
(7,N'Quiz7', 'path/to/Quiz7.docx', null, 'todo', GETDATE(), 7, null, null, 900,null),
(8,N'Quiz8', 'path/to/Quiz8.docx', null, 'todo', GETDATE(), 8, null, null, 900,null),
(9,N'Quiz9', 'path/to/Quiz9.docx', null, 'todo', GETDATE(), 9, null, null, 900,null),
(10,N'Quiz10', 'path/to/Quiz10.docx', null, 'done', GETDATE(), 10, null, null, 900,null),
(11,N'Quiz11', 'path/to/Quiz11.docx', null, 'done', GETDATE(), 11, null, null, 900,null),
(12,N'Quiz12', 'path/to/Quiz12.docx', null, 'done', GETDATE(), 12, null, null, 900,null),
(13,N'Quiz13', 'path/to/Quiz13.docx', null, 'done', GETDATE(), 13, null, null, 900,null),
(14,N'Quiz14', 'path/to/Quiz14.docx', null, 'todo', GETDATE(), 14, null, null, 900,null),
(15,N'Quiz15', 'path/to/Quiz15.docx', null, 'todo', GETDATE(), 15, null, null, 900,null),
(16,N'Quiz16', 'path/to/Quiz16.docx', null, 'todo', GETDATE(), 16, null, null, 900,null);

INSERT INTO Question (quizId, questionNumber, questionText, answerA, answerB, answerC , answerD, correctAnswer, chooseAnswer)
VALUES
-- Insert questions for Quiz 6
(6, 1, 'What is the capital of Canada?', 'Ottawa', 'Toronto', 'Vancouver', 'Montreal', 'Ottawa', null),
(6, 2, 'What is the chemical symbol for helium?', 'H', 'He', 'H2', 'Hi', 'He', null),
(6, 3, 'What is 3 + 5?', '5', '6', '7', '8', '8', null),
(6, 4, 'What is the longest river in the world?', 'Amazon', 'Nile', 'Yangtze', 'Mississippi', 'Nile', null),
(6, 5, 'Who is known as the Father of Computers?', 'Albert Einstein', 'Isaac Newton', 'Charles Babbage', 'Thomas Edison', 'Charles Babbage', null),
(6, 6, 'What is the process of converting water vapor into liquid water?', 'Evaporation', 'Condensation', 'Precipitation', 'Sublimation', 'Condensation', null),
(6, 7, 'What is the first element on the periodic table?', 'Oxygen', 'Carbon', 'Hydrogen', 'Nitrogen', 'Hydrogen', null),

-- Insert questions for Quiz 7
(7, 1, 'What is the capital of Australia?', 'Sydney', 'Canberra', 'Melbourne', 'Brisbane', 'Canberra', null),
(7, 2, 'What is the chemical symbol for potassium?', 'P', 'K', 'Pt', 'Po', 'K', null),
(7, 3, 'What is 9 * 9?', '81', '72', '63', '54', '81', null),
(7, 4, 'Which planet is closest to the sun?', 'Earth', 'Mars', 'Mercury', 'Venus', 'Mercury', null),
(7, 5, 'Who wrote "The Great Gatsby"?', 'Ernest Hemingway', 'F. Scott Fitzgerald', 'J.D. Salinger', 'John Steinbeck', 'F. Scott Fitzgerald', null),
(7, 6, 'What is the largest continent?', 'Africa', 'Asia', 'Europe', 'North America', 'Asia', null),

-- Insert questions for Quiz 8
(8, 1, 'What is the capital of Brazil?', 'Buenos Aires', 'Lima', 'Rio de Janeiro', 'Brasília', 'Brasília', null),
(8, 2, 'What is the chemical symbol for calcium?', 'Ca', 'Cl', 'C', 'Cu', 'Ca', null),
(8, 3, 'What is 12 - 4?', '6', '7', '8', '9', '8', null),
(8, 4, 'What is the largest desert in the world?', 'Sahara', 'Gobi', 'Arctic', 'Antarctic', 'Antarctic', null),
(8, 5, 'Who painted "Starry Night"?', 'Claude Monet', 'Pablo Picasso', 'Vincent van Gogh', 'Leonardo da Vinci', 'Vincent van Gogh', null),
(8, 6, 'What is the process of plants making food using sunlight?', 'Photosynthesis', 'Respiration', 'Transpiration', 'Fermentation', 'Photosynthesis', null),
(8, 7, 'What is the main gas in the Earth’s atmosphere?', 'Oxygen', 'Hydrogen', 'Carbon Dioxide', 'Nitrogen', 'Nitrogen', null),

-- Insert questions for Quiz 9
(9, 1, 'What is the capital of Russia?', 'Moscow', 'St. Petersburg', 'Novosibirsk', 'Yekaterinburg', 'Moscow', null),
(9, 2, 'What is the chemical symbol for iron?', 'Ir', 'In', 'I', 'Fe', 'Fe', null),
(9, 3, 'What is 7 * 7?', '48', '49', '50', '51', '49', null),
(9, 4, 'Which planet is known as the Blue Planet?', 'Earth', 'Neptune', 'Uranus', 'Mars', 'Earth', null),
(9, 5, 'Who wrote "Hamlet"?', 'Charles Dickens', 'Jane Austen', 'Mark Twain', 'William Shakespeare', 'William Shakespeare', null),
(9, 6, 'What is the freezing point of water?', '0°C', '32°C', '100°C', '50°C', '0°C', null),
(9, 7, 'What is the powerhouse of the cell?', 'Nucleus', 'Ribosome', 'Mitochondria', 'Chloroplast', 'Mitochondria', null),
(9, 8, 'What is the largest mammal?', 'Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus', 'Blue Whale', null),

-- Insert questions for Quiz 10
(10, 1, 'What is the capital of India?', 'Mumbai', 'Delhi', 'New Delhi', 'Bangalore', 'New Delhi', null),
(10, 2, 'What is the chemical symbol for chlorine?', 'Ch', 'Cl', 'Co', 'Cr', 'Cl', null),
(10, 3, 'What is 15 + 5?', '18', '19', '20', '21', '20', null),
(10, 4, 'What is the smallest ocean in the world?', 'Indian', 'Atlantic', 'Arctic', 'Pacific', 'Arctic', null),
(10, 5, 'Who wrote "Pride and Prejudice"?', 'Emily Brontë', 'Charlotte Brontë', 'Jane Austen', 'Mary Shelley', 'Jane Austen', null),
(10, 6, 'What is the process by which plants lose water?', 'Transpiration', 'Photosynthesis', 'Respiration', 'Fermentation', 'Transpiration', null),

-- Insert questions for Quiz 11
(11, 1, 'What is the capital of China?', 'Beijing', 'Shanghai', 'Hong Kong', 'Guangzhou', 'Beijing', null),
(11, 2, 'What is the chemical symbol for magnesium?', 'Mg', 'Mn', 'Mt', 'Ma', 'Mg', null),
(11, 3, 'What is 14 / 2?', '6', '7', '8', '9', '7', null),
(11, 4, 'Which planet is known as the Morning Star?', 'Venus', 'Mars', 'Mercury', 'Jupiter', 'Venus', null),
(11, 5, 'Who is the author of "Harry Potter"?', 'J.R.R. Tolkien', 'George R.R. Martin', 'J.K. Rowling', 'Rick Riordan', 'J.K. Rowling', null),
(11, 6, 'What is the largest country by area?', 'Canada', 'China', 'Russia', 'USA', 'Russia', null),
(11, 7, 'What is the term for animals that eat both plants and animals?', 'Herbivore', 'Carnivore', 'Omnivore', 'Insectivore', 'Omnivore', null),

-- Insert questions for Quiz 12
(12, 1, 'What is the capital of South Korea?', 'Seoul', 'Pyongyang', 'Busan', 'Incheon', 'Seoul', null),
(12, 2, 'What is the chemical symbol for sulfur?', 'S', 'Su', 'Sf', 'Sl', 'S', null),
(12, 3, 'What is 16 - 8?', '6', '7', '8', '9', '8', null),
(12, 4, 'What is the largest island in the world?', 'Greenland', 'Madagascar', 'Borneo', 'Australia', 'Greenland', null),
(12, 5, 'Who painted the "Last Supper"?', 'Michelangelo', 'Raphael', 'Leonardo da Vinci', 'Donatello', 'Leonardo da Vinci', null),
(12, 6, 'What is the term for the study of weather?', 'Astronomy', 'Biology', 'Meteorology', 'Geology', 'Meteorology', null),
(12, 7, 'What is the hardest natural substance?', 'Gold', 'Silver', 'Iron', 'Diamond', 'Diamond', null),
(12, 8, 'What is the main component of the sun?', 'Oxygen', 'Hydrogen', 'Helium', 'Carbon', 'Hydrogen', null),

-- Insert questions for Quiz 13
(13, 1, 'What is the capital of Egypt?', 'Cairo', 'Alexandria', 'Giza', 'Luxor', 'Cairo', null),
(13, 2, 'What is the chemical symbol for gold?', 'Au', 'Ag', 'Pt', 'Pb', 'Au', null),
(13, 3, 'What is 11 + 9?', '18', '19', '20', '21', '20', null),
(13, 4, 'What is the tallest mountain in the world?', 'K2', 'Kangchenjunga', 'Lhotse', 'Mount Everest', 'Mount Everest', null),
(13, 5, 'Who wrote "To Kill a Mockingbird"?', 'Harper Lee', 'F. Scott Fitzgerald', 'Ernest Hemingway', 'Mark Twain', 'Harper Lee', null),
(13, 6, 'What is the process of cell division?', 'Mitosis', 'Meiosis', 'Binary fission', 'Photosynthesis', 'Mitosis', null),
(13, 7, 'What is the smallest unit of life?', 'Cell', 'Atom', 'Molecule', 'Organ', 'Cell', null),

-- Insert questions for Quiz 14
(14, 1, 'What is the capital of Argentina?', 'Buenos Aires', 'Santiago', 'Lima', 'Montevideo', 'Buenos Aires', null),
(14, 2, 'What is the chemical symbol for silver?', 'Si', 'Ag', 'Al', 'Au', 'Ag', null),
(14, 3, 'What is 20 - 15?', '3', '4', '5', '6', '5', null),
(14, 4, 'What is the smallest bone in the human body?', 'Femur', 'Stapes', 'Ulna', 'Scapula', 'Stapes', null),
(14, 5, 'Who wrote "The Odyssey"?', 'Homer', 'Virgil', 'Ovid', 'Sappho', 'Homer', null),
(14, 6, 'What is the study of plants called?', 'Zoology', 'Geology', 'Botany', 'Mycology', 'Botany', null),
(14, 7, 'What is the most abundant gas in the Earth’s atmosphere?', 'Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Hydrogen', 'Nitrogen', null),
(14, 8, 'What is the main ingredient in traditional Japanese miso soup?', 'Miso paste', 'Soy sauce', 'Tofu', 'Nori', 'Miso paste', null),

-- Insert questions for Quiz 15
(15, 1, 'What is the capital of Thailand?', 'Bangkok', 'Phuket', 'Chiang Mai', 'Pattaya', 'Bangkok', null),
(15, 2, 'What is the chemical symbol for aluminum?', 'Al', 'Am', 'Au', 'Ag', 'Al', null),
(15, 3, 'What is 8 * 8?', '56', '64', '72', '80', '64', null),
(15, 4, 'What is the largest organ in the human body?', 'Heart', 'Liver', 'Skin', 'Lungs', 'Skin', null),
(15, 5, 'Who wrote "The Hobbit"?', 'J.R.R. Tolkien', 'C.S. Lewis', 'George R.R. Martin', 'J.K. Rowling', 'J.R.R. Tolkien', null),
(15, 6, 'What is the chemical formula for table salt?', 'NaCl', 'KCl', 'CaCl', 'MgCl', 'NaCl', null),
(15, 7, 'What is the main component of the Earth’s core?', 'Nickel', 'Iron', 'Magnesium', 'Aluminum', 'Iron', null),

-- Insert questions for Quiz 16
(16, 1, 'What is the capital of Spain?', 'Barcelona', 'Madrid', 'Seville', 'Valencia', 'Madrid', null),
(16, 2, 'What is the chemical symbol for zinc?', 'Z', 'Zn', 'Zc', 'Zx', 'Zn', null),
(16, 3, 'What is 13 + 7?', '19', '20', '21', '22', '20', null),
(16, 4, 'What is the longest bone in the human body?', 'Tibia', 'Fibula', 'Femur', 'Humerus', 'Femur', null),
(16, 5, 'Who wrote "Moby Dick"?', 'Herman Melville', 'Nathaniel Hawthorne', 'Edgar Allan Poe', 'Mark Twain', 'Herman Melville', null),
(16, 6, 'What is the process of water changing from a liquid to a gas?', 'Condensation', 'Precipitation', 'Evaporation', 'Sublimation', 'Evaporation', null),
(16, 7, 'What is the most common gas in the Earth’s atmosphere?', 'Oxygen', 'Nitrogen', 'Carbon Dioxide', 'Hydrogen', 'Nitrogen', null),
(16, 8, 'What is the main ingredient in traditional Indian curry?', 'Garam masala', 'Cumin', 'Turmeric', 'Curry powder', 'Curry powder', null);

 INSERT INTO Income (tax, amount, createdAt, DayPaid, [status], tutorID)
VALUES 
(0.1, 1000, '2023-06-25 00:00:00.000', '2024-08-01 00:00:00.000', 'paid', 7),
(0.08, 750, '2023-05-20 00:00:00.000', '2024-08-05 00:00:00.000', 'paid', 8),
(0.05, 500, '2022-04-15 00:00:00.000', NULL, 'pending confirmation', 9),
(0.065, 850, '2021-04-05 00:00:00.000', '2024-10-01 00:00:00.000', 'paid', 10),
(0.12, 1100, '2024-07-01 00:00:00.000', NULL, 'processing', 7),
(0.09, 800, '2023-04-18 00:00:00.000', NULL, 'pending confirmation', 8),
(0.06, 600, '2022-03-12 00:00:00.000', NULL, 'processing', 9),
(0.07, 900, '2021-02-08 00:00:00.000', NULL, 'pending confirmation', 10),
(0.11, 1150, '2020-01-05 00:00:00.000', '2024-12-01 00:00:00.000', 'paid', 7),
(0.09, 950, '2019-12-25 00:00:00.000', '2024-12-15 00:00:00.000', 'paid', 8),
(0.07, 950, '2024-07-17 00:00:00.000', '2024-07-18 00:00:00.000', 'paid', 7),
(0.08, 850, '2024-07-16 00:00:00.000', NULL, 'pending confirmation', 8),
(0.09, 900, '2024-07-15 00:00:00.000', '2024-07-17 00:00:00.000', 'paid', 9),
(0.1, 1000, '2024-07-14 00:00:00.000', NULL, 'pending confirmation', 10),
(0.065, 750, '2024-07-13 00:00:00.000', '2024-07-16 00:00:00.000', 'paid', 7),
(0.07, 1100, '2024-07-12 00:00:00.000', NULL, 'pending confirmation', 8),
(0.08, 800, '2024-07-11 00:00:00.000', NULL, 'processing', 9),
(0.09, 950, '2024-07-10 00:00:00.000', NULL, 'processing', 10),
(0.06, 600, '2024-07-09 00:00:00.000', '2024-07-12 00:00:00.000', 'paid', 7),
(0.1, 1200, '2024-07-08 00:00:00.000', '2024-07-11 00:00:00.000', 'paid', 8);

--USE [Tutorly]
--GO
--/****** Object:  Table [dbo].[Notification]    Script Date: 2024-07-17 오후 11:04:04 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[Notification](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[learnerId] [int] NULL,
--	[message] [nvarchar](255) NULL,
--	[isRead] [bit] NULL,
--	[createdAt] [datetime] NULL,
--	[type] [nvarchar](20) NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY]
--GO
--/****** Object:  Table [dbo].[SessionChangeRequest]    Script Date: 2024-07-17 오후 11:04:04 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[SessionChangeRequest](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[learnerId] [int] NULL,
--	[tutorId] [int] NULL,
--	[fromSessionId] [varchar](10) NULL,
--	[toSessionId] [varchar](10) NULL,
--	[reason] [nvarchar](255) NULL,
--	[status] [nvarchar](20) NULL,
--	[createdAt] [datetime] NULL,
--	[dateChange] [date] NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY]
--GO
--/****** Object:  Table [dbo].[TutorNotification]    Script Date: 2024-07-17 오후 11:04:04 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[TutorNotification](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[tutorId] [int] NULL,
--	[message] [nvarchar](255) NULL,
--	[isRead] [bit] NULL,
--	[createdAt] [datetime] NULL,
--	[type] [nvarchar](20) NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY]
--GO
--/****** Object:  Table [dbo].[TutorSessionChangeRequest]    Script Date: 2024-07-17 오후 11:04:04 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--CREATE TABLE [dbo].[TutorSessionChangeRequest](
--	[id] [int] IDENTITY(1,1) NOT NULL,
--	[learnerId] [int] NULL,
--	[tutorId] [int] NULL,
--	[fromSessionId] [varchar](10) NULL,
--	[toSessionId] [varchar](10) NULL,
--	[reason] [nvarchar](255) NULL,
--	[status] [nvarchar](20) NULL,
--	[createdAt] [datetime] NULL,
--	[dateChange] [date] NULL,
--PRIMARY KEY CLUSTERED 
--(
--	[id] ASC
--)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
--) ON [PRIMARY]
--GO
--SET IDENTITY_INSERT [dbo].[Notification] ON 

--INSERT [dbo].[Notification] ([id], [learnerId], [message], [isRead], [createdAt], [type]) VALUES (8, 1, N'Your Tutor request to change session 16:00:00 in Wednesday  to session 08:00:00 in Wednesday of  2024-06-10', 1, CAST(N'2024-07-16T14:58:02.450' AS DateTime), N'TutorRequest')
--INSERT [dbo].[Notification] ([id], [learnerId], [message], [isRead], [createdAt], [type]) VALUES (9, 1, N'Your Tutor request to change session 16:00:00 in Wednesday  to session 08:00:00 in Wednesday of  2024-06-10', 1, CAST(N'2024-07-16T15:17:15.823' AS DateTime), N'TutorRequest')
--INSERT [dbo].[Notification] ([id], [learnerId], [message], [isRead], [createdAt], [type]) VALUES (10, 1, N'Your request have been approved change 08:00:00 in Saturday  to session 19:00:00 in Saturday of  null', 1, CAST(N'2024-07-16T15:22:55.520' AS DateTime), N'TurorResponse')
--INSERT [dbo].[Notification] ([id], [learnerId], [message], [isRead], [createdAt], [type]) VALUES (11, 1, N'Your request have been rejected to change 16:00:00 in Wednesday  to session 19:00:00 in Wednesday of  2024-06-10', 1, CAST(N'2024-07-16T15:39:10.277' AS DateTime), N'TurorResponse')
--SET IDENTITY_INSERT [dbo].[Notification] OFF
--GO
--SET IDENTITY_INSERT [dbo].[SessionChangeRequest] ON 

--INSERT [dbo].[SessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (7, 1, 7, N'M1', N'T5', N'ses', N'Approved', CAST(N'2024-07-16T14:47:52.547' AS DateTime), CAST(N'2024-06-17' AS Date))
--INSERT [dbo].[SessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (8, 1, 7, N'M1', N'SA1', N'ss', N'Approved', CAST(N'2024-07-16T14:52:20.880' AS DateTime), CAST(N'2024-06-17' AS Date))
--INSERT [dbo].[SessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (9, 1, 7, N'SA1', N'SA5', N'ok', N'Approved', CAST(N'2024-07-16T15:18:57.940' AS DateTime), CAST(N'2024-06-17' AS Date))
--INSERT [dbo].[SessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (10, 1, 7, N'W4', N'T5', N's', N'Rejected', CAST(N'2024-07-16T15:29:57.723' AS DateTime), CAST(N'2024-06-10' AS Date))
--SET IDENTITY_INSERT [dbo].[SessionChangeRequest] OFF
--GO
--SET IDENTITY_INSERT [dbo].[TutorNotification] ON 

--INSERT [dbo].[TutorNotification] ([id], [tutorId], [message], [isRead], [createdAt], [type]) VALUES (6, 7, N'Your request have been rejected to change 16:00:00 in Wednesday  to session 08:00:00 in Wednesday of  null', 1, CAST(N'2024-07-16T15:18:43.917' AS DateTime), N'StudentResponse')
--INSERT [dbo].[TutorNotification] ([id], [tutorId], [message], [isRead], [createdAt], [type]) VALUES (7, 7, N'Your request have been rejected to change 16:00:00 in Wednesday  to session 08:00:00 in Wednesday of  null', 1, CAST(N'2024-07-16T15:18:44.427' AS DateTime), N'StudentResponse')
--INSERT [dbo].[TutorNotification] ([id], [tutorId], [message], [isRead], [createdAt], [type]) VALUES (8, 7, N'Your request have been rejected to change 08:00:00 in Monday  to session 19:00:00 in Monday of  null', 1, CAST(N'2024-07-16T15:18:45.047' AS DateTime), N'StudentResponse')
--INSERT [dbo].[TutorNotification] ([id], [tutorId], [message], [isRead], [createdAt], [type]) VALUES (9, 7, N'Your Tutor request to change session 16:00:00 in Wednesday  to session 19:00:00 in Wednesday of  2024-06-10', 1, CAST(N'2024-07-16T15:29:57.737' AS DateTime), N'StudentRequest')
--SET IDENTITY_INSERT [dbo].[TutorNotification] OFF
--GO
--SET IDENTITY_INSERT [dbo].[TutorSessionChangeRequest] ON 

--INSERT [dbo].[TutorSessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (6, 1, 7, N'M1', N'SA1', N'sss', N'Rejected', CAST(N'2024-07-16T14:22:51.407' AS DateTime), NULL)
--INSERT [dbo].[TutorSessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (7, 1, 7, N'M1', N'W4', N'sss', N'Approved', CAST(N'2024-07-16T14:28:19.520' AS DateTime), CAST(N'2024-06-10' AS Date))
--INSERT [dbo].[TutorSessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (8, 1, 7, N'M1', N'T5', N'sssss', N'Rejected', CAST(N'2024-07-16T14:57:08.353' AS DateTime), CAST(N'2024-07-01' AS Date))
--INSERT [dbo].[TutorSessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (9, 1, 7, N'W4', N'M1', N'ss', N'Rejected', CAST(N'2024-07-16T14:58:02.447' AS DateTime), CAST(N'2024-06-10' AS Date))
--INSERT [dbo].[TutorSessionChangeRequest] ([id], [learnerId], [tutorId], [fromSessionId], [toSessionId], [reason], [status], [createdAt], [dateChange]) VALUES (10, 1, 7, N'W4', N'M1', N'ss', N'Rejected', CAST(N'2024-07-16T15:17:15.810' AS DateTime), CAST(N'2024-06-10' AS Date))
--SET IDENTITY_INSERT [dbo].[TutorSessionChangeRequest] OFF
--GO
--ALTER TABLE [dbo].[Notification] ADD  DEFAULT ((0)) FOR [isRead]
--GO
--ALTER TABLE [dbo].[Notification] ADD  DEFAULT (getdate()) FOR [createdAt]
--GO
--ALTER TABLE [dbo].[SessionChangeRequest] ADD  DEFAULT ('Pending') FOR [status]
--GO
--ALTER TABLE [dbo].[SessionChangeRequest] ADD  DEFAULT (getdate()) FOR [createdAt]
--GO
--ALTER TABLE [dbo].[TutorNotification] ADD  DEFAULT ((0)) FOR [isRead]
--GO
--ALTER TABLE [dbo].[TutorNotification] ADD  DEFAULT (getdate()) FOR [createdAt]
--GO
--ALTER TABLE [dbo].[TutorSessionChangeRequest] ADD  DEFAULT ('Pending') FOR [status]
--GO
--ALTER TABLE [dbo].[TutorSessionChangeRequest] ADD  DEFAULT (getdate()) FOR [createdAt]
--GO
--ALTER TABLE [dbo].[Notification]  WITH CHECK ADD FOREIGN KEY([learnerId])
--REFERENCES [dbo].[Learner] ([id])
--GO
--ALTER TABLE [dbo].[SessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([fromSessionId])
--REFERENCES [dbo].[Session] ([id])
--GO
--ALTER TABLE [dbo].[SessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([learnerId])
--REFERENCES [dbo].[Learner] ([id])
--GO
--ALTER TABLE [dbo].[SessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([toSessionId])
--REFERENCES [dbo].[Session] ([id])
--GO
--ALTER TABLE [dbo].[SessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([tutorId])
--REFERENCES [dbo].[Tutor] ([id])
--GO
--ALTER TABLE [dbo].[TutorNotification]  WITH CHECK ADD FOREIGN KEY([tutorId])
--REFERENCES [dbo].[Tutor] ([id])
--GO
--ALTER TABLE [dbo].[TutorSessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([fromSessionId])
--REFERENCES [dbo].[Session] ([id])
--GO
--ALTER TABLE [dbo].[TutorSessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([learnerId])
--REFERENCES [dbo].[Learner] ([id])
--GO
--ALTER TABLE [dbo].[TutorSessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([toSessionId])
--REFERENCES [dbo].[Session] ([id])
--GO
--ALTER TABLE [dbo].[TutorSessionChangeRequest]  WITH CHECK ADD FOREIGN KEY([tutorId])
--REFERENCES [dbo].[Tutor] ([id])
--GO
