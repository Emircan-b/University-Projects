DELIMITER $$

/**** The triggers will be activated when user and organization tables have some insertion. Finally, the ACCOUNT table will be updated with the triggers.****/
CREATE TRIGGER USER_ACCOUNT_INSERTION
BEFORE INSERT 
        ON USER 
FOR EACH ROW
            BEGIN
                INSERT INTO ACCOUNT(Account_id)
                VALUES (NEW.Ssn);
            END;
$$

CREATE TRIGGER ORG_ACCOUNT_INSERTION
BEFORE INSERT 
        ON ORGANIZATION 
FOR EACH ROW
            BEGIN
                INSERT INTO ACCOUNT(Account_id)
                VALUES (NEW.Id);
            END;
$$

/****The triggers will be activated when POST,COMMENT and ANSWER tables have some insertion. Finally, the LIKABLE_CONTENT table will be updated with the triggers.****/
CREATE TRIGGER LIKABLE_POST_INSERTION
BEFORE INSERT 
        ON POST 
FOR EACH ROW
            BEGIN
                INSERT INTO LIKABLE_CONTENT(Id)
                VALUES (NEW.Likable_content_id);
            END;
$$     

CREATE TRIGGER LIKABLE_COMMENT_INSERTION
BEFORE INSERT 
        ON COMMENT 
FOR EACH ROW
            BEGIN
                INSERT INTO LIKABLE_CONTENT(Id)
                VALUES (NEW.Likable_content_id);
            END;
$$  

CREATE TRIGGER LIKABLE_ANSWER_INSERTION
BEFORE INSERT 
        ON ANSWER 
FOR EACH ROW
            BEGIN
                INSERT INTO LIKABLE_CONTENT(Id)
                VALUES (NEW.Likable_content_id);
            END;
$$
            

/**** The CONNECT_CONSTRAINT trigger is for disabling two users to connect for two times.****/
CREATE TRIGGER CONNECT_CONSTRAINT
BEFORE INSERT
        ON CONNECT
            FOR EACH ROW
                BEGIN
                    IF EXISTS(
                                SELECT * 
                                FROM CONNECT as A 
                                WHERE CONCAT(A.User_ssn,A.Connected_ssn) = CONCAT(NEW.Connected_ssn,NEW.User_ssn))
                            THEN SIGNAL SQLSTATE '45000'
                                    SET MESSAGE_TEXT = 'They are already connected';
                    END IF;                 
                END;
$$

/****The ORGANIZATION_ADMIN_INSERT trigger is for automatically updating WORKS_FOR_ORG table with organization admin.****/
CREATE TRIGGER ORGANIZATION_ADMIN_INSERT
AFTER INSERT 
             ON ORGANIZATION
                    FOR EACH ROW
                        BEGIN
                            IF NOT EXISTS(
                                            SELECT * 
                                            FROM WORKS_FOR_ORG 
                                            WHERE NEW.Admin_ssn = WORKS_FOR_ORG.User_ssn and WORKS_FOR_ORG.Org_id = NEW.Id )
                                THEN INSERT INTO WORKS_FOR_ORG(User_ssn,Org_id)
                                        VALUES (NEW.Admin_ssn,NEW.Id);
                            END IF;
                        END;
$$


/****The NOPERMISSION_ASG_UPLOAD is for disabling to users who are not enrolled to a specific course which is assignment upload for.****/
CREATE TRIGGER NOPERMISSION_ASG_UPLOAD
BEFORE INSERT
        ON ASSIGNMENT_UPLOAD
            FOR EACH ROW
                BEGIN
                    IF NOT EXISTS(
                        SELECT *
                        FROM ASSIGNMENT AS ASG  , ENROLLS AS ENR
                        WHERE NEW.Assignment_id = ASG.Assignment_id 
                                        AND  ASG.Course_id = ENR.Course_id
                                                AND NEW.Student_ssn = ENR.Student_ssn)
                        THEN SIGNAL SQLSTATE '45000'
                                    SET MESSAGE_TEXT = 'No permission to the user. Not enrolled to the course!';
                    END IF;
                END;
$$
/*
CREATE TRIGGER CHECKDATEVALID
BEFORE INSERT
        ON PROJECT
            FOR EACH ROW
                BEGIN
                    IF(NEW.End_date!=NULL)
                    THEN
                            IF (TIMESTAMPDIFF(SECOND,Start_date,End_date)<0)
                                THEN SIGNAL SQLSTATE '45000'
                                    SET MESSAGE_TEXT = 'Start date must be earlier than end date!';
                            END IF;
                    END IF;
                END;
$$*/

DELIMITER ;