--Answers for Problem 2:
--1)
select distinct name 
from enroll e join course c on e.cno=c.cno
join student s on s.sno=e.sno
EXCEPT
select distinct name 
from enroll e join course c on c.dept='CSE' AND e.cno=c.cno
join student s on s.sno=e.sno ; 


--2)
select name, sum(grade)/count(*) from student s join enroll e on s.sno=e.sno or grade is Null group by name;


--3)
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

