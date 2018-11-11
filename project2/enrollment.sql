 CREATE TABLE student(
 	sno varchar(10) PRIMARY KEY, 
 	name varchar(20), 
 	dept varchar(10));

 CREATE TABLE course(
 	cno varchar(5) PRIMARY KEY, 
 	dept varchar(10));

 CREATE TABLE enroll(
 	cno varchar(5) REFERENCES course(cno), 
 	sno varchar(10) REFERENCES student(sno), 
 	grade numeric(3,2), 
 	PRIMARY KEY (cno, sno));

	
insert into student
values (50200437,'Manvijay','CSE'),(50200426,'Kartik','STA'),(50200401,'Shubham','CSE'), (50200438, 'Akshat', 'CBE'), (50200439,'Dipen', 'CSE');

insert into enroll
values (101,50200437,4.0), (460,50200437,4.0), (305,50200437,2.5), (220,50200426,4.0), (315,50200426,3.5), (101,50200401,4.0), (102,50200401,2.5), (101,50200438,3.0), (101,50200439,4.0);

	
insert into course
values (101,'CSE'),(305,'CSE'),(460,'CSE'),(102,'ECE'),(215,'ECE'),(315,'STA'),(220,'MECH');

Answers:
1)
select distinct name 
from enroll e join course c on e.cno=c.cno
join student s on s.sno=e.sno
EXCEPT
select distinct name 
from enroll e join course c on c.dept='CSE' AND e.cno=c.cno
join student s on s.sno=e.sno ; 


2)
select name, sum(grade)/count(*) from student s join enroll e on s.sno=e.sno or grade is Null group by name;


3)
create view enrolledStudents as
select e.cno, Cast (count(*) as numeric(3,2))
from enroll e join course c on e.cno=c.cno
group by e.cno;

create view checkDepartment as
select e.cno, Cast (count(*) as numeric(3,2))
from course c join enroll e on c.cno= e.cno
join student s on s.dept<>c.dept and s.sno=e.sno
group by e.cno;

create view requiredCourses as 
select cd.cno, cd.count as fromSameDept, es.count as totalEnrolled
from checkDepartment cd join enrolledStudents es on cd.cno=es.cno
where cast(es.count/cd.count as numeric(3,2))<2;

select dept, count(*)
from requiredCourses rc join course c on rc.cno=c.cno
group by dept;

