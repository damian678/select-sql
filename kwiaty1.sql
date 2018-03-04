--Baza kwiaty
--zadanie 8
--a
select numer_kat, nazwa_lac, nazwa_pol from kwiaty.katalog where nazwa_pol like 'Fikus%' OR  nazwa_pol like '%fikus%' AND podlewanie = 3;
--b
select sum(stan *cena) from kwiaty.magazyn;
--c
select sum(stan *cena) as wartosc from kwiaty.magazyn where numer_kat like '1%';
--d
select numer_kat,sztuk, data_zam from kwiaty.zamjed join kwiaty.zam using(id_zam) where data_zam =
(select  min(data_zam) from kwiaty.zam);
--e
select count(*) from kwiaty.katalog;
--f 
select count(id_zam), id_sklepu from kwiaty.zam group by id_sklepu having count(id_zam)=
(select max(count(id_zam)) from kwiaty.zam group by id_sklepu);
--g
select numer_kat from kwiaty.katalog where numer_kat not in (select numer_kat from kwiaty.zamjed) ;
--h
select numer_kat, nazwa_pol from kwiaty.katalog where numer_kat in (select numer_kat from kwiaty.zamjed);
--i
select nazwa, count(id_zam) from kwiaty.sklepy join kwiaty.zam using(id_sklepu) group by nazwa;
--j
select numer_kat, count(id_zam) from kwiaty.katalog join kwiaty.zamjed using(numer_kat) group by numer_kat 
having count(id_zam)>1;
--k
select temp, count(numer_kat) from kwiaty.katalog group by temp;
--l
select nazwa_pol, nazwa_lac from kwiaty.katalog where length(nazwa_lac)=(select max(length(nazwa_lac)) from kwiaty.katalog);
--m
select nazwa,sum( sztuk) from kwiaty.sklepy join kwiaty.zam using(id_sklepu) join kwiaty.zamjed using(id_zam) group by 
nazwa having sum(sztuk) = (select max(sum(sztuk)) from kwiaty.sklepy join kwiaty.zam 
using(id_sklepu) join kwiaty.zamjed using(id_zam) group by nazwa) ;
--n
select sum(sztuk), numer_kat, sum(stan), zrealizowane from kwiaty.zam join kwiaty.zamjed using(id_zam) join kwiaty.katalog 
using(numer_kat) join kwiaty.magazyn using (numer_kat) group by numer_kat,zrealizowane having sum(stan)>sum(sztuk) and zrealizowane = 'F';
--p
select nazwa, data_zam,transport, numer_kat, sum(sztuk) from kwiaty.sklepy join kwiaty.zam using(id_sklepu) join kwiaty.zamjed using(id_zam) 
where zrealizowane='F' and transport='Wynajêty' group by nazwa, data_zam,transport, numer_kat ; 
--q
select nazwa_pol, pielegnacja, stan from kwiaty.katalog join kwiaty.magazyn using (numer_kat) 
where nazwa_pol not like 'bluszcz' and stan>(select avg(stan) from kwiaty.magazyn) and pielegnacja = 1;
--r
select id_zam, miasto, sum(sztuk) from kwiaty.sklepy join kwiaty.zam using(id_sklepu)join kwiaty.zamjed using(id_zam) 
group by id_zam, miasto order by miasto;
--s
select nazwa, id_zam, data_zam from kwiaty.sklepy join kwiaty.zam using(id_sklepu) order by nazwa, data_zam;
--t
select sum(sztuk), to_char(data_zam, 'MONTH') from kwiaty.zamjed join kwiaty.zam using(id_zam) group by to_char(data_zam, 'MONTH') ;


