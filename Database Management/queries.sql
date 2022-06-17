/***Information of active ORGANIZATION's registered in the system and established after 2000...***/
/***2000 yılından sonra kurulmuş aktif ORGANIZATION'lar listeleniyor***/
SELECT
  name,
  Start_date,
  Mission,
  Vision
FROM ORGANIZATION
WHERE YEAR(Start_date)> 2000;

/***POST's in the system that contain phone numbers... ***/
/***Telefon numarası içeren POST içerikleri listelensin ***/
SELECT Id,
  Account_id,
  Created_at,
  Content
FROM POST
WHERE Content LIKE "%5_________%"
  OR Content LIKE "%5__ ___ __ __%"
  OR Content LIKE "%(5__) ___ __ __%";

/***Data for comments with content longer than 25 characters... ***/
/***Yirmibeş karakterden daha uzun içeriğe sahip COMMENT verileri ***/
SELECT
  Comment_id,
  Account_id,
  Body
FROM COMMENT
WHERE CHAR_LENGTH(Body) > 25;

/***The name of the COURSE that has more than one ASSIGNMENT in the 2020 and the number of how many ASSIGNMENT's it has in descending order... ***/
/***2020 yılı içerisinde birden fazla ASSIGNMENT'a sahip olan  ***/
SELECT C.Cname AS Course_Name, C.Cdate,
  COUNT(*) AS Ass_Count
FROM COURSE AS C, ASSIGNMENT AS A
WHERE C.Id = A.Course_id
  AND YEAR(C.Cdate)= 2020
GROUP BY C.Id
HAVING Ass_Count>2
ORDER BY Ass_Count DESC;

/***Data from TEACHER's teaching Calculus 1. ***/
/***Calculus 1 dersini veren TEACHER verileri listeleniyor ***/
SELECT
  U.Ssn,
  U.name,
  C.Cdate as Course_date
FROM COURSE AS C, USER AS U
WHERE C.Teacher_ssn = U.Ssn
  AND C.Cname = "Calculus 1";

/***Data of most skilled 10 USER's in descending order ***/
/***En çok yeteneğe sahip 10 USER verisi listeleniyor... ***/
SELECT title,
  name,
  last_logged,
  COUNT(*) AS Skill_count
FROM USER, USER_SKILLS
WHERE Ssn = User_ssn
GROUP BY Ssn
ORDER BY Skill_count DESC
LIMIT 10;

/***Let a POST list the replies to the COMMENT that received more likes than the COMMENT made. ***/
/***Bir POST'a ait COMMENT'lerden ilgili olan COMMENT'in ANSWER'ının daha fazla LIKE aldığı ANSWER'lar listeleniyor ***/
SELECT C
.Comment_id,
       AN.Answer_id,
       C.Body AS C_body,
       AN.Body AS A_body
FROM COMMENT AS C, ANSWER AS AN
WHERE
(   SELECT COUNT(*)
FROM LIKES AS L
WHERE AN.Likable_content_id = L.Likable_content_id
  AND AN.Comment_id = C.Comment_id
    )
>
(   SELECT COUNT(*)
FROM LIKES AS L
WHERE L.Likable_content_id = C.Likable_content_id
    );

/***The data of the PROJECT's worked by the USER's whose grade point average is higher than 50 from the ASSIGNMENT's they have uploaded... ***/
/***Yüklemiş oldukları ASSIGNMENT'lar üzerinden sahip oldukları ortalama notu 50'den yüksek olan USER'ların çalıştıkları PROJECT'ler listeleniyor... ***/
SELECT U.Ssn,
  U.name,
  P.Pname,
  P.Start_date,
  P.End_date
FROM USER AS U, WORKS_ON_PROJECT AS WOP, PROJECT AS P
WHERE P.Id = WOP.Project_id
  AND WOP.User_ssn = U.Ssn
  AND (U.Ssn) IN
                          (   SELECT AG.Student_ssn
  FROM ASSIGNMENT_GRADE AS AG
  GROUP BY AG.Student_ssn
  HAVING AVG(AG.Grade)>50);

/***The names,titles and last login dates of the five USER's with the most CONNECTION's who have data on moodle ... ***/
/***Moodle'da verisi olan ve en yüksek CONNECTION sayısına sahip olan beş USER'ın, isim , ünvan ve son giriş tarihleri listeleniyor... ***/
SELECT U.Name,
  U.title,
  U.last_logged
FROM USER AS U, TEACHER AS T, STUDENT AS S
WHERE (U.Ssn = T.Ssn OR U.SSN = S.Ssn)
  AND U.Ssn IN
                    (   SELECT U.Ssn
  FROM USER AS U, CONNECT AS C
  WHERE U.Ssn = C.User_ssn
    OR U.Ssn = C.Connected_ssn
  GROUP BY U.Ssn
  ORDER BY Count(*) DESC)
LIMIT 5 ;

/***Number of assignments submitted and graded by students who enrolled to the most courses... ***/
/***En çok derse kayıtlı olan öğrencilerin yükledikleri ve notlanan ASSIGNMENT sayıları listeleniyor... ***/
WITH RECURSIVE MOST_ENROLLED_USERS
(Ssn, total)AS
  (
  SELECT U.Ssn, COUNT(*) AS total
  FROM STUDENT AS U, ENROLLS AS E
  WHERE U.Ssn = E.Student_ssn
  GROUP BY U.Ssn
UNION
  SELECT M.Ssn, M.total
  FROM MOST_ENROLLED_USERS AS M)
SELECT M.Ssn,
  M.total,
  USER.name,
  (SELECT COUNT(*)
  FROM ASSIGNMENT_UPLOAD AS A
  WHERE A.Student_ssn = M.Ssn) AS uploaded_as ,
  (SELECT COUNT(*)
  FROM ASSIGNMENT_GRADE AS A
  WHERE A.Student_ssn = M.Ssn) AS graded_as
FROM MOST_ENROLLED_USERS AS M, USER
WHERE M.Ssn = USER.Ssn
ORDER BY total DESC
LIMIT 5;

/***The number of talents of STUDENT's who have not uploaded any ASSIGNMENT they are responsible for... ***/
/***Sorumlu oldukları hiçbir ASSIGNMENT'ı yüklememiş olan STUDENT'ların yetenek sayıları listeleniyor... ***/
SELECT S
.Ssn,
       COUNT
(*) AS skill_c
FROM STUDENT AS S,
     ASSIGNMENT AS A, USER_SKILLS AS SKILL
WHERE SKILL.User_ssn = S.Ssn
  AND NOT EXISTS
(SELECT *
FROM ASSIGNMENT_UPLOAD AS UPLOAD
WHERE S.Ssn = UPLOAD.Student_ssn AND A.Assignment_id = UPLOAD.Assignment_id )
AND A.Assignment_id IN
(SELECT A.Assignment_id
FROM ENROLLS AS E
WHERE A.Course_id = E.Course_id
  AND S.Ssn = E.Student_ssn )
GROUP BY SKILL.User_ssn
ORDER BY skill_c DESC;

/***PROJECT data including STUDENT's who enroll in COURSE's given by TEACHER's who speak more than one language... ***/
/***Birden fazla dil bilen TEACHER'ların verdiği COURSE'lara dahil olan STUDENT'ların PROJECT verileri listeleniyor ***/
SELECT E.Student_ssn,
  P.Pname,
  P.Pdesc,
  P.Start_date
FROM ENROLLS AS E, COURSE AS CRS, PROJECT AS P, WORKS_ON_PROJECT AS WOP
WHERE WOP.User_ssn = E.Student_ssn
  AND WOP.Project_id = P.Id
  AND CRS.Id = E.Course_id
  AND CRS.Id IN
                        (SELECT CRS.Id
  FROM TEACHER AS T
  WHERE CRS.Teacher_ssn = T.Ssn
    AND T.Ssn IN
                                                (SELECT T.Ssn
    FROM USER_LANGS AS UL
    WHERE T.Ssn = UL.User_ssn
    GROUP BY T.Ssn
    HAVING COUNT(*)>1) );

/***As a result of the evaluation of the TEACHER'S registered in the system based on ASSIGNMENTs, the data of the 5 TEACHER's with the best evaluation...
(The time which spend to teacher to evaluate submitted Assignment (Low Good))
(Grade point averages of the students in the relevant course (High Good))                                                                                   ***/
SELECT C.Teacher_ssn,
  U.name AS Teacher_name,
  AVG(TIMESTAMPDIFF(HOUR, AU.Upload_date, AG.Grade_date)) AS avg_time,
  AVG(AG.Grade) AS t_avg_grade,
  count(*) AS std_count
FROM ASSIGNMENT_UPLOAD AS AU,
  ASSIGNMENT_GRADE AS AG,
  COURSE AS C,
  USER AS U
WHERE C.Teacher_ssn = U.Ssn
  AND C.Id = AG.Course_id
  AND AU.Assignment_id = AG.Assignment_id
GROUP BY C.Teacher_ssn
ORDER BY t_avg_grade DESC,
         avg_time ASC
;

/***The data of the TEACHER of the COURSE that gives more than three ASSIGNMENT and how many STUDENT's take this course.. ***/
/***Üçten fazla ASSIGNMENT veren COURSE'un TEACHER'ının verileri ve kaç STUDENT'un bu dersi aldığı listeleniyor... ***/
SELECT U.Ssn AS T_ssn,
  U.name AS Tname,
  C.Cname,
  Count(*) AS St_Count
FROM USER AS U, COURSE AS C, ENROLLS AS E
WHERE C.Teacher_ssn = U.Ssn
  AND C.Id = E.Course_id
  AND C.Id IN
    (SELECT A.Course_id
  FROM ASSIGNMENT AS A,
    COURSE AS C
  WHERE A.Course_id = C.Id
  GROUP BY A.Course_id
  HAVING COUNT(*)>3)
GROUP BY E.Course_id;

/***The names, titles, average grades, the number of languages they know and the number of talents they have of USER's with the highest average according to graded ASSIGNMENT's. ***/
/***Notlanan ASSIGNMNET'lara göre en yüksek ortalamaya sahip STUDENT'ların; isimleri , ünvanları, ortalama notları, kaç adet yeteneğe sahip oldukları ve kaç dil bildikleri listeleniyor ***/
WITH RECURSIVE AVG_GRADES
(Ssn, Avarage_grade) AS
  (
  SELECT Student_ssn,
    AVG(Grade)
  FROM ASSIGNMENT_GRADE
  GROUP BY Student_ssn
UNION
  SELECT AG.Ssn,
    Ag.Avarage_grade
  FROM AVG_GRADES AS AG)
SELECT name,
  title,
  AG.Avarage_grade,
  (SELECT COUNT(*)
  FROM USER_LANGS AS UL
  WHERE UL.User_ssn = AG.Ssn) AS lang_count,
  (SELECT COUNT(*)
  FROM USER_SKILLS AS US
  WHERE US.User_ssn = AG.Ssn) AS skill_count
FROM AVG_GRADES AS AG, USER
WHERE USER.Ssn = AG.Ssn
ORDER BY AG.Avarage_grade DESC
LIMIT 5;



