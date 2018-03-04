SELECT *FROM czek.czekoladki;
--2a
SELECT id_klienta,imie,nazwisko FROM czek.klienci;
--2b
SELECT * FROM czek.klienci;
--2c
SELECT nazwisko,imie,miasto FROM czek.klienci ORDER BY miasto,nazwisko;
--2d
SELECT imie || ' ' || nazwisko AS KLIENT,'ul. '||ulica||', '|| kod || ' ' ||miasto AS ADRES FROM czek.klienci;
--2e
SELECT imie,nazwisko FROM czek.klienci WHERE miasto='Katowice';
SELECT imie,nazwisko FROM czek.klienci WHERE miasto LIKE 'Katowice';
--2f
SELECT * FROM czek.klienci WHERE nazwisko LIKE 'W%';
--2g
SELECT DISTINCT miasto FROM czek.klienci;
--2h
SELECT nazwisko,imie FROM czek.klienci WHERE telefon IS NOT NULL;
--2i
SELECT id_zam, data_zam FROM czek.zamowienia WHERE id_klienta=54 AND data_zam< DATE '2002-10-10';
--2j
SELECT DISTINCT sposob_zam AS sposoby_zamowien FROM czek.zamowienia;
--2k
SELECT * FROM czek.zamowienia WHERE id_klienta IN (7,30,44,50);
--2l
SELECT id_pudelka,nazwa,waga,sztuk_w_magazynie FROM czek.pudelka WHERE waga>1 OR cena_pudelka<15 ORDER BY waga;
--2m
SELECT id_pudelka,nazwa, sztuk_w_magazynie FROM czek.pudelka WHERE sztuk_w_magazynie BETWEEN 200 AND 300;
--2n
SELECT DISTINCT rodzaj_czekolady,rodzaj_orzechow,rodzaj_nadzienia FROM czek.czekoladki;
--2o
SELECT nazwa FROM czek.czekoladki WHERE rodzaj_czekolady = 'Mleczna' AND rodzaj_orzechow='Laskowe' OR rodzaj_czekolady='Bia³a';
--2p
SELECT nazwa FROM czek.czekoladki WHERE rodzaj_czekolady='Mleczna' AND rodzaj_nadzienia='Marcepan' 
OR rodzaj_czekolady='Bia³a' AND rodzaj_nadzienia='Marcepan'; 
SELECT nazwa FROM czek.czekoladki WHERE rodzaj_czekolady IN ('Mleczna','Bia³a') AND rodzaj_nadzienia='Marcepan';
--2q
SELECT id_czek,nazwa,koszt,koszt*1.2 AS nowy_koszt FROM czek.czekoladki;
--------------------------------------------------------------------------------
--3a
SELECT id_zam,trunc(sysdate-data_zam) AS liczba_dni FROM czek.zamowienia;
SELECT id_zam,trunc((SELECT sysdate FROM dual)-data_zam) AS liczba_dni FROM czek.zamowienia;
--3b
SELECT id_zam, trunc(months_between(sysdate,data_zam)) FROM czek.zamowienia;
--3c
SELECT id_zam,trunc(months_between(sysdate,data_zam)/12) FROM czek.zamowienia;
--3d
SELECT id_pudelka,nazwa,cena_pudelka,cena_pudelka*sztuk_w_magazynie,CASE WHEN trunc(cena_pudelka)-cena_pudelka=0
THEN cena_pudelka ||'.00' WHEN trunc(cena_pudelka)-cena_pudelka<0 THEN trunc(cena_pudelka) ||'.'||
ABS(trunc(cena_pudelka)-cena_pudelka)*100  END AS cena_pudelka_index FROM czek.pudelka;--co do ceny pudelka

SELECT id_pudelka,nazwa,cena_pudelka,cena_pudelka*sztuk_w_magazynie,CASE WHEN trunc(cena_pudelka*sztuk_w_magazynie)
- cena_pudelka*sztuk_w_magazynie=0 THEN cena_pudelka*sztuk_w_magazynie ||'.00 z³' WHEN trunc(cena_pudelka*sztuk_w_magazynie)-
cena_pudelka*sztuk_w_magazynie<0 AND trunc(cena_pudelka*sztuk_w_magazynie)-
cena_pudelka*sztuk_w_magazynie<=-0.1 THEN trunc(cena_pudelka*sztuk_w_magazynie)||'.'||
ABS(trunc(cena_pudelka*sztuk_w_magazynie)-cena_pudelka*sztuk_w_magazynie)*100
WHEN trunc(cena_pudelka*sztuk_w_magazynie)-
cena_pudelka*sztuk_w_magazynie<0 AND trunc(cena_pudelka*sztuk_w_magazynie)-
cena_pudelka*sztuk_w_magazynie>-0.1 THEN trunc(cena_pudelka*sztuk_w_magazynie)||'.0'||
ABS(trunc(cena_pudelka*sztuk_w_magazynie)-cena_pudelka*sztuk_w_magazynie)*100END FROM czek.pudelka;
--3e
SELECT id_czek,opis,substr(opis,1,50) FROM czek.czekoladki;
SELECT id_czek,opis,replace(opis,'Truskawki','Cytryny'),length(opis) FROM czek.czekoladki;--inne znaki
--3f
SELECT imie,nazwisko,substr(imie,1,1)||'.'||substr(nazwisko,1,1)AS inicjaly FROM czek.klienci;
SELECT imie,nazwisko,CASE WHEN nazwisko LIKE 'Cz%' OR nazwisko LIKE 'Sz%' THEN substr(imie,1,1)||'.'||substr(nazwisko,1,2)
ELSE substr(imie,1,1)||'.'||substr(nazwisko,1,1) END FROM czek.klienci;--alternatywa
--3g
SELECT id_zam, id_dostawcy,id_klienta FROM czek.zamowienia WHERE data_zam LIKE '%/10/%'
AND forma_zaplaty='p';
--3h
SELECT imie,nazwisko,kod FROM czek.klienci WHERE kod LIKE '70%' OR kod LIKE'1%1';
--------------------------------------------------------------------------------
--4a
SELECT COUNT (*) FROM czek.klienci;
--4b
SELECT COUNT(*) FROM czek.klienci WHERE region='siedlecki';
--4c
SELECT COUNT (DISTINCT nazwisko) FROM czek.klienci;
--4d
SELECT COUNT(*) FROM czek.czekoladki  WHERE koszt<0.3 AND rodzaj_nadzienia='Marcepan';
--4e
SELECT MIN(cena_pudelka)AS minimalna_cena_pudelka,MAX(cena_pudelka)AS maksymalna_cena_pudelka,AVG(cena_pudelka)
AS srednia_cena_pudelka FROM czek.pudelka;
--4f
SELECT id_czek, l_sztuk FROM czek.o_pudelkach WHERE id_pudelka='ROMA';
--4g
SELECT AVG(koszt) FROM czek.czekoladki WHERE rodzaj_czekolady='Mleczna';
--4h
SELECT COUNT (*) FROM czek.pudelka;
--4i
SELECT region,COUNT(*) FROM czek.klienci GROUP BY region ORDER BY region;
--4j
SELECT miasto, COUNT(*) FROM czek.klienci WHERE miasto NOT LIKE 'K%'  GROUP BY miasto;
--4k
SELECT id_klienta AS identyfikator_klienta,COUNT(id_zam) AS liczba_zamowien FROM czek.zamowienia GROUP BY id_klienta;
--4l
SELECT data_zam,sposob_zam,COUNT(*) FROM czek.zamowienia GROUP BY data_zam,sposob_zam ORDER BY data_zam DESC;
--4m
SELECT id_pudelka,l_sztuk FROM czek.o_pudelkach ORDER BY id_pudelka DESC;
--4n
SELECT id_zam,id_pudelka,ile_sztuk FROM czek.szczegolowe_zam WHERE id_zam BETWEEN 100 AND 105 ORDER BY id_zam,id_pudelka;
--4o
SELECT CASE WHEN forma_zaplaty='k' THEN 'op³acono kart¹' WHEN forma_zaplaty='g' THEN
'op³acono gotówk¹' WHEN forma_zaplaty='p' THEN 'op³acono przelewem' ELSE 'jeszcze nie ustalono'
END AS rodzaj_zaplaty,COUNT(*)  FROM czek.zamowienia GROUP BY forma_zaplaty;
--4p
SELECT id_pudelka,SUM(l_sztuk) FROM czek.o_pudelkach GROUP BY id_pudelka  HAVING SUM(l_sztuk)>=15;;
--4q
SELECT miasto,COUNT(*) FROM czek.klienci GROUP BY miasto HAVING COUNT(*) >=3;
--4r
SELECT id_zam,SUM(ile_sztuk) FROM czek.szczegolowe_zam GROUP BY id_zam HAVING SUM(ile_sztuk)>=5 ORDER BY id_zam ;
--------------------------------------------------------------------------------
--5a
SELECT COUNT(DISTINCT miasto) FROM czek.klienci;
--5b
SELECT imie,nazwisko,CASE WHEN telefon IS NULL THEN 'brak' ELSE '+48'|| telefon END FROM czek.klienci;
--5c
SELECT data_zam,COUNT(*) FROM czek.zamowienia GROUP BY data_zam,sposob_zam HAVING COUNT(*)>=2 AND sposob_zam=1;
--5d
SELECT id_klienta, COUNT(*) FROM czek.zamowienia GROUP BY id_klienta,sposob_zam;
--5e
SELECT sposob_zam, COUNT(*) FROM czek.zamowienia GROUP BY id_klienta,sposob_zam;
--------------------------------------------------------------------------------
--6a
SELECT id_pudelka,COUNT(*) FROM czek.szczegolowe_zam GROUP BY id_pudelka HAVING id_pudelka LIKE 'K%' OR COUNT(*)>=5;
--6b
SELECT id_klienta,region, data_zam FROM czek.klienci JOIN czek.zamowienia USING (id_klienta) WHERE region='krakowski' 
AND data_zam<DATE'2002-10-10';
--6c
SELECT id_zam, SUM(ile_sztuk) FROM czek.szczegolowe_zam GROUP BY id_zam HAVING id_zam BETWEEN 40 AND 45 OR SUM(ile_sztuk)>5 ;
--6d
SELECT id_zam,id_pudelka FROM czek.szczegolowe_zam WHERE id_zam=54 AND id_pudelka <> 'PEAN';--mo¿na u¿yæ != lub NOT IN ('')
--------------------------------------------------------------------------------
--7a
SELECT nazwa,rodzaj_czekolady,koszt FROM czek.czekoladki WHERE koszt=(SELECT MAX(koszt) FROM czek.czekoladki);
--7b
SELECT nazwa,opis_pudelka FROm czek.pudelka WHERE waga>(SELECT AVG(waga) FROM czek.pudelka);
--7c
SELECT id_pudelka,waga,SUM(l_sztuk), SUM(koszt) FROM czek.pudelka JOIN czek.o_pudelkach USING(id_pudelka)
JOIN czek.czekoladki USING (id_czek) GROUP BY id_pudelka,waga;
SELECT rodzaj_czekolady, AVG(koszt) FROM czek.czekoladki GROUP BY rodzaj_czekolady;
SELECT id_pudelka,waga/SUM(l_sztuk), SUM(koszt) FROM czek.pudelka JOIN czek.o_pudelkach USING(id_pudelka)
JOIN czek.czekoladki USING(id_czek) GROUP BY id_pudelka,waga HAVING waga/SUM(l_sztuk)>0.05;
SELECT AVG(koszt) FROM czek.czekoladki WHERE waga/l_sztuk> ;
--7d
SELECT nazwa FROM czek.czekoladki WHERE rodzaj_orzechow=(SELECT rodzaj_orzechow FROM czek.czekoladki
WHERE id_czek='M14');
--7e
SELECT id_klienta,nazwisko FROM czek.klienci WHERE id_klienta NOT IN(SELECT id_klienta FROM czek.zamowienia);
SELECT id_klienta,nazwisko FROM czek.klienci LEFT JOIN czek.zamowienia USING (id_klienta) WHERE id_zam IS NULL;
--7f
SELECT id_pudelka,nazwa,SUM(ile_sztuk) FROM czek.pudelka JOIN czek.szczegolowe_zam USING (id_pudelka)GROUP BY id_pudelka,nazwa
HAVING SUM(ile_sztuk)>(SELECT SUM(sztuk_w_magazynie)*0.3 FROM czek.pudelka);
--7g
SELECT id_zam FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka)WHERE cena_pudelka=
(SELECT MIN(cena_pudelka) FROM czek.pudelka);
--7h
SELECT id_pudelka,s.nazwa,koszt FROM czek.czekoladki c JOIN czek.o_pudelkach p USING(id_czek) 
JOIN czek.pudelka s USING (id_pudelka) WHERE koszt=(SELECT MAX(koszt) FROM czek.czekoladki);
--7i
SELECT nazwa FROM czek.pudelka WHERE id_pudelka NOT IN (SELECT id_pudelka FROM czek.szczegolowe_zam);
SELECT nazwa FROM czek.pudelka LEFT JOIN czek.szczegolowe_zam USING (id_pudelka) WHERE id_zam IS NULL;
--7j
SELECT id_czek,nazwa FROM czek.czekoladki WHERE id_czek IN(SELECT id_czek FROM czek.o_pudelkach);
--7k
SELECT id_pudelka,SUM(ile_sztuk) FROM czek.szczegolowe_zam JOIN czek.zamowienia
USING (id_zam) GROUP BY id_pudelka,forma_zaplaty HAVING SUM(ile_sztuk)>   
(SELECT AVG(SUM(ile_sztuk)) FROM czek.szczegolowe_zam JOIN czek.zamowienia USING(id_zam) GROUP BY id_pudelka,forma_zaplaty)
AND forma_zaplaty='g';
--7l
SELECT id_zam,data_zam FROM czek.zamowienia WHERE id_klienta=7 ORDER BY data_zam DESC;
SELECT id_zam, CASE WHEN to_char(data_zam)='12/11/29'
THEN '***' ELSE to_char(data_zam) END AS ostatnie_zamowienie FROM czek.zamowienia WHERE id_klienta=7;
--7m
SELECT nazwa,koszt FROM czek.czekoladki WHERE koszt>(SELECT MAX(koszt) FROM czek.czekoladki WHERE rodzaj_czekolady='Mleczna');
--7n
SELECT nazwa,cena_pudelka,COUNT(*) FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka) 
GROUP BY nazwa,cena_pudelka HAVING COUNT(*) =(SELECT MAX(COUNT(*))FROM czek.szczegolowe_zam
JOIN czek.pudelka USING (id_pudelka) GROUP BY nazwa,cena_pudelka);
--7o
SELECT * FROM czek.zamowienia WHERE data_zam>(SELECT MAX(data_zam) FROM czek.zamowienia WHERE id_klienta=54);
--7p
SELECT id_pudelka,id_czek FROM czek.o_pudelkach s JOIN czek.czekoladki k USING(id_czek) WHERE koszt=
(SELECT MAX(koszt) FROM czek.o_pudelkach JOIN czek.czekoladki  USING(id_czek) WHERE id_pudelka=s.id_pudelka);
--7q
SELECT id_zam,nazwa FROM czek.szczegolowe_zam s JOIN czek.pudelka p USING (id_pudelka) WHERE cena_pudelka=
(SELECT MAX(cena_pudelka) FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka) WHERE id_zam=s.id_zam) ;

--------------------------------------------------------------------------------
--8a
SELECT imie,nazwisko, data_zam,nazwa,ile_sztuk FROM czek.klienci JOIN czek.zamowienia USING(id_klienta) JOIN czek.szczegolowe_zam
USING (id_zam) JOIN czek.pudelka USING(id_pudelka) WHERE data_zam=DATE'2002-11-20' ORDER BY nazwa;
--8b
SELECT id_zam,SUM(ile_sztuk*cena_pudelka) FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka) GROUP BY id_zam;
--8c
SELECT data_zam, SUM(l_sztuk*koszt) FROM czek.zamowienia JOIN czek.szczegolowe_zam USING (id_zam) JOIN czek.pudelka USING(id_pudelka)
JOIN czek.o_pudelkach USING (id_pudelka) JOIN czek.czekoladki USING(id_czek) GROUP BY data_zam;
--8d
SELECT nazwa,SUM(l_sztuk) FROM czek.pudelka JOIN czek.o_pudelkach USING (id_pudelka) GROUP BY nazwa;
--8e
SELECT SUM(cena_pudelka*sztuk_w_magazynie) AS wartosc_magazynu FROM czek.pudelka;
--8f
SELECT k.imie||' '||k.nazwisko AS dane_klientow,d.imie||' '||d.nazwisko AS dane_dosatawcow FROM czek.klienci k JOIN czek.zamowienia z
USING(id_klienta) JOIN czek.dostawcy d USING(id_dostawcy);