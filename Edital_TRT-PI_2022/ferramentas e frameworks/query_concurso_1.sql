
create table fsantos1(
	a character varying (50),
	b character varying (50),
	c integer
)

select * from fsantos1

select a from fsantos1 group by a -- retorna 4 linhas, pois são 4 grupos
select a, b from fsantos1 group by a -- da erro
select a, b from fsantos1 group by a, b 
select a, b, c from fsantos1 group by a, b, c

-- drop table fsantos1
-- todos atributos que aparecem no select tem que estarem no group by
-- cobina casos que não existem, 32 linhas, 8*8=64/2=32
-- 4 grupos em 2 tabelas, 4*4=16*2=32
-- na verdade são 4 grupos e 8 pessoas diferentes, logo 4 * 8 = 32
select f1.a, f2.b from fsantos1 f1, fsantos1 f2 group by f1.a, f2.b 
select f1.a, f2.b from fsantos1 f1, fsantos1 f2 where f1.a = f2.a group by f1.a, f2.b 

delete from fsantos1 where a = 'vasco' 

update fsantos1 set timefutebol = 'Vasco' where timefutebol = 'vasco'

insert into fsantos1 values ('Flamengo', 'Francisco', 25);
insert into fsantos1 values ('Vasco', 'Grazyanne', 26)
insert into fsantos1 values ('Flamengo', 'Rayane', 25);
insert into fsantos1 values ('Palmeiras', 'Railson', 27);
insert into fsantos1 values ('Vasco', 'Saulo', 24);
insert into fsantos1 values ('Palmeiras', 'José', 32);
insert into fsantos1 values ('Corinthias', 'Pablo', 20);
insert into fsantos1 values ('Flamengo', 'Pacheco', 33)

-- select * from formula1
-- select * from formula1 order by pontos
-- select * from formula1 order by pontos desc
select count(*), p1.piloto from formula1 p1, formula1 p2 
where p1.pontos <= p2.pontos
group by p1.piloto 
order by 1
