/*The SLFCNCTN constraint is for disabling self connection on system.*/
INSERT INTO CONNECT(User_ssn,Connected_ssn)
VALUES(500000001,500000001);

/*The CheckEndLaterThanStart constraint is for checking if start and end dates is valid.*/
  INSERT INTO PROJECT(Id,Pname,Start_date,End_date,Org_id)
  VALUES
  (999,"neque. Nullam","2021-01-22 18:11:37","2011-07-04 08:39:12",600000000);

/*The GRADECONSTRAINT constraint is for checking if grade value is valid.*/
INSERT INTO ASSIGNMENT_GRADE (Assignment_id,Course_id,Student_ssn,Grade_date,Grade)
VALUES
  (8,1,500000032,"2022-02-19 19:27:53",200);

/*The NOBADCOMMENT constraint is for disabling swear words to use.*/
INSERT INTO POST(Id,Account_id,Content,Likable_content_id )
VALUES
  (399,500000009,"arcu 05343577145 FUCK imperdiet",900000999);

/*The BADCHARS constraint is for disabling unwanted chars to be used!*/
INSERT INTO USER (Ssn,title,name,last_logged)
VALUES
  (500000600,"Developer","Talon Kent~","2021-11-22");

/**/