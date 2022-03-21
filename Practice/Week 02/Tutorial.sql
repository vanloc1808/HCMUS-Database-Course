--GiaoVien(MAGV, TENGV, NGAYSINH, BMGV)
--BoMon(MABM, TENBM)

create database QLGV
go

use QLGV
go

create table GiaoVien
(
	MaGV char(4),
	TenGV nvarchar(50),
	NgaySinh datetime,
	BMGV char(4)

	primary key (MaGV)
)
go

alter table GiaoVien
alter column TenGV nvarchar(60)
go

create table BoMon
(
	MaBM char(4),
	TenBM nvarchar(50)

	primary key (MaBM)
)
go


alter table GiaoVien
add foreign key (BMGV) references BoMon(MaBM)
go

insert into GiaoVien values ('GV01', N'Nguyễn Văn A', '09/20/1970', NULL)
insert into GiaoVien(TenGV, NgaySinh, MaGV, BMGV) values (N'Trần Văn B', '08/18/1970', 'GV02', NULL)
insert into GiaoVien(MaGV, TenGV, NgaySinh) values('GV03', N'Lê Thị C', '03/21/1980')
insert into BoMon values('BM01', N'Khoa học máy tính')
insert into BoMon values('BM02', N'Công nghệ phần mềm')
insert into BoMon values('BM03', N'Hệ thống thông tin')
update GiaoVien set BMGV = 'BM02' where MaGV = 'GV01'
update GiaoVien set BMGV = 'BM03' where MaGV = 'GV02'
update GiaoVien set BMGV = 'BM01' where MaGV = 'GV03'



