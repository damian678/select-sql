--3
--a
select * from firma.pracownicy order by kod_wydzialu,nazwisko;
--b
select imie,nazwisko,data_urodzenia from firma.pracownicy where kod_wyksztalcenia ='p';
select imie,nazwisko,data_urodzenia from firma.pracownicy join firma.wyksztalcenie using(kod_wyksztalcenia) where
lower(nazwa)='podstawowe';
--c
select imie,nazwisko,k.nazwa,d.nazwa from firma.pracownicy s join firma.wydzialy k using(kod_wydzialu) join firma.wyksztalcenie d 
using (kod_wyksztalcenia) where k.nazwa='administracja' and (d.nazwa='œrednie' or d.nazwa='zawodowe') ;
--d
select imie,nazwisko from firma.pracownicy where placa_dodatkowa>0;
--e
select nazwa,placa_min,placa_max,placa_min-placa_max as roznica from firma.stanowiska;
--f
select imie,nazwisko,round(placa_podstawowa,-2) from firma.pracownicy join firma.wyksztalcenie using (kod_wyksztalcenia)
where plec='m' and nazwa='podstawowe';
--g
select imie,nazwisko,round((placa_dodatkowa/placa_podstawowa)*100) from firma.pracownicy where placa_dodatkowa>0;
--h
select imie,nazwisko,trunc(months_between(sysdate,data_zatrudnienia)) as przepracowane_miesiace from firma.pracownicy;
--i
select imie,nazwisko from firma.pracownicy where to_char(sysdate,'yyyy')-to_char(data_zatrudnienia,'yyyy')<=10;
--4
--a
select count(*) from firma.pracownicy where placa_dodatkowa>0;
--b
select kod_wyksztalcenia,count(*) from firma.pracownicy group by kod_wyksztalcenia having count(*)>10;
--c
select nazwa,count(*) from firma.pracownicy join firma.stanowiska using(kod_stanowiska) group by nazwa having count(*)<=5;
--d
select nazwa,count(*) from firma.wydzialy join firma.pracownicy using (kod_wydzialu) group by nazwa;
--e
select id_prac from firma.pracownicy where id_prac not in(select id_kierownika from firma.wydzialy);
--f
select kod_wydzialu,count(*) from firma.pracownicy where placa_dodatkowa>0 group by kod_wydzialu; 
--g
select nazwa,imie||' '||nazwisko as imie_nazwisko from firma.wydzialy join firma.pracownicy using(kod_wydzialu) where id_kierownika=id_prac;
--h
select imie,nazwisko,nazwa from firma.pracownicy join firma.wyksztalcenie using(kod_wyksztalcenia);
--i
select imie,nazwisko from firma.pracownicy where placa_podstawowa=(select max(placa_podstawowa) from firma.pracownicy);
--j
select imie,nazwisko from firma.pracownicy where placa_podstawowa>0.8*(select avg(placa_podstawowa) from firma.pracownicy) and
placa_podstawowa<1.2*(select avg(placa_podstawowa) from firma.pracownicy);
--k
select kod_wydzialu from firma.pracownicy group by kod_wydzialu 
having count(*)=(select min(count(*)) from firma.pracownicy group by kod_wydzialu);
--l
select imie,nazwisko from firma.pracownicy where placa_podstawowa>(select avg(placa_podstawowa) from firma.pracownicy);
--m
select imie,nazwisko, case when id_prac=id_kierownika then nazwa else ' ' end 
from firma.pracownicy join firma.wydzialy using(kod_wydzialu);
-------------------------------------------------------------------------------