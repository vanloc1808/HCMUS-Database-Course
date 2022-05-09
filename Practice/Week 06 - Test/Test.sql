--- Cau 1:
select distinct gv1.MAGV as magv1, gv2.MAGV as magv2
from GIAOVIEN as gv1, GIAOVIEN as gv2
where gv1.MAGV != gv2.MAGV and gv1.NGSINH = gv2.NGSINH

--- Cau 2:
select g.MAGV, g.HOTEN
from GIAOVIEN as g, BOMON as b, KHOA as k
where g.MABM = b.MABM and b.MAKHOA = k.MAKHOA and k.MAKHOA = 'CNTT'
	and g.MAGV not in 
					(
						select t.MAGV
						from DETAI as d, THAMGIADT as t
						where d.GVCNDT = k.TRUONGKHOA and d.MADT = t.MADT
					)

--- Cau 3:
select g.MAGV, g.HOTEN
from GIAOVIEN as g, BOMON as b, KHOA as cntt, KHOA as cnsh, DETAI as d, THAMGIADT as t
where g.MABM = b.MABM and b.MAKHOA = cntt.MAKHOA and cntt.MAKHOA = 'CNTT' --- giao vien khoa CNTT
	and cnsh.MAKHOA = 'CNSH' and d.GVCNDT = cnsh.TRUONGKHOA --- de tai do truong khoa CNSH chu tri
	and d.MADT = t.MADT and t.MAGV = g.MAGV
group by g.MAGV, g.HOTEN
having count(distinct t.MADT) >= all (
								select count(distinct t1.MADT)
								from GIAOVIEN as g1, BOMON as b1, KHOA as cntt1, KHOA as cnsh1, DETAI as d1, THAMGIADT as t1
								where g1.MABM = b1.MABM and b1.MAKHOA = cntt1.MAKHOA and cntt1.MAKHOA = 'CNTT' --- giao vien khoa CNTT
									and cnsh1.MAKHOA = 'CNSH' and d1.GVCNDT = cnsh1.TRUONGKHOA --- de tai do truong khoa CNSH chu tri
									and d1.MADT = t1.MADT and t1.MAGV = g1.MAGV
								group by g1.MAGV
							)

--- Cau 4:
select b.MABM, g.MAGV
from (GIAOVIEN as g right join BOMON as b on g.MABM = b.MABM), THAMGIADT as t
where g.MAGV = t.MAGV
group by b.MABM, g.MAGV
having count(distinct t.MADT) >= all
							(
								select count(distinct t1.MADT)
								from GIAOVIEN as g1, BOMON as b1, THAMGIADT as t1
								where g1.MABM = b1.MABM and g1.MAGV = t1.MAGV and b1.MABM = b.MABM
								group by b1.MABM, g1.MAGV
							)
order by b.MABM