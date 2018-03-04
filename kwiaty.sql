select to_timestamp('01/12/11') from dual;
select to_timestamp(sysdate,'mi') from dual;
select TO_DATE('27/04/2013','DD/MM/YY') from dual;
select to_char(sysdate,'hh24-mi-ss, yyyy/mm/dd') from dual;

select * from kwiaty.zamjed;

select numer_kat,nazwa_pol from kwiaty.katalog where (nazwa_pol like '%fikus%' or nazwa_pol like 'Fikus%')and podlewanie=3;
select sum(cena*stan) as wartosc from kwiaty.magazyn where numer_kat like '1%';
select numer_kat,sum(sztuk) from kwiaty.zamjed join kwiaty.zam using(id_zam) where data_zam=(select max(data_zam) from 
kwiaty.zamjed join kwiaty.zam using(id_zam)) group by numer_kat;
select nazwa,data_zam,numer_kat,sum(sztuk) from kwiaty.zam join kwiaty.zamjed using(id_zam) join kwiaty.
sklepy using(id_sklepu) where zrealizowane='F' and transport='Wynajêty'
group by nazwa,data_zam,numer_kat;
select numer_kat,sum(sztuk) from kwiaty.zamjed join kwiaty.zam using(id_zam) where to_char(data_zam,'dd')=22
or to_char(data_zam,'dd') = 25 group by numer_kat;
select numer_kat from kwiaty.zamjed join kwiaty.katalog using(numer_kat) where temp=1 group by numer_kat having sum(sztuk)>=2;


select imie,nazwisko,plec from firma.pracownicy join firma.wyksztalcenie using(kod_wyksztalcenia) where nazwa='podstawowe';
select imie,nazwisko,round(placa_dodatkowa/placa_podstawowa*100) ||' %' from firma.pracownicy where placa_dodatkowa>0;
select kod_wydzialu from firma.pracownicy group by kod_wydzialu having count(*)=(select min(count(*)) from firma.pracownicy group by kod_wydzialu);
select imie,nazwisko, case when id_prac =id_kierownika then nazwa end from firma.pracownicy join firma.wydzialy using(kod_wydzialu);
