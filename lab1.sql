use ankur_kalita21;

CREATE TABLE Sailors (
   sid    INTEGER,   
   sname  CHAR(20), 
   rating INTEGER, 
   age    REAL,
   PRIMARY KEY (sid));

CREATE TABLE Boats (
   bid   INTEGER,     	
   bname CHAR(20), 
   color CHAR(10), 
   PRIMARY KEY (bid));

CREATE TABLE Reserves (
   sid INTEGER,      
   bid INTEGER, 
   day DATE, 
  PRIMARY KEY (sid, bid, day), 
  FOREIGN KEY (sid) REFERENCES Sailors(sid), 
  FOREIGN KEY (bid) REFERENCES Boats(bid));


  INSERT INTO Sailors VALUES
    (1, 'Ankur', 10, 26),
    (2, 'Rahul', 9, 39),
    (3, 'Abhijit', 8, 27), 
    (4, 'Debdeep', 7, 25), 
    (5, 'Satish', 7, 29);

    INSERT INTO Boats VALUES
    (101, 'Titanic', 'red'),
    (102, 'Kaveri', 'blue'),
    (103, 'Naruto', 'red'),
    (104, 'Hiruzen', 'black'), 
    (105, 'Kakashi', 'blue');

    INSERT INTO Reserves VALUES
    (1, 101, '2021-08-1'),
    (1, 102, '2021-08-02'),
    (1, 103, '2021-08-03'),
    (1, 104, '2021-08-04'),
    (1, 104, '2021-08-05'),
    (2, 101, '2021-08-1'),
    (2, 102, '2021-08-02'),
    (2, 103, '2021-08-03'),
    (2, 104, '2021-08-04'),
    (2, 104, '2021-08-05'),
    (3, 101, '2021-08-1'),
    (3, 102, '2021-08-02'),
    (3, 103, '2021-08-03'),
    (3, 104, '2021-08-04'),
    (3, 104, '2021-08-05'),
    (4, 101, '2021-08-1'),
    (4, 102, '2021-08-02'),
    (4, 103, '2021-08-03'),
    (4, 104, '2021-08-04'),
    (4, 104, '2021-08-05'),
    (5, 101, '2021-08-1'),
    (5, 102, '2021-08-02'),
    (5, 103, '2021-08-03'),
    (5, 104, '2021-08-04'),
    (5, 104, '2021-08-05');

    SELECT sname, rating FROM Sailors WHERE age = 27;

    SELECT DISTINCT S.sname FROM Sailors AS S, Reserves AS R WHERE S.sid = R.sid;

   SELECT S.sid FROM   Sailors S, Boats B, Reserves R WHERE  S.sid=R.sid AND R.bid=B.bid AND B.color='red' INTERSECT SELECT S.sid FROM   Sailors S, Boats B, Reserves R WHERE  S.sid=R.sid AND R.bid=B.bid AND B.color='green';

   SELECT S.sid FROM   Sailors S EXCEPT SELECT S.sid FROM   Sailors S, Reserves R WHERE  S.sid=R.sid; 
