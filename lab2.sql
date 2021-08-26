use ankur_kalita21;

CREATE TABLE Student(
    snum INTEGER,
    sname VARCHAR(60),
    major VARCHAR(60),
    level VARCHAR(60),
    age INTEGER,
    PRIMARY KEY(snum)
);

CREATE TABLE Faculty(
    fid INTEGER,
    fname VARCHAR(60),
    deptid VARCHAR(60),
    PRIMARY KEY(fid)
);

CREATE TABLE Class(
    name VARCHAR(60),
    meets_at TIME,
    room VARCHAR(60),
    fid INTEGER,
    PRIMARY KEY(name),
    FOREIGN KEY (fid) REFERENCES Faculty(fid)
);

CREATE TABLE Enrolled(
    snum INTEGER,
    cname VARCHAR(60),
    FOREIGN KEY (snum) REFERENCES Student(snum),
    FOREIGN KEY (cname) REFERENCES Class(name)
);

SELECT DISTINCT S.sname FROM Student AS S, Faculty AS F, Class as C, Enrolled as E where S.snum = E.snum AND F.fname = "Gaurav" AND C.fid = F.fid
AND S.level = "JR";

SELECT MAX(S.age) FROM Student AS S WHERE S.major = "CS" OR S.snum IN ( SELECT S.snum FROM Student AS S, Faculty as F, Class AS C, Enrolled AS E WHERE
F.fname = "Gaurav" AND C.fid = F.fid AND E.cname = C.name);

SELECT C.name From Class AS C WHERE room = "R128" OR C.name IN (SELECT E.cname FROM Enrolled AS E GROUP BY E.cname HAVING COUNT(*) >= 5);

SELECT DISTINCT S.sname FROM Students AS S WHERE S.snum IN (SELECT E1.snum FROM Enrolled AS E1, Enrolled AS E2, Class AS C1, Class AS C2 WHERE C1.meets_at = C2.meets_at AND E1.cname = C1.name AND E2.cname = C2.name);

SELECT DISTINCT F.fname FROM Faculty AS F WHERE NOT EXISTS (( SELECT * FROM Class C ) EXCEPT (SELECT C1.room FROM Class C1 WHERE
 C1.fid = F.fid ));

 SELECT F.fname FROM Faculty AS F WHERE F.fid IN (SELECT F.fid FROM Faculty AS F, Class AS C, Enrolled AS E WHERE F.fid = C.fid AND 
 C.name = E.cname GROUP BY F.fid HAVING COUNT(*) < 5 );

 SELECT AVG(age), level FROM Student GROUP BY level;

 SELECT AVG(age), level FROM Student GROUP BY level EXCEPT SELECT AVG(age), level FROM Student WHERE level = "JR"; 

 SELECT DISTINCT F.fname, COUNT(*) FROM Faculty AS F, Enrolled AS E, Class AS C WHERE F.fid = C.fid AND C.name = E.cname AND C.room = "R128" GROUP BY E.snum;

SELECT DISTINCT S.sname FROM Student S WHERE S.snum IN (SELECT E.snum FROM Enrolled E GROUP BY E.snum HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM Enrolled E2 GROUP BY E2.snum ));

SELECT DISTINCT S.sname FROM Student S WHERE S.snum NOT IN (SELECT E.snum FROM Enrolled E);

SELECT S.age, S.level FROM Student S GROUP BY S.age, S.level HAVING S.level IN (SELECT S1.level FROM Student S1 WHERE S1.age = S.age GROUP BY S1.level, S1.age HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM Student S2 WHERE S1.age = S2.age GROUP BY S2.level, S2.age));