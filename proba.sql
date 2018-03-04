--CZEKOLADKI
--1a 
select * from czek.czekoladki;
--5a
select id_klienta,imie,nazwisko from czek.klienci;
--5b
select imie,nazwisko,miasto from czek.klienci Order by miasto,nazwisko;
--5c
select imie,nazwisko from czek.klienci where miasto='Katowice';
--5d
select * from czek.klienci where nazwisko Like 'W%';
--5e
select distinct miasto from czek.klienci;
--5f
select imie, nazwisko from czek.klienci where telefon IS NOT NULL; 
--5g
select id_zam,data_zam From czek.zamowienia where id_zam=54 And data_zam< DATE'2010-11-02';
--To_DATE('2003/07/09', 'yyyy/mm/dd')
--5h
select * from czek.zamowienia where id_klienta in (7,30,44,50);
--5i
SELECT  id_pudelka, nazwa, sztuk_w_magazynie FROM czek.pudelka
WHERE sztuk_w_magazynie BETWEEN 200 and 300;
--5j
SELECT nazwa FROM czek.czekoladki
WHERE rodzaj_czekolady = 'Mleczna' AND rodzaj_orzechow = 'Laskowe' OR
rodzaj_czekolady = 'Bia³a';
--5k
SELECT id_czek, koszt, koszt*1.2 AS nowa_cena FROM czek.czekoladki;
--5l
SELECT ile_zam, FLOOR(SYSDATE - data_zam) FROM czek.zamowienia; 
--5m
SELECT id_pudelka, nazwa, TO_CHAR(cena_pudelka * sztuk_w_magazynie, '99999999.99')|| ' z³'
FROM czek.pudelka;
--5n
SELECT id_zam, id_dostawcy, id_klienta, forma_zaplaty FROM czek.zamowienia
WHERE  TO_CHAR(data_zam, 'mm')='10' AND forma_zaplaty='p';

--6a
SELECT COUNT(*) AS liczba_klientow FROM czek.klienci;
--6b
SELECT COUNT(*) AS liczba_klientow FROM czek.klienci WHERE region = 'siedlecki';
--6c
select count(*) as liczba_czekoladek from czek.czekoladki where koszt<0.3 and rodzaj_nadzienia='Marcepan';
--6d
SELECT MAX(cena_pudelka) AS max_cena, MIN(cena_pudelka) AS min_cena
FROM czek.pudelka;
--6e
SELECT AVG(koszt) AS sredni_koszt FROM czek.czekoladki WHERE opis LIKE '%migda³%';
--6f
SELECT SUM(sztuk_w_magazynie) AS liczba_pudelek FROM czek.pudelka;
--6g
SELECT region, COUNT(*) 
FROM czek.klienci GROUP BY region ORDER BY region;
--6h
SELECT id_klienta, count (*) FROM czek.zamowienia GROUP BY id_klienta;
--6i
SELECT id_pudelka, SUM (l_sztuk) AS liczba_czekoladek FROM czek.o_pudelkach GROUP BY id_pudelka 
ORDER BY id_pudelka DESC;
--6j
SELECT id_zam, id_pudelka, ile_sztuk FROM czek.szczegolowe_zam WHERE id_zam 
BETWEEN 100 AND 105 ORDER BY id_zam, id_pudelka;
--6k
SELECT forma_zaplaty, COUNT (*) AS liczba_zamowien, CASE WHEN forma_zaplaty='p'
THEN 'op³acono przelewem' WHEN forma_zaplaty='g' THEN 'op³acono gotówk¹' 
WHEN forma_zaplaty='k' THEN 'op³acono kart¹' ELSE 'jeszcze nie ustalono' END
FROM czek.zamowienia GROUP BY forma_zaplaty; 
--6l
SELECT id_pudelka, SUM (l_sztuk) AS liczba_sztuk_w_pudelkach FROM czek.o_pudelka
GROUP BY id_pudelka HAVING SUM (l_sztuk)>=15;
--6m
SELECT miasto, COUNT (*) FROM czek.klienci GROUP BY miasto HAVING COUNT (*)>=3;
--6n
--liczbê zamówieñ zamawianych sposobem 1 zlo¿onych ka¿dego dnia
SELECT data_zam, COUNT (*) AS liczba_zam FROM czek.zamowienia WHERE sposob_zam=1 
GROUP BY  data_zam HAVING COUNT (*)>=2;
--inaczej
SELECT data_zam, COUNT (*) AS liczba_zam FROM czek.zamowienia WHERE data_zam
NOT IN (SELECT data_zam FROM czek.zamowienia WHERE sposob_zam<>1)   
GROUP BY  data_zam HAVING COUNT (*)>=2;
--6q
SELECT SUM(cena_pudelka*sztuk_w_magazynie) FROM czek.pudelka;
--6r
SELECT imie,nazwisko,telefon, CASE WHEN telefon IS NOT NULL THEN '+48' || telefon
ELSE 'brak' END AS telefon FROM czek.klienci;
--7a
SELECT id_pudelka FROM czek.pudelka JOIN czek.szczegolowe_zam USING (id_pudelka)
GROUP BY id_pudelka, nazwa HAVING nazwa LIKE 'K%' OR COUNT (*) >=5;
--inaczej
SELECT id_pudelka, FROM czek.pudelka WHERE nazwa LIKE 'K%' OR (SELECT COUNT (*) 
FROM czek.szczegolowe_zam WHERE id_pudelka=pudelka.id_pudelka)>=5;
--7b
SELECT id_zam, FROM czek.szczegolowe_zam WHERE ide_zam BETWEEN 40 AND 45 
GROUP BY id_zam HAVING SUM (ile_szztuk)>5; 
--7c
SELECT id_zam FROM czek.zamowienia WHERE id_klienta=54 AND id_zam NOT IN
(SELECT id_zam FROM czek.szczegolowe_zam WHERE id_pudelka LIKE 'PEAN');
--7d
SELECT k.imie ||' '||k.nazwisko, d.imie ||' '||,d.nazwisko 
FROM czek.klienci k JOIN czek.zamowienia z USING (id_klienta) JOIN czek.dostawcy d
USING (id_dostawcy); 
--7e
SELECT id_klienta,imie,nazwisko, COUNT (*) AS liczba_zamowien  FROM czek.zamowienia JOIN czek.klienci 
USING (id_klienta) GROUP BY id_klienta,imie,nazwisko;
--7f
SELECT czek.pudelka.nazwa, czek.czekoladki.nazwa, czek.o_pudelkach.l_sztuk FROM czek.pudelka JOIN czek.o_pudelkach
USING (id_pudelka) JOIN czek.czekoladki USING (id_czek);
--7g
SELECT czekoladki.nazwa FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka) JOIN czek.o_pudelkach 
USING (id_pudelka) JOIN czek.czekoladki USING (id_czek) WHERE id_zam=3;
--7h
SELECT id_zam,SUM(ile_sztuk*cena_pudelka) AS kwota_zamowienia FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka)
GROUP BY id_zam;
--7a'
SELECT rodzaj_orzechow, rodzaj_czekolady, koszt FROM czek.czekoladki WHERE koszt = (SELECT MAX(koszt) FROM czek.czekoladki);
-- 7a' inaczej
SELECT rodzaj_orzechow,rodzaj_czekolady, MAX(koszt) AS max_koszt FROM czek.czekoladki GROUP BY rodzaj_orzechow,rodzaj_czekolady;
--7b'
SELECT nazwa,opis_pudelka FROM czek.pudelka WHERE waga>(SELECT AVG(waga) FROM czek.pudelka);
--7c'
SELECT rodzaj_czekolady FROM czek.czekoladki GROUP BY rodzaj_czekolady HAVING AVG(koszt)>(SELECT AVG(koszt)FROM czek.czekoladki);
--7d'
SELECT nazwa FROM czek.czekoladki WHERE rodzaj_orzechow=(SELECT rodzaj_orzechow FROM czek.czekoladki WHERE id_czek='M14');
--7e'
SELECT id_klienta,nazwisko FROM czek.klienci WHERE id_klienta NOT IN (SELECT id_klienta FROM czek.zamowienia);
--7e' inaczej
SELECT id_klienta,nazwisko FROM czek.klienci LEFT JOIN czek.zamowienia USING (id_klienta) WHERE id_zam IS NULL;
--7f'
SELECT id_zam FROM czek.szczegolowe_zam JOIN czek.pudelka 
USING (id_pudelka) WHERE cena_pudelka=(SELECT MIN(cena_pudelka) FROM czek.pudelka);
--7g'
SELECT nazwa FROM czek.pudelka WHERE id_pudelka NOT IN (SELECT id_pudelka FROM czek.szczegolowe_zam);
--7g'inaczej
SELECT nazwa FROM czek.pudelka LEFT JOIN czek.szczegolowe_zam USING (id_pudelka) WHERE id_zam IS NULL; 
--7h'
SELECT id_czek, nazwa FROM czek.czekoladki WHERE id_czek IN (SELECT id_czek FROM czek.o_pudelkach);
--7i'
SELECT nazwa,koszt FROM czek.czekoladki WHERE koszt>(SELECT MAX(koszt) FROM czek.czekoladki 
WHERE rodzaj_czekolady='Mleczna');
--7j'
SELECT * FROM czek.zamowienia WHERE data_zam>(SELECT MAX(data_zam) FROM czek.zamowienia WHERE id_klienta=54);
--7k'
SELECT id_pudelka, id_czek FROM czek.o_pudelkach p WHERE l_sztuk=
(SELECT MAX(l_sztuk) FROM czek.o_pudelkach WHERE id_pudelka=p.id_pudelka);
--7l'
SELECT id_zam, nazwa FROM czek.szczegolowe_zam s JOIN czek.pudelka p ON s.id_pudelka=p.id_pudelka WHERE cena_pudelka= (SELECT MAX (cena_pudelka)
FROM czek.pudelka JOIN czek.szczegolowe_zam USING (id_pudelka) WHERE id_zam=s.id_zam);
--7m'
SELECT id_zam FROM czek.szczegolowe_zam GROUP BY id_zam HAVING COUNT(*)=(SELECT MAX(COUNT(*))
FROM czek.szczegolowe_zam GROUP BY id_zam);
--7n'
SELECT imie,nazwisko FROM czek.zamowienia JOIN czek.klienci 
USING (id_klienta) GROUP BY id_klienta,imie,nazwisko HAVING 
COUNT(id_zam)=(SELECT MAX(COUNT(id_zam)) FROM czek.zamowienia JOIN czek.klienci 
USING (id_klienta)GROUP BY id_klienta,imie,nazwisko);

--KWIATY
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