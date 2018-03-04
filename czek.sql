F5 aby uruchomiæ pr.
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
select id_zam,data_zam From czek.zamowienia where id_zam=54 And data_zam< DATE'2010-11-02'>;
--To_DATE('2003/0709', 'yyyy/mm/dd')
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

--zad.
SELECT imie, nazwisko, id_zam FROM czek.klienci JOIN czek.zamowienia 
ON czek_klienci.id_klienta = zamowienia.id_klienta;
--Preferowany wariant
SELECT imie, nazwisko, id_zam FROM czek.klienci k JOIN czek.zamowienia z
ON k.id_klienta=z.id_klienta;
--inaczej
SELECT imie, nazwisko, id_zam FROM klienci JOIN czek.zamowienia 
USING (id_klienta);
--jeszcze inaczej 
SELECT imie, nazwisko, id_zam FROM czek.klienci NATURAL JOIN czek.zamowienia;
--6q
SELECT SUM(cena_pudelka*sztuk_w_magazynie) FROM czek.pudelka;
--6r
SELECT imie,nazwisko,telefon, CASE WHEN telefon IS NOT NULL THEN '+48' || telefon
ELSE 'brak' END AS telefon FROM czek.klienci;
-- Jeœli w zadaniu pominiemy '+48' to zamiast CASE ...END mo¿na napisaæ COALESCE (telefon,'brak')
-- lub NVL(telefon,'brak')
SELECT imie,nazwisko,telefon, COALESCE (telefon,'brak') AS telefon FROM czek.klienci;
SELECT imie,nazwisko,telefon, NVL (telefon,'brak') AS telefon FROM czek.klienci;
--7a
SELECT id_pudelka, FROM czek.pudelka JOIN czek.szczegolowe_zam USING (id_pudelka)
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
----------------

SELECT imie, nazwisko, COUNT(id_zam)AS liczba_zamowien FROM czek.klienci JOIN czek.zamowienia 
USING(id_klienta)GROUP BY imie,nazwisko;--7e
SELECT czek.pudelka.nazwa, czek.czekoladki.nazwa, czek.o_pudelkach.l_sztuk FROM czek.pudelka JOIN czek.o_pudelkach
USING (id_pudelka) JOIN czek.czekoladki USING (id_czek);--7f
SELECT id_zam,SUM(ile_sztuk*cena_pudelka) FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka)
GROUP BY id_zam;--7h
SELECT nazwa, rodzaj_czekolady, koszt FROM czek.czekoladki WHERE koszt=(SELECT MAX(koszt) 
FROM czek.czekoladki) ORDER BY koszt DESC;--7a1
SELECT nazwa,opis_pudelka FROM czek.pudelka WHERE waga>(SELECT AVG(waga)FROM czek.pudelka);--7b1
SELECT rodzaj_czekolady,AVG(koszt) FROM czek.czekoladki GROUP BY rodzaj_czekolady
HAVING AVG(koszt)>(SELECT AVG(koszt)FROM czek.czekoladki);--7c1
SELECT nazwa FROM czek.czekoladki WHERE rodzaj_orzechow=
(SELECT rodzaj_orzechow FROM czek.czekoladki WHERE id_czek='M14');--7d1
SELECT id_klienta,nazwisko FROM czek.klienci LEFT JOIN czek.zamowienia USING (id_klienta) WHERE id_zam IS NULL;--7e1
SELECT id_zam FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka)WHERE cena_pudelka=
(SELECT MIN(cena_pudelka)FROM czek.pudelka);--7f1
SELECT nazwa FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka)WHERE id_zam IS NULL;--7g1
SELECT nazwa,id_czek FROM czek.o_pudelkach JOIN czek.czekoladki USING(id_czek)WHERE id_pudelka IS NOT NULL;--7h1
SELECT nazwa,koszt FROM czek.czekoladki WHERE koszt>(SELECT MAX(koszt) FROM czek.czekoladki
GROUP BY rodzaj_czekolady HAVING rodzaj_czekolady='Mleczna');--7i1
SELECT * FROM czek.zamowienia WHERE data_zam>(SELECT MAX(data_zam) FROM czek.zamowienia WHERE id_klienta=54);--7j1





SELECT id_klienta,imie,nazwisko, COUNT (*) AS liczba_zamowien  FROM czek.zamowienia JOIN czek.klienci 
USING (id_klienta) GROUP BY id_klienta,imie,nazwisko;--7e
SELECT czek.pudelka.nazwa, czek.czekoladki.nazwa, czek.o_pudelkach.l_sztuk FROM czek.pudelka JOIN czek.o_pudelkach
USING (id_pudelka) JOIN czek.czekoladki USING (id_czek);--7f
SELECT czekoladki.nazwa FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka) JOIN czek.o_pudelkach USING (id_pudelka) JOIN czek.czekoladki USING (id_czek) WHERE id_zam=3;--7g
SELECT id_zam,SUM(ile_sztuk*cena_pudelka) AS kwota_zamowienia FROM czek.szczegolowe_zam JOIN czek.pudelka USING (id_pudelka)
GROUP BY id_zam;--7h
SELECT nazwa, rodzaj_czekolady, koszt FROM czek.czekoladki ORDER BY koszt DESC;
SELECT rodzaj_orzechow, rodzaj_czekolady, koszt FROM czek.czekoladki WHERE koszt = (SELECT MAX(koszt) FROM czek.czekoladki);--7a'
SELECT rodzaj_orzechow,rodzaj_czekolady, MAX(koszt) AS max_koszt FROM czek.czekoladki GROUP BY rodzaj_orzechow,rodzaj_czekolady;-- 7a' inaczej
SELECT nazwa,opis_pudelka FROM czek.pudelka WHERE waga>(SELECT AVG(waga) FROM czek.pudelka);--7b'
SELECT rodzaj_czekolady FROM czek.czekoladki GROUP BY rodzaj_czekolady HAVING AVG(koszt)>(SELECT AVG(koszt)FROM czek.czekoladki);--7c'
SELECT nazwa FROM czek.czekoladki WHERE rodzaj_orzechow=(SELECT rodzaj_orzechow FROM czek.czekoladki WHERE id_czek='M14');--7d'
SELECT id_klienta,nazwisko FROM czek.klienci WHERE id_klienta NOT IN (SELECT id_klienta FROM czek.zamowienia);--7e'
SELECT id_klienta,nazwisko FROM czek.klienci LEFT JOIN czek.zamowienia USING (id_klienta) WHERE id_zam IS NULL;--7e' inaczej

SELECT id_zam FROM czek.szczegolowe_zam JOIN czek.pudelka 
USING (id_pudelka) WHERE cena_pudelka=(SELECT MIN(cena_pudelka) FROM czek.pudelka);--7f'
SELECT nazwa FROM czek.pudelka WHERE id_pudelka NOT IN (SELECT id_pudelka FROM czek.szczegolowe_zam);--7g'
SELECT nazwa FROM czek.pudelka LEFT JOIN czek.szczegolowe_zam USING (id_pudelka) WHERE id_zam IS NULL; --7g'inaczej
SELECT id_czek, nazwa FROM czek.czekoladki WHERE id_czek IN (SELECT id_czek FROM czek.o_pudelkach);--7h'
SELECT nazwa,koszt FROM czek.czekoladki WHERE koszt>(SELECT MAX(koszt) FROM czek.czekoladki 
WHERE rodzaj_czekolady='Mleczna');--7i'
SELECT * FROM czek.zamowienia WHERE data_zam>(SELECT MAX(data_zam) FROM czek.zamowienia WHERE id_klienta=54);--7j'
SELECT id_pudelka, id_czek FROM czek.o_pudelkach p WHERE l_sztuk=
(SELECT MAX(l_sztuk) FROM czek.o_pudelkach WHERE id_pudelka=p.id_pudelka);--7k'
SELECT id_zam, nazwa FROM czek.szczegolowe_zam s JOIN czek.pudelka p ON s.id_pudelka=p.id_pudelka WHERE cena_pudelka= (SELECT MAX (cena_pudelka)
FROM czek.pudelka JOIN czek.szczegolowe_zam USING (id_pudelka) WHERE id_zam=s.id_zam);--7l'
SELECT id_zam FROM czek.szczegolowe_zam GROUP BY id_zam HAVING COUNT(*)=(SELECT MAX(COUNT(*))
FROM czek.szczegolowe_zam GROUP BY id_zam);--7m'
SELECT imie,nazwisko FROM czek.zamowienia JOIN czek.klienci 
USING (id_klienta) GROUP BY id_klienta,imie,nazwisko HAVING 
COUNT(id_zam)=(SELECT MAX(COUNT(id_zam)) FROM czek.zamowienia JOIN czek.klienci 
USING (id_klienta)GROUP BY id_klienta,imie,nazwisko);--7n'

SELECT id_czek FROM czek.czekoladki MINUS SELECT id_czek FROM czek.o_pudelkach;

