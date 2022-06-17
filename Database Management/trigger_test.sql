/**** The triggers will be activated when user and organization tables have some insertion. Finally, the ACCOUNT table will be updated with the triggers.****/
INSERT INTO USER(Ssn,title,name,last_logged)
  VALUES
(500000200,"Doctor","Jordan Mcknight","2020-11-22");
/**-**/
SELECT * FROM ACCOUNT WHERE Account_id = 500000200;

/**** The CONNECT_CONSTRAINT trigger is for disabling two users to connect for two times.****/
  INSERT INTO CONNECT (User_ssn,Connected_ssn)
VALUES
  (500000094,500000009);

/****The ORGANIZATION_ADMIN_INSERT trigger is for automatically updating WORKS_FOR_ORG table with organization admin.****/
INSERT INTO ORGANIZATION (Id,Admin_ssn,name,Start_date)
VALUES
  (600000999,500000009,"Cras Vulputate Incorporated","1997-08-17 19:00:50");
/**-**/
SELECT * FROM WORKS_FOR_ORG WHERE User_ssn = 500000009 AND Org_id = 600000999;

/****The NOPERMISSION_ASG_UPLOAD is for disabling to users who are not enrolled to a specific course which is assignment upload for.****/
  INSERT INTO ASSIGNMENT_UPLOAD (Assignment_id,Course_id,Student_ssn,Upload_date)
VALUES
  (12,4,500000032,"2022-02-09 09:27:53");