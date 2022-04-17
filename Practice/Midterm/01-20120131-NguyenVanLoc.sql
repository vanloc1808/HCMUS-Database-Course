--- Cau 1
create database DB_20120131
go
use DB_20120131
go

create table BaiBao 
(
	MaBB char(6),
	TenBB nvarchar(50),
	NgayDang datetime,
	MaTruong char(6),
	Hang char(1) check (Hang = 'A' or Hang = 'B' or Hang = 'C') default 'C',
	Reviewer char(6),
	primary key (MaBB, MaTruong)
)

create table TacGia 
(
	MaTruong char(6),
	MaTacGia char(6),
	TenTG nvarchar(20),
	cmnd char(20) unique,
	Phai nvarchar(10) check (Phai = N'Nam' or Phai = N'Nữ')
	primary key(MaTruong, MaTacGia)
)

create table ChiTietBaiBao
(
	MaBB char(6),
	MaTG char(6),
	MaTruong char(6)
	primary key(MaBB, MaTG, MaTruong)
)
go

alter table BaiBao
	add foreign key (MaTruong, Reviewer) references TacGia(MaTruong, MaTacGia)
go

alter table ChiTietBaiBao
	add foreign key (MaTruong, MaTG) references TacGia(MaTruong, MaTacGia)
go

alter table ChiTietBaiBao
	add foreign key (MaBB, MaTruong) references BaiBao(MaBB, MaTruong)
go

insert into BaiBao values ('BB1', N'Hệ thống tư vấn', '11/22/2012', 'TN', 'A', null)
insert into BaiBao values ('BB2', N'Hệ thống phân tác', '12/25/2012', 'TN', 'C', null)
go

insert into TacGia values ('TN', 'TGNa', N'Lê Nam', '1234567', N'Nam')
insert into TacGia values ('TN', 'TGVy', N'Hoàng Vy', '1234568', N'Nữ')
insert into TacGia values ('TN', 'TGHo', N'Gia Hồng', '1234569', N'Nữ')
insert into TacGia values ('TN', 'TGNu', N'Kim Nhung', '1234570', N'Nữ')
go

insert into ChiTietBaiBao values ('BB1', 'TGVy', 'TN')
insert into ChiTietBaiBao values ('BB1', 'TGHo', 'TN')
insert into ChiTietBaiBao values ('BB2', 'TGNa', 'TN')
insert into ChiTietBaiBao values ('BB2', 'TGHo', 'TN')
go

update BaiBao
set Reviewer = 'TGNa'
where MaBB = 'BB1'
update BaiBao
set Reviewer = 'TGNu'
where MaBB = 'BB2'
go

--- Cau 2
use QLDT1
go

select distinct g.MAGV, g.HOTEN
from GIAOVIEN as g, DETAI as d, THAMGIADT as t, BOMON as b
where (g.MABM = b.MABM) and (d.GVCNDT = b.TRUONGBM) and (d.MADT = t.MADT) and (t.MAGV = g.MAGV)