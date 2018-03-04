--Baza kwiaty
--1
select numer_kat,nazwa_lac,nazwa_pol from kwiaty.katalog where nazwa_pol like 'Fikus%' and podlewanie=3 or nazwa_pol like
'%fikus%' and podlewanie=3;
--2
select sum((stan* cena)) from kwiaty.magazyn where numer_kat like '1%';
select stan*cena from kwiaty.magazyn where numer_kat like '1%';
--3
select distinct podlewanie from kwiaty.katalog;
--4
select numer_kat,sum(sztuk) from kwiaty.zamjed join kwiaty.zam using(id_zam)where 
data_zam=(select min(data_zam) from kwiaty.zam)  group by numer_kat,data_zam;
--5
select numer_kat,sum(sztuk),stan from kwiaty.zamjed join kwiaty.katalog using(numer_kat)
join kwiaty.magazyn using(numer_kat)join kwiaty.zam using(id_zam) group by numer_kat,stan,zrealizowane having sum(sztuk)>stan and zrealizowane='F';
--6

--7
select temp,sum(stan) from kwiaty.katalog join kwiaty.magazyn using(numer_kat) group by temp;
--8
select nazwa,sum(sztuk) from kwiaty.sklepy join kwiaty.zam using(id_sklepu) join kwiaty.zamjed using(id_zam) group by nazwa
having sum(sztuk)=(select max(sum(sztuk)) from kwiaty.sklepy join kwiaty.zam using(id_sklepu) join kwiaty.zamjed using(id_zam) group by nazwa);
--9
select nazwa,data_zam,numer_kat,sztuk from kwiaty.zamjed join kwiaty.zam using(id_zam) join kwiaty.sklepy using(id_sklepu)
where zrealizowane='F' and transport='Wynajêty';
--10
select count(*) from kwiaty.katalog;
--11
select nazwa_pol from kwiaty.katalog join kwiaty.magazyn using(numer_kat) where nazwa_pol not like 'Bluszcz%' 
and stan> (select avg(stan) from kwiaty.magazyn) and pielegnacja=1;
--12
select nazwa_lac,nazwa_pol from kwiaty.katalog where length(nazwa_lac)=(select (max(length(nazwa_lac))) from kwiaty.katalog);
--13
select id_zam,miasto,sum(sztuk) from kwiaty.zamjed join kwiaty.zam using(id_zam) join kwiaty.sklepy using (id_sklepu)group by id_zam,miasto
order by miasto;
--14
select nazwa,id_zam,data_zam from kwiaty.sklepy join kwiaty.zam using(id_sklepu) order by nazwa,data_zam;
--15
select to_char(data_zam,'MONTH'),count(*) from kwiaty.zam group by to_char(data_zam,'MONTH');
--16
select numer_kat,sum(sztuk),data_zam from kwiaty.zamjed join kwiaty.zam using(id_zam)
where to_char(data_zam,'dd')=22 or to_char(data_zam,'dd')=25 group by numer_kat,data_zam;
--17
select nazwa_lac as nazwa_lacinska,to_char(stan*cena,'9999,99') as wartosc from kwiaty.katalog join kwiaty.magazyn using(numer_kat);
--18
select * from kwiaty.katalog where nazwa_pol like '%a';
--19
select * from kwiaty.katalog join kwiaty.magazyn using (numer_kat) where cena>5;
--20
select numer_kat,cena*stan from kwiaty.magazyn;
--21
select nazwa,substr(nazwa,5,5) from kwiaty.sklepy;
--22
select id_zam,trunc(months_between(sysdate,data_zam))as liczba_miesiecy from kwiaty.zam;
--23
select count(*) from kwiaty.sklepy where miasto='Lublin';
--24
select distinct miasto from kwiaty.sklepy;
--25
select id_sklepu from kwiaty.sklepy where kod like '0%9';
--26
select numer_kat from kwiaty.magazyn where cena>(select cena from kwiaty.katalog
join kwiaty.magazyn using(numer_kat) where nazwa_pol='Adiantum Fragrans');
--27
select numer_kat from kwiaty.magazyn join kwiaty.katalog using(numer_kat) where stan>15 or pielegnacja=1;
--28
select id_sklepu from kwiaty.sklepy join kwiaty.zam using (id_sklepu) group by id_sklepu,miasto having miasto='Lublin' and count(*)<=5;
--29
select id_zam,sum(wartosc) from kwiaty.zamjed join kwiaty.zam using(id_zam) group by id_zam,data_zam 
having sum(wartosc) between 100 and 200 and data_zam>'02/01/01';
--30
select numer_kat,sum(sztuk) from kwiaty.zamjed join kwiaty.katalog using(numer_kat) 
group by numer_kat,temp having sum(sztuk)>=2 and temp=1;
--31
select power(5,12) from dual;
--32
select sqrt(25) from dual;
--33
select to_char(sysdate +145,'dd/mm/yyyy') as data_za_145_dni from dual;
--34
select to_char(sysdate+300,'MONTH') as miesiac_za_300_dni from dual;
--35
select to_char(to_date('2007/08/12','yy/mm/dd'),'DAY') from dual;
--36
select to_char(sysdate+216,'dd') from dual;

select numer_kat from kwiaty.zamjed join kwiaty.katalog using(numer_kat) where temp=1 group by numer_kat having sum(sztuk)>=2;

select nazwa_pol from kwiaty.katalog join kwiaty.magazyn using (numer_kat) where nazwa_pol not like 'Bluszcz' and stan>(select avg(stan) from kwiaty.magazyn) and pielegnacja=1;

select numer_kat,sum(sztuk),stan from kwiaty.zamjed join kwiaty.katalog using(numer_kat) join kwiaty.magazyn
using(numer_kat) join kwiaty.zam using(id_zam) where zrealizowane='F' group by numer_kat,stan having sum(sztuk)>stan;

select id_sklepu from kwiaty.sklepy join kwiaty.zam using(id_sklepu) where miasto='Lublin' group by id_sklepu having count(*)<=5;
select id_zam from kwiaty.zamjed join kwiaty.zam using(id_zam) where data_zam>'02/01/01' group by id_zam having sum(wartosc) >200
and sum(wartosc)<300 ;

select numer_kat from kwiaty.zamjed join kwiaty.katalog using(numer_kat) where temp=1 group by numer_kat having sum(sztuk)>=2;