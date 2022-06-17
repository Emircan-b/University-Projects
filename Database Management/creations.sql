    /*eski databasei droplama*/
    DROP DATABASE linkedin_moodle;
    /*database oluşturma*/
    CREATE DATABASE linkedin_moodle;
    /*yeni databasei kullanmak*/
    USE linkedin_moodle;

    /*tabloları oluşturmak*/

    CREATE TABLE ACCOUNT(
        Account_id CHAR(9) NOT NULL PRIMARY KEY
                        );

    CREATE TABLE USER(
        Ssn CHAR(9) NOT NULL PRIMARY KEY,
        title VARCHAR(30) NOT NULL,
        name VARCHAR(100) NOT NULL,
        last_logged TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        /***CONSTRAINT ILE BAZI KARAKTERLER ENGELLENIYOR***/
        CONSTRAINT BADCHARS CHECK(name NOT LIKE "%*%" AND name NOT LIKE "%-%" AND name NOT LIKE "%+%" AND name NOT LIKE "%~%"),
        FOREIGN KEY(Ssn) REFERENCES ACCOUNT(Account_id)
                                ON UPDATE CASCADE ON DELETE CASCADE 
    );

    CREATE TABLE USER_SKILLS(
        User_ssn CHAR(9) NOT NULL,
        Sname VARCHAR(30) NOT NULL,
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn),
        PRIMARY KEY(User_ssn,Sname)
    );

    CREATE TABLE USER_LANGS(
        User_ssn CHAR(9) NOT NULL,
        Lname VARCHAR(30) NOT NULL,
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn),
        PRIMARY KEY(User_ssn,Lname)
    );

    CREATE TABLE CONNECT(
        User_ssn CHAR(9) NOT NULL,
        Connected_ssn CHAR(9) NOT NULL,
        /***CONSTRAINT ILE KULLANICININ KENDINI TAKIP ETMESI ENGELLENIYOR***/
        CONSTRAINT SLFCNCTN CHECK (User_ssn != Connected_ssn),
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
        FOREIGN KEY(Connected_Ssn) REFERENCES USER(Ssn)
        ON DELETE NO ACTION ON UPDATE NO ACTION,
        PRIMARY KEY(User_ssn,Connected_Ssn)
    );

    CREATE TABLE ORGANIZATION(
        Id CHAR(9),
        name VARCHAR(255) NOT NULL,
        Start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        Admin_ssn CHAR(9) NOT NULL,
        Mission VARCHAR(255) DEFAULT "ORGANIZATION_MISSION",
        Vision VARCHAR(255) DEFAULT "ORGRANIZATION_VISION",
        PRIMARY KEY(Id),
        FOREIGN KEY(Id) REFERENCES ACCOUNT(Account_id)
                                ON UPDATE CASCADE ON DELETE CASCADE,
        FOREIGN KEY(Admin_ssn) REFERENCES USER(Ssn)
    );

    CREATE TABLE WORKS_FOR_ORG(
        User_ssn CHAR(9) NOT NULL,
        Org_id CHAR(9) NOT NULL,
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn),
        FOREIGN KEY(Org_id) REFERENCES ORGANIZATION(Id),
        PRIMARY KEY(User_ssn,Org_id)
    );

    CREATE TABLE LIKABLE_CONTENT(
        Id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY
    );

    CREATE TABLE POST(
        Id INTEGER NOT NULL AUTO_INCREMENT,
        Account_id CHAR(9) NOT NULL,
        Created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        Content VARCHAR(255) NOT NULL DEFAULT "POST_CONTENT",
        Likable_content_id INTEGER NOT NULL,
        /***CONSTRAINT ILE YASAKLI KELIMELERIN KULLANILMASI ENGELLENIYOR***/
        CONSTRAINT NOBADPOST CHECK(Content NOT LIKE "%fuck%"),
        PRIMARY KEY(Id,Account_id) ,
        FOREIGN KEY(Account_id) REFERENCES ACCOUNT(Account_id),
        FOREIGN KEY(Likable_content_id) REFERENCES LIKABLE_CONTENT(Id)
    );

    CREATE TABLE PROJECT(
        Id INTEGER NOT NULL,
        Pname VARCHAR(100) NOT NULL,
        Pdesc VARCHAR(255) DEFAULT "NO DESC PROVIDED",
        Start_date DATETIME DEFAULT NOW(),
        Org_id CHAR(9) NOT NULL,
        End_date DATETIME  DEFAULT NULL,
        /***CONSTRAINT ILE BAŞLANGIÇ VE BİTİŞ TARİHİNİN SAĞLIKLI OLMASI SAĞLANIYOR***/
        CONSTRAINT CheckEndLaterThanStart CHECK (End_date=NULL OR Start_date<End_date),
        PRIMARY KEY(Id),
        FOREIGN KEY(Org_id) REFERENCES ORGANIZATION(Id)
    );

    CREATE TABLE WORKS_ON_PROJECT(
        User_ssn char(9) NOT NULL,
        Project_id INTEGER NOT NULL,
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn),
        FOREIGN KEY(Project_id) REFERENCES PROJECT(Id),
        PRIMARY KEY(User_ssn,Project_id)
    );

    CREATE TABLE COMMENT(
        Comment_id INTEGER NOT NULL AUTO_INCREMENT,
        Account_id CHAR(9) NOT NULL,
        Post_id INTEGER NOT NULL,
        User_ssn CHAR(9) NOT NULL,
        Body VARCHAR(255) DEFAULT "Comment_body",
        Likable_content_id INTEGER NOT NULL,
        /***CONSTRAINT ILE YASAKLI KELIMELERIN KULLANILMASI ENGELLENIYOR***/
        CONSTRAINT NOBADCOMMENT CHECK(Body NOT LIKE "%fuck%"),
        PRIMARY KEY(Comment_id,Account_id,Post_id),
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn),
        FOREIGN KEY(Post_id,Account_id) REFERENCES POST(Id,Account_id),
        FOREIGN KEY(Likable_content_id) REFERENCES LIKABLE_CONTENT(Id)

    );

    CREATE TABLE ANSWER(
        Answer_id INTEGER NOT NULL AUTO_INCREMENT,
        Account_id CHAR(9) NOT NULL,
        Comment_id INTEGER NOT NULL,
        Post_id INTEGER NOT NULL,
        User_ssn CHAR(9) NOT NULL,
        Body VARCHAR(255) DEFAULT "ANSWER_BODY",
        Likable_content_id INTEGER NOT NULL,
        /***CONSTRAINT ILE YASAKLI KELIMELERIN KULLANILMASI ENGELLENIYOR***/
        CONSTRAINT NOBADANSWER CHECK(Body NOT LIKE "%fuck%"),
        PRIMARY KEY(Answer_id,Account_id,Comment_id,Post_id),
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn),
        FOREIGN KEY(Comment_id,Account_id,Post_id) REFERENCES COMMENT(Comment_id,Account_id,Post_id),
        FOREIGN KEY(Post_id,Account_id) REFERENCES POST(Id,Account_id),
        FOREIGN KEY(Likable_content_id) REFERENCES LIKABLE_CONTENT(Id)
    );

    CREATE TABLE STUDENT(
        Ssn CHAR(9) NOT NULL,
        Snumber CHAR(11) NOT NULL UNIQUE,
        PRIMARY KEY(Ssn)
    );


    CREATE TABLE TEACHER(
        Ssn CHAR(9) NOT NULL,
        title VARCHAR(50) NOT NULL DEFAULT "Asistant",
        PRIMARY KEY(Ssn)
    );

    CREATE TABLE COURSE(
        Id INTEGER AUTO_INCREMENT,
        Cname VARCHAR(75) NOT NULL,
        Cdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        Teacher_ssn CHAR(9) NOT NULL,
        PRIMARY KEY(Id),
        FOREIGN KEY(Teacher_ssn) REFERENCES TEACHER(Ssn)
    );

    CREATE TABLE ASSIGNMENT(
        Assignment_id INTEGER NOT NULL AUTO_INCREMENT,
        Course_id INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        Aname VARCHAR(100) NOT NULL,
        PRIMARY KEY(Assignment_id,Course_id),
        FOREIGN KEY(Course_id) REFERENCES COURSE(Id)
    );

    CREATE TABLE ASSIGNMENT_UPLOAD(
        Assignment_id INTEGER NOT NULL,
        Course_id INTEGER NOT NULL,
        Student_ssn CHAR(9) NOT NULL,
        Upload_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(Assignment_id,Course_id) REFERENCES ASSIGNMENT(Assignment_id,Course_id),
        FOREIGN KEY(Student_ssn) REFERENCES STUDENT(Ssn),
        FOREIGN KEY(Student_ssn) REFERENCES USER(Ssn),
        PRIMARY KEY(Assignment_id,Course_id,Student_ssn)
    );

    CREATE TABLE ASSIGNMENT_GRADE(
        Assignment_id INTEGER NOT NULL,
        Course_id INTEGER NOT NULL,
        Student_ssn CHAR(9) NOT NULL,
        Grade INTEGER NOT NULL DEFAULT 0,
        Grade_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        /***CONSTRAINT ILE NOTUN 0 ILE 100 ARASINDA OLMASI SAĞLANIYOR***/
        CONSTRAINT GRADECONSTRAINT CHECK(Grade>=0 and Grade<=100),
        FOREIGN KEY(Assignment_id,Course_id) REFERENCES ASSIGNMENT(Assignment_id,Course_id),
        FOREIGN KEY(Student_ssn) REFERENCES STUDENT(Ssn),
        FOREIGN KEY(Student_ssn) REFERENCES USER(Ssn),
        PRIMARY KEY(Assignment_id,Student_ssn,Course_id)
    );

    CREATE TABLE ENROLLS(
        Course_id INTEGER NOT NULL,
        Student_ssn CHAR(9) NOT NULL,
        Enroll_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY(Course_id) REFERENCES COURSE(Id),
        FOREIGN KEY(Student_ssn) REFERENCES STUDENT(Ssn),
        FOREIGN KEY(Student_ssn) REFERENCES USER(Ssn),
        PRIMARY KEY(Course_id,Student_ssn)
    );



    CREATE TABLE LIKES(
        User_ssn CHAR(9) NOT NULL,
        Likable_content_id INTEGER NOT NULL,
        PRIMARY KEY(User_ssn , Likable_content_id),
        FOREIGN KEY(User_ssn) REFERENCES USER(Ssn),
        FOREIGN KEY(Likable_content_id) REFERENCES LIKABLE_CONTENT(Id)
    );