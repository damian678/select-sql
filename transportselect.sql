--7
--a
select imie,nazwisko from transport.pracownicy where pensja=(select min(pensja) from transport.pracownicy);
--b
select imie,nazwisko from transport.pracownicy where pensja>(select avg(pensja) from transport.pracownicy);
--c
select imie,nazwisko from transport.pracownicy where data_zatrud=(select min(data_zatrud) from transport.pracownicy);

--d
select id_kursu from transport.kursy where odl_km=(select max(odl_km) from transport.kursy);
--e
select id_pojazdu from transport.pojazdy where przebieg=(select min(przebieg) from transport.pojazdy);
--f
select imie,nazwisko from transport.pracownicy d join transport.kursy e on d.id_pracownika=e.kto group by imie,nazwisko
having count(*)=(select max(count(*)) from transport.pracownicy d join transport.kursy e on d.id_pracownika=e.kto group by imie,nazwisko);
--g
select nazwa from transport.klienci e join transport.kursy d on e.id_klienta=d.dla group by nazwa having count(*)=(select max(count(*)) from
transport.klienci e join transport.kursy d on e.id_klienta=d.dla group by nazwa);
--h
select nazwa from transport.dzialy join transport.pracownicy using (id_dzialu) group by nazwa having count(*)=(select min(count(*)) 
from transport.dzialy join transport.pracownicy using (id_dzialu) group by nazwa);
--i
select imie,nazwisko from transport.pracownicy where data_zatrud>(select data_zatrud from transport.pracownicy where pensja=(select max(pensja)
from transport.pracownicy));
select max(data_zatrud)-min(data_zatrud) from transport.pracownicy;
--j
select imie,nazwisko from transport.pracownicy where id_pracownika not in(select kto from transport.kursy);
select imie,nazwisko from transport.pracownicy d left join transport.kursy b on d.id_pracownika=b.kto where id_kursu is null;
--6
--a
select imie,nazwisko,nazwa from transport.dzialy join transport.pracownicy using(id_dzialu);
--b
select * from transport.kursy where czym=(select id_pojazdu from transport.pojazdy where nr_rej='WX1000A');
--c
select nazwisko from transport.pracownicy d join transport.kursy b on d.id_pracownika=b.kto where dla=507;
--d
select nazwa from transport.klienci d join transport.kursy b on d.id_klienta=b.dla where cel_miasto='Warszawa' 
and to_char(powrot,'yyyy')=2013;
--e
select id_kursu,nazwa,imie|| ' ' ||nazwisko,marka,cel_miasto from transport.pracownicy join transport.kursy on transport.pracownicy.id_pracownika
=transport.kursy.kto join transport.klienci  on transport.kursy.dla=transport.klienci.id_klienta join transport.pojazdy  
on transport.kursy.czym=transport.pojazdy.id_pojazdu;
--f
select nazwa,count(*) from transport.kursy d join transport.klienci b on d.dla=b.id_klienta group by nazwa;
--g
select nazwisko,avg(odl_km) from transport.pracownicy d join transport.kursy b on d.id_pracownika=b.kto group by nazwisko;
--h
select nazwa,count(*) from transport.dzialy join transport.pracownicy using(id_dzialu) group by nazwa;
--i
select nazwa,avg(odl_km) from transport.klienci d join transport.kursy b on d.id_klienta=b.dla where miasto='Lublin' group by nazwa having
avg(odl_km)>400;
--4
--a
select stanowisko,count(*) from transport.pracownicy group by stanowisko;
--b
select nazwa,sum(pensja) from transport.pracownicy join transport.dzialy using(id_dzialu) group by nazwa;
--c
select miasto, count(*) from transport.klienci group by miasto;
--d
select typ,count(*) from transport.pojazdy group by typ;
--e
select kto,dla,count(*) from transport.kursy group by kto,dla;
--f
select dla,avg(odl_km) from transport.kursy group by dla;
--g
select avg(max(odl_km)) from transport.kursy group by kto;
--h
select czym,sum(odl_km) from transport.kursy group by czym; 
--3j
select round(avg(odl_km),1) from transport.kursy;
--3i
select max(powrot-wyjazd) from transport.kursy;
--3h
select count(*) from transport.kursy where cel_miasto='Warszawa';
--3f
select max(pensja)-min(pensja) from transport.pracownicy;
--2i
select * from transport.kursy where wyjazd='13/03/02';