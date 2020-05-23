create table Students (
sid int primary key,
	sname varchar(40));
create table Courses (
  cid int primary key,
	cname varchar(40),
	credits number(2));

create table Enrolled(
         sid int,
	 cid int,
        primary key(sid, cid),
	foreign key (sid) references Students,
	foreign key (cid) references Courses
);
