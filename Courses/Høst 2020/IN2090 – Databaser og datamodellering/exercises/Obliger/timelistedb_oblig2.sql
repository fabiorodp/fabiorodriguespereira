drop view if exists Timeantall;
drop view if exists Varighet;
drop table if exists Timelistelinje;
drop table if exists Timeliste;

create table Timeliste (
  timelistenr int primary key,
  status text not null,
  levert date,
  utbetalt date,
  beskrivelse text not null,
  check (status = 'aktiv' or status = 'levert' or status = 'utbetalt')
);

create table Timelistelinje (
  timelistenr int references Timeliste(timelistenr),
  linjenr int,
  startdato date not null,
  starttid time not null,
  sluttid time,
  pause int,
  beskrivelse text not null,
  primary key (timelistenr, linjenr)
);

create view Varighet AS
  select timelistenr,
         linjenr, 
         (sluttid - starttid - pause) as varighet
  from (select timelistenr,
               linjenr,
               cast(extract(hour from starttid) as integer)*60 +
                    cast(extract(minute from starttid) as integer) as starttid,
               cast(extract(hour from sluttid) as integer)*60 +
                    cast(extract(minute from sluttid) as integer) +
                         case when sluttid < starttid then 60*24
                              else 0
                         end as sluttid,
               case when pause is null then 0
                    else pause
               end as pause
        from Timelistelinje
        where sluttid is not null) as c;

\copy Timeliste from 'timeliste.txt' with delimiter '|' null ''

\copy Timelistelinje from 'timelistelinje.txt' with delimiter '|' null ''

