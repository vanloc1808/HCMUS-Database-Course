create database Phong
go

use Phong
go

create table Truong
(
	MaTruong char(5),
	TenTruong nvarchar(70)

	primary key (MaTruong)
)
go

create table DayNha
(
	MaDay char(5),
	MaTruong char(5),
	TenDay nvarchar(50)

	primary key (MaDay, MaTruong)
)
go

create table Phong
(
	MaPhong char(5),
	MaDay char(5),
	MaTruong char(5),
	MaPhongQuanLy char(5)

	primary key (MaPhong, MaDay, MaTruong)
)
go

alter table DayNha
add foreign key (MaTruong) references Truong(MaTruong)
go

alter table Phong
add foreign key (MaDay, MaTruong) references DayNha(MaDay, MaTruong)
go

alter table Phong
add foreign key (MaPhongQuanLy, MaDay, MaTruong) references Phong(MaPhong, MaDay, MaTruong)
go

insert into Truong values('TR001', N'Trường ĐH Khoa học Tự nhiên, ĐHQG-HCM')
insert into Truong values('TR002', N'Trường ĐH Khoa học Xã hội và Nhân văn, ĐHQG-HCM')
insert into Truong values('TR003', N'Trường ĐH Quốc tế, ĐHQG-HCM')
insert into Truong values('TR004', N'Trường ĐH Ngoại thương')
go

insert into DayNha values('DN001', 'TR001', N'Dãy nhà 1 Trường ĐH KHTN')
insert into DayNha values('DN002', 'TR001', N'Dãy nhà 2 Trường ĐH KHTN')
insert into DayNha values('DN001', 'TR002', N'Dãy nhà 1 Trường ĐH KHXH&NV')
insert into DayNha values('DN004', 'TR003', N'Dãy nhà 4 Trường ĐH QT')
go

insert into Phong values('PH002', 'DN001', 'TR001', 'PH002')
insert into Phong values('PH001', 'DN001', 'TR001', 'PH002')
insert into Phong values('PH007', 'DN002', 'TR001', 'PH007')
insert into Phong values('PH004', 'DN002', 'TR001', 'PH007')
go
