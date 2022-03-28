create database NVL
go

use NVL 
go

create table NhanVien
(
	MaNV char(8),
	TenNV nvarchar(50) unique,
	MaNVQL char(8),
	Phai nvarchar(4) check (Phai = N'Nam' or Phai = N'Nữ'),
	primary key (MaNV)
)
go

create table MayTinh 
(
	MaMT char(8),
	TenMT varchar(20),
	MaPM char(8),
	TinhTrang bit,
	primary key (MaMT, MaPM)
)
go

alter table MayTinh
	add constraint C_MT
	unique (MaPM, TenMT)
go

create table PhongMay
(
	MaPhong char(8),
	TenPhong varchar(50),
	MayChu char(8),
	MaNVQL char(8),
	primary key (MaPhong)
)	
go

alter table PhongMay
	add foreign key (MayChu, MaPhong) references MayTinh(MaMT, MaPM)
go

alter table NhanVien
	add foreign key (MaNVQL) references NhanVien(MaNV)

alter table PhongMay
	add foreign key (MaNVQL) references NhanVien(MaNV)

alter table MayTinh
	add foreign key (MaPM) references PhongMay(MaPhong)
go

insert into NhanVien values ('NHVI0001', N'Nguyễn Văn A', null, N'Nam')
insert into NhanVien values ('NHVI0002', N'Trần Thị B', null, N'Nữ')
insert into NhanVien values ('NHVI0003', N'Lê Văn C', null, N'Nam')
insert into NhanVien values ('NHVI0004', N'Lý Thị D', null, N'Nữ')
update NhanVien
set MaNVQL = 'NHVI0004' 
where MaNV = 'NHVI0001' or MaNV = 'NHVI0002' or MaNV = 'NHVI0003'
update NhanVien
set MaNVQL = 'NHVI0001' 
where MaNV = 'NHVI0004'
go

insert into PhongMay values('PHMA0001', 'Phong may 1', null, 'NHVI0003')
insert into PhongMay values('PHMA0002', 'Phong may 2', null, 'NHVI0004')
insert into PhongMay values('PHMA0003', 'Phong may 3', null, 'NHVI0001')
insert into PhongMay values('PHMA0004', 'Phong may 4', null, 'NHVI0002')
go

insert into MayTinh values('MATI0001', 'Acer', 'PHMA0001', 1)
insert into MayTinh values('MATI0002', 'Lenovo', 'PHMA0001', 0)
insert into MayTinh values('MATI0001', 'Acer', 'PHMA0002', 0)
insert into MayTinh values('MATI0003', 'Asus', 'PHMA0003', 1)
insert into MayTinh values('MATI0005', 'HP', 'PHMA0004', 1)
go

update PhongMay
set MayChu = 'MATI0002' 
where MaPhong = 'PHMA0001'
update PhongMay
set MayChu = 'MATI0001' 
where MaPhong = 'PHMA0002'
update PhongMay
set MayChu = 'MATI0003' 
where MaPhong = 'PHMA0003'
update PhongMay
set MayChu = 'MATI0005' 
where MaPhong = 'PHMA0004'
go
