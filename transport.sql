--1
select * from transport.dzialy;
select * from transport.pracownicy;
select * from transport.kursy;
select * from transport.klienci;
select * from transport.pojazdy;
--2
select marka,case when typ='C' then 'ciê¿arowy' when typ='O' then
'osobowy' when typ='A' then 'autobus' end as typ_samochodu from transport.pojazdy where przebieg between 10000 and 99999;
--3
select imie,nazwisko,to_char(data_zatrud,'YY/MM/DD') as data_zatrud from transport.pracownicy order by data_zatrud desc;
--4
select id_pojazdu,marka from transport.pojazdy where nr_rej like 'LU%';
--5
select nazwa, substr(telefon,-4) from transport.dzialy;
--6
select max(pensja)-min(pensja) as roznica from transport.pracownicy;
--7
select id_dzialu,sum(pensja) from transport.pracownicy group by id_dzialu;
--8
select typ,count(id_pojazdu) from transport.pojazdy group by typ;
--9
select id_klienta, avg(odl_km) from transport.klienci join transport.kursy on transport.kursy.dla=transport.klienci.id_klienta group by id_klienta;
--10
select id_pojazdu, sum(odl_km) from transport.pojazdy join transport.kursy on transport.pojazdy.id_pojazdu=transport.kursy.czym group by id_pojazdu;
--11
select stanowisko, avg(pensja) from transport.pracownicy  group by stanowisko having avg(pensja)>4000;
--12
select imie, nazwisko,nazwa from transport.pracownicy join transport.dzialy using(id_dzialu);
--13 
select nazwisko from transport.pracownicy join transport.kursy on transport.pracownicy.id_pracownika=transport.kursy.kto
join transport.klienci on transport.kursy.dla=transport.klienci.id_klienta where id_klienta=507;
--14
select id_kursu, nazwa, imie || ' ' || nazwisko as imie_nazwisko, marka, miasto from transport.pracownicy 
join transport.kursy on transport.pracownicy.id_pracownika=transport.kursy.kto
join transport.klienci on transport.kursy.dla=transport.klienci.id_klienta
join transport.pojazdy on transport.pojazdy.id_pojazdu=transport.kursy.czym;
--15
select nazwisko, avg(odl_km) from transport.pracownicy join transport.kursy on 
transport.pracownicy.id_pracownika=transport.kursy.kto group by nazwisko;
--16
select imie, nazwisko from transport.pracownicy where pensja>(select avg(pensja) from transport.pracownicy);
--17
select id_kursu from transport. kursy where odl_km=(select max(odl_km) from transport.kursy);
--18
select * from transport.pojazdy where przebieg=(select min(przebieg)from transport.pojazdy);
--19
select imie, nazwisko, count(wyjazd) from transport.pracownicy join transport.kursy 
on transport.pracownicy.id_pracownika=transport.kursy.kto group by imie, nazwisko  
having count(wyjazd)=(select max(count(wyjazd)) from transport.pracownicy join transport.kursy 
on transport.pracownicy.id_pracownika=transport.kursy.kto group by imie,nazwisko) ;
--20
select nazwa, count(wyjazd) from transport.klienci join transport.kursy 
on transport.klienci.id_klienta=transport.kursy.dla group by nazwa
having count(wyjazd)=(select max(count(wyjazd)) from transport.klienci join transport.kursy 
on transport.klienci.id_klienta=transport.kursy.dla group by nazwa);

--21
select imie,nazwisko,data_zatrud,pensja from transport.pracownicy where data_zatrud>(select data_zatrud 
from transport.pracownicy where pensja=(select min(pensja) from transport.pracownicy)) ;
