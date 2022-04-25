--- Dem so de tai tham gia cua tung giang vien
select g.MAGV as MA_GV, count(distinct t.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g left join THAMGIADT as t on t.MAGV = g.MAGV
group by g.MAGV

--- Dem so giang vien tham gia tung de tai
select d.MADT as MA_DE_TAI, count(distinct t.MAGV) as SO_GV
from DETAI as d left join THAMGIADT as t on t.MADT = d.MADT
group by d.MADT

--- Q27: Cho biet so luong giao vien va tong luong cua ho
select count(g.MAGV) as SO_GV, sum(g.LUONG) as TONG_LUONG
from GIAOVIEN as g

---Q28: Cho biet so luong giao vien va luong trung binh cua tung bo mon
select g.MABM, b.TENBM, count(g.MAGV) as SO_GV
from GIAOVIEN as g join BOMON as b on g.MABM = b.MABM
group by g.MABM, b.TENBM

---Q29: Cho biet ten chu de va so luong de tai thuoc ve chu de do
select c.MACD, c.TENCD, count(d.MADT) as SO_LUONG_DE_TAI
from CHUDE as c left join DETAI as d on c.MACD = d.MACD
group by c.MACD, c.TENCD

---Q30: Cho biet ten giao vien va so luong de tai giao vien do tham gia
select g.MAGV as MA_GV, g.HOTEN as HO_TEN, count(distinct t.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g left join THAMGIADT as t on t.MAGV = g.MAGV
group by g.MAGV, g.HOTEN

---Q31: Cho biet ten giao vien va so luong de tai ma giao vien do lam chu nhiem
select g.MAGV, g.HOTEN, count(distinct d.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g left join DETAI as d on g.MAGV = d.GVCNDT
group by g.MAGV, g.HOTEN

---Q32: Voi moi giao vien cho ten giao vien va so nguoi than cua giao vien do
select g.MAGV, g.HOTEN, count(distinct n.TEN) as SO_LUONG_NGUOI_THAN
from GIAOVIEN as g left join NGUOITHAN as n on g.MAGV = n.MAGV
group by g.MAGV, g.HOTEN

---Q33: Cho biet ten nhung giao vien tham gia tu 3 de tai tro len
select g.MAGV as MA_GV, g.HOTEN as HO_TEN, count(distinct t.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g left join THAMGIADT as t on t.MAGV = g.MAGV
group by g.MAGV, g.HOTEN
having count(distinct t.MADT) >= 3

---Q34: Cho biet so luong giao vien da tham gia vao de tai Ung dung hoa hoc xanh
select d.MADT as MA_DE_TAI, d.TENDT as TEN_DE_TAI, count(distinct t.MAGV) as SO_GV
from DETAI as d left join THAMGIADT as t on t.MADT = d.MADT
group by d.MADT, d.TENDT
having d.TENDT = N'Ứng dụng hóa học xanh'

---Q35: Cho biet muc luong cao nhat cua cac giang vien
select max(g.LUONG) as LUONG_CAO_NHAT
from GIAOVIEN as g

---Q36: Cho biet nhung giao vien co luong lon nhat
select g.MAGV, g.HOTEN
from GIAOVIEN as g
where g.LUONG = 
				(select max(gv.LUONG)
					from GIAOVIEN as gv)

---Q37: Cho biet luong cao nhat trong bo mon HTTT
select max(g.LUONG) as LUONG_CAO_NHAT
from GIAOVIEN as g
where g.MABM = 'HTTT'

---Q38: Cho biet ten giao vien lon tuoi nhat cua bo mon He thong thong tin
select g.MAGV, g.HOTEN
from GIAOVIEN as g join BOMON as b on g.MABM = b.MABM
where year(g.NGSINH) = 
						(select min(year(gv.NGSINH)) 
						from GIAOVIEN as gv join BOMON as b on gv.MABM = b.MABM
						where b.TENBM = N'Hệ thống thông tin')
	and b.TENBM = N'Hệ thống thông tin'


---Q39: Cho biet ten giao vien nho tuoi nhat khoa Cong nghe thong tin
select g.MAGV, g.HOTEN
from (GIAOVIEN as g join BOMON as b on g.MABM = b.MABM) join KHOA as k on b.MAKHOA = k.MAKHOA
where year(g.NGSINH) = (select max(year(gv.NGSINH)) 
						from (GIAOVIEN as gv join BOMON as b on gv.MABM = b.MABM) join KHOA as k on b.MAKHOA = k.MAKHOA
						where k.TENKHOA = N'Công nghệ thông tin')
	and k.TENKHOA = N'Công nghệ thông tin'

---Q40: Cho biet ten giao vien va ten khoa cua giao vien co luong cao nhat
select g.MAGV, g.HOTEN, k.TENKHOA
from (GIAOVIEN as g join BOMON as b on g.MABM = b.MABM) join KHOA as k on b.MAKHOA = k.MAKHOA
where g.LUONG = 
				(select max(gv.LUONG)
					from GIAOVIEN as gv)

---Q41: Cho biet nhung giao vien co luong lon nhat trong bo mon cua ho
select g.MAGV, g.HOTEN, b.TENBM
from GIAOVIEN as g join BOMON as b on g.MABM = b.MABM
where g.LUONG = 
					(select max(gv.LUONG)
					from GIAOVIEN as gv join BOMON as bm on (gv.MABM = bm.MABM)
					where gv.MABM = g.MABM)

---Q42: Cho biet ten nhung de tai ma giao vien Nguyen Hoai An chua tham gia
select distinct d.MADT, d.TENDT
from DETAI as d left join THAMGIADT as t on d.MADT = t.MADT, GIAOVIEN as g, GIAOVIEN as nha
where nha.HOTEN = N'Nguyễn Hoài An' and g.MAGV = t.MAGV and nha.MAGV not in 
														(
															select gv.MAGV
															from GIAOVIEN as gv join THAMGIADT as tg on gv.MAGV = tg.MAGV
															where tg.MADT = d.MADT
														)

---Q43: Cho biet ten nhung de tai giao vien Nguyen Hoai An chua tham gia, xuat ra ten de tai, chu nhiem de tai.
select distinct d.MADT, d.TENDT, cndt.HOTEN as CNDT
from DETAI as d left join THAMGIADT as t on d.MADT = t.MADT, GIAOVIEN as g, GIAOVIEN as nha, GIAOVIEN as cndt
where nha.HOTEN = N'Nguyễn Hoài An' and g.MAGV = t.MAGV and nha.MAGV not in 
														(
															select gv.MAGV
															from GIAOVIEN as gv join THAMGIADT as tg on gv.MAGV = tg.MAGV
															where tg.MADT = d.MADT
														)
	and cndt.MAGV = d.GVCNDT

---Q44: Cho biet ten nhung giao vien khoa Cong nghe thong tin ma chua tham gia de tai nao
select distinct g.MAGV, g.HOTEN
from GIAOVIEN as g, BOMON as b, KHOA as k 
where g.MABM = b.MABM and b.MAKHOA = k.MAKHOA and k.TENKHOA = N'Công nghệ thông tin' 
	and g.MAGV not in 
					(
						select distinct gv.MAGV
						from GIAOVIEN as gv join THAMGIADT as t on gv.MAGV = t.MAGV
					)

---Q45: Tim nhung giao vien khong tham gia bat ky de tai nao
select distinct g.MAGV, g.HOTEN
from GIAOVIEN as g
where g.MAGV not in 
					(
						select distinct gv.MAGV
						from GIAOVIEN as gv join THAMGIADT as t on gv.MAGV = t.MAGV
					)

---Q46: Cho biet nhung giao vien co luong lon hon luong cua giao vien "Nguyen Hoai An"
select g.MAGV, g.HOTEN
from GIAOVIEN as g
where g.LUONG > 
				(
					select nha.LUONG
					from GIAOVIEN as nha
					where nha.HOTEN = N'Nguyễn Hoài An'
				)

---Q47: Tim nhung truong bo mon tham gia toi thieu 1 de tai
select distinct g.MAGV, g.HOTEN
from GIAOVIEN as g, BOMON as b 
where g.MAGV = b.TRUONGBM 
	and g.MAGV in 
				(
					select gv.MAGV
					from GIAOVIEN as gv join THAMGIADT as t on gv.MAGV = t.MAGV
				)

---Q48: Tim giao vien trung ten va cung gioi tinh voi giao vien khac trong cung bo mon
select g.HOTEN, g.PHAI
from GIAOVIEN as g join BOMON as b on g.MABM = b.MABM
where g.HOTEN in
				(
					select gv.HOTEN
					from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
					where bm.MABM = b.MABM and g.MAGV != gv.MAGV
				)
	and g.PHAI in
				(
					select gv.PHAI
					from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
					where bm.MABM = b.MABM and g.MAGV != gv.MAGV
				)

---Q49: Tim nhung giao vien co luong lon hon luong cua it nhat mot giao vien thuoc bo mon "Cong nghe phan mem"
select g.MAGV, g.HOTEN
from GIAOVIEN as g join BOMON as b on g.MABM = b.MABM
where g.LUONG >
				(
					select min(gv.LUONG)
					from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
					where bm.TENBM = N'Công nghệ phần mềm'
				)

---Q50: Tim nhung giao vien co luong lon hon luong cua tat ca giao vien thuoc bo mon 'He thong thong tin'
select g.MAGV, g.HOTEN
from GIAOVIEN as g join BOMON as b on g.MABM = b.MABM
where g.LUONG >
				(
					select max(gv.LUONG)
					from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
					where bm.TENBM = N'Hệ thống thông tin'
				)

---Q51: Cho biet ten khoa co dong giao vien nhat
select k.MAKHOA, k.TENKHOA, count(g.MAGV) as SO_GV
from (GIAOVIEN as g join BOMON as b on g.MABM = b.MABM) join KHOA as k on b.MAKHOA = k.MAKHOA
group by k.MAKHOA, k.TENKHOA
having count(g.MAGV) =
					(
						select max(SOGV)
						from
						(
							select count(gv.MAGV) as SOGV
							from (GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM) join KHOA as kh on bm.MAKHOA = kh.MAKHOA
							group by kh.MAKHOA, kh.TENKHOA
						) T
					)

---Q52: Cho biet ho ten cua giao vien chu nhiem nhieu de tai nhat
select g.MAGV, g.HOTEN, count(d.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g, DETAI as d
where g.MAGV = d.GVCNDT
group by g.MAGV, g.HOTEN
having count(d.MADT) = 
					(
						select max(SLDT)
						from
						(
							select count(dt.MADT) as SLDT
							from (GIAOVIEN as gv join DETAI as dt on gv.MAGV = dt.GVCNDT)
							group by gv.MAGV
						) T
					)

---Q53: Cho biet ma bo mon co nhieu giao vien nhat
select b.MABM, b.TENBM, count(g.MAGV) as SO_LUONG_GIAO_VIEN
from GIAOVIEN as g join BOMON as b on g.MABM = b.MABM
group by b.MABM, b.TENBM
having count(g.MAGV) = 
					(
						select max(SGV)
						from
						(
							select count(gv.MAGV) as SGV
							from GIAOVIEN as gv join BOMON as bm on gv.MABM = bm.MABM
							group by bm.MABM
						) T
					)

---Q54: Cho biet ten giao vien va ten bo mon cua giao vien tham gia nhieu de tai nhat
select g.MAGV, g.HOTEN, b.MABM, b.TENBM, count(distinct t.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g join THAMGIADT as t on g.MAGV = t.MAGV, BOMON as b
where g.MABM = b.MABM
group by g.MAGV, g.HOTEN, b.MABM, b.TENBM
having count(distinct t.MADT) = 
								(
									select max(SLDT)
									from
									(
										select count(distinct tg.MADT) as SLDT
										from GIAOVIEN as gv join THAMGIADT as tg on gv.MAGV = tg.MAGV
										group by gv.MAGV
									) T
								)

---Q55: Cho biet ten giao vien tham gia nhieu de tai nhat cua bo mon HTTT
select g.MAGV, g.HOTEN, count(distinct t.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g join THAMGIADT as t on g.MAGV = t.MAGV, BOMON as b
where g.MABM = b.MABM and b.MABM = 'HTTT'
group by g.MAGV, g.HOTEN
having count(distinct t.MADT) = 
								(
									select max(SLDT)
									from
									(
										select count(distinct tg.MADT) as SLDT
										from GIAOVIEN as gv join THAMGIADT as tg on gv.MAGV = tg.MAGV
										group by gv.MAGV
									) T
								)

---Q56: Cho biet ten giao vien va ten bo mon cua giao vien co nhieu nguoi than nhat
select g.MAGV, g.HOTEN, b.MABM, b.TENBM, count(n.TEN)
from GIAOVIEN as g join NGUOITHAN as n on g.MAGV = n.MAGV, BOMON as b
where g.MABM = b.MABM
group by g.MAGV, g.HOTEN, b.MABM, b.TENBM
having count(n.TEN) = 
					(
						select max(SNT)
						from
						(
							select count(nt.TEN) as SNT
							from GIAOVIEN as gv join NGUOITHAN as nt on gv.MAGV = nt.MAGV
							group by gv.MAGV
						) T
					)

---Q57: Cho biet ten truong bo mon chu nhiem nhieu de tai nhat
select g.MAGV, g.HOTEN, count(d.MADT) as SO_LUONG_DE_TAI
from GIAOVIEN as g join DETAI as d on g.MAGV = d.GVCNDT, BOMON as b
where g.MAGV = b.TRUONGBM
group by g.MAGV, g.HOTEN
having  count(d.MADT) = 
					(
						select max(SLDT)
						from
						(
							select count(dt.MADT) as SLDT
							from GIAOVIEN as gv join DETAI as dt on gv.MAGV = dt.GVCNDT
							group by gv.MAGV
						) T
					)

		