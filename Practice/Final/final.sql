--- 1. Thêm một cột evaluation nvarchar(50) vào bảng Class 
alter table Class
add evaluation nvarchar(50)
go

--- 2.
create proc get_evaluation
@classID nvarchar(10), @evaluation nvarchar(50) output
as
begin
	declare @csdl nvarchar(20)
	set @csdl = 
				(select ID 
				from Subject 
				where Name = N'Cơ sở dữ liệu')
	declare @pass_number int
	select @pass_number  = count(*)
	from Result as r, Student as s
	where r.StudentID = s.ID and s.ClassID = @classID and r.SubjectID = @csdl and r.Mark >= 5 and r.Times <= 2

	declare @student_number int
	set @student_number = 
			(
				select count(*)
				from Student
				where ClassID = @classID
			)
	if @pass_number < @student_number
	begin
		set @evaluation = N'Không đạt'
	end
	else
	begin
		declare @sum int
		set @sum = 
			(
				select sum(r.Mark)
				from Result as r, Student as s
				where r.StudentID = s.ID and s.ClassID = @classID 
				and r.times >= all (
					select r1.times
					from Result r1
					where r1.StudentID = r.StudentID and r1.SubjectID = r.SubjectID
				)
			)
		declare @average real
		set @average = @sum / @student_number
		if (@average > 8)
		begin
			set @evaluation = N'Giỏi'
		end
		else
		begin
			set @evaluation = N'Khá'
		end
	end
	update Class 
	set evaluation = @evaluation
	where ID = @classID
end
go
declare @evaluation nvarchar(50)
exec get_evaluation 'LH000001  ', @evaluation output

--- Cau 3
declare c cursor for 
					(
						select c.ID
						from Class as c, Teacher as t
						where c.ManagerID = t.ID and t.Name = N'Nguyễn Văn An'
					)
open c
declare @id nvarchar(20)
fetch next from c into @id
while (@@FETCH_STATUS = 0)
begin
	declare @eval nvarchar(50)
	exec get_evaluation @id, @eval output
	fetch next from c into @id
end
close c
deallocate c