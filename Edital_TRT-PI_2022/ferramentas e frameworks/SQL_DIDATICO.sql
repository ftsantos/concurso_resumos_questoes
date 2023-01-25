
create table banco_java.auxiliar(
	nome varchar(30),
	valor integer
)
insert into banco_java.auxiliar values ('Francisco Santos',10);
insert into banco_java.auxiliar values ('Rayane',10);
insert into banco_java.auxiliar values ('Mallory',10);

update banco_java.auxiliar set valor = 1 where nome like 'Francisco Santos';
update banco_java.auxiliar set valor = 3 where nome like 'Rayane';

create table banco_java.curso(
	id integer,
	version integer,
	nomecurso varchar(30),
	constraint pk_cod_curso primary key(id)
)

create table banco_java.aluno(
	id integer,
	nome varchar(30), 
	id_curso integer,
	constraint pk_id_aluno primary key(id),
	constraint fk_cod_curso foreign key(id_curso) 
	REFERENCES banco_java.curso(id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
)

create table banco_java.funcionario(
	cod int,
	nome varchar(30),
	salario decimal(10,2),
	comissao decimal(10,2),
	constraint pk_cod_func primary key(cod)
)

-- drop table banco_java.funcionario

-- insert into banco_java.funcionario values (3,'Rayane', 1500.00, 200.00)
-- insert into banco_java.funcionario values (4,'Angelina', 2000.00, null)
-- insert into banco_java.funcionario values (5,'Maycon Francis', 4500.00, null)
insert into banco_java.funcionario values (7,'Francisco Santos', 10500.00, 0);
insert into banco_java.funcionario values (8,'Rayane', 12000.00, 0);
insert into banco_java.funcionario values (9,'Francisco Santos', 27000.00, 70000),(10,'Rayane', 17000.00, 5000);

-- seleciona tudo
select * from banco_java.funcionario;

-- seleciona apenas apenas algumas colunas, isso se chama PROJEÇÃO
select nome, salario from banco_java.funcionario;

-- seleciona apenas apenas algumas linhas/reegistros, isso se chama RESTRIÇÃO
select * from banco_java.funcionario where salario < 2000;
select * from banco_java.funcionario where salario < 2000 or (salario > 3000  and salario < 4000);
select * from banco_java.funcionario where salario between 3000 and 4000;
select * from banco_java.funcionario where salario in (1500, 3500);
select * from banco_java.funcionario where comissao is null;
select * from banco_java.funcionario where comissao is not null;
select * from banco_java.funcionario where nome like '%an%';

select nome, salario+comissao as ValorTotal from banco_java.funcionario

-- ORDENAÇÃO 
-- SELECT
-- FROM
-- WHERE
-- GROUP BY
select nome, salario -- coluna que aparece no select deve aparacer no group by
from banco_java.funcionario
group by nome, salario;

-- HAVING esta cláusula filtra o retorno do agrupamento.

select * from banco_java.funcionario

-- select nome, count(salario), salario. ERROR: column "funcionario.salario" must appear in the GROUP BY clause or be used in an aggregate function
-- Está ok, tem dois Francisco Santos com salário maior que 10000 e duas Rayanes com salário maior que 10000
select nome, count(salario)
from banco_java.funcionario 
where salario > 10000
group by nome
having count(salario) > 1;

select f.nome, count(f.salario)
from banco_java.funcionario f
inner join banco_java.funcionario a using (nome)
where f.salario > 10000
group by nome
having count(f.salario) > 1;

-- SELECT column_name, aggregate_function(column_name)
-- FROM table_name
-- WHERE column_name operator value
-- GROUP BY column_name
-- HAVING aggregate_function(column_name) operator value;

SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders FROM (Orders
INNER JOIN Employees
ON Orders.EmployeeID=Employees.EmployeeID)
GROUP BY LastName
HAVING COUNT(Orders.OrderID) > 10;

-- ORDER BY ASC DESC
select * from banco_java.funcionario order by salario; -- order by salario asc;
select * from banco_java.funcionario order by salario, comissao;
select distinct salario from banco_java.funcionario;
-- select nome, distinct salario from banco_java.funcionario; -- é inválido


-- PRODUTO CARTESIANO OU CROSS JOIN
-- A cada linha da tabela 1 é associado o conjunto das linhas da tabela 2
select * from banco_java.auxiliar, banco_java.funcionario;
-- Equi-Join: observe que a coluna valor e cod tem os mesmos valores, ou seja, a ligação é feita através da igualdade
select a.*, f.* from banco_java.auxiliar a, banco_java.funcionario f where a.valor = f.cod;
-- Natural Join: todas as colunas da ligação são apresentadas sem repetição de coluna. Não exibe a coluna valor
select a.nome, f.* from banco_java.auxiliar a, banco_java.funcionario f where a.valor = f.cod;
-- Left Join: traz todos os registros da esquerda, ou seja da tabela auxiliar, mesmo que não tenha correspondencia a.valor = f.cod
select a.*, f.* from banco_java.auxiliar a left join banco_java.funcionario f on a.valor = f.cod;
-- Right Join: traz todos os registros da direita, ou seja da tabela funionario, mesmo que não tenha correspondencia a.valor = f.cod
select a.*, f.* from banco_java.auxiliar a right join banco_java.funcionario f on a.valor = f.cod;
-- Inner Join. 
select a.*, f.* from banco_java.auxiliar a inner join banco_java.funcionario f using (nome);

-- Union: junta o conteúdo de 2 ou mais selects. O resultado obedece o nome das colunas do primeiro select, observe valor e não salario
select nome, valor from banco_java.auxiliar where valor > 5
union -- o número de Colunas retornado pelos SELECTs devem ser iguais
select nome, salario from banco_java.funcionario where salario > 4000


-- select sum(salario + comissao) as soma from banco_java.funcionario
select * from banco_java.funcionario f where salario > 3000 



-------------------------------------------------------------------------
   
create ou replace function banco_java.maior_salario ()
	returns decimal as
	$body$
	begin
		return (select max(salario) from banco_java.funcionario)
	end
	$body$ language 'plpgsql'

SELECT banco_java.maior_salario()

---------------------------------------------------------
create ou replace function banco_java.concatena_doisnomes (varchar, varchar)
	return varchar as
	$body$
	begin
		return (select $1 || $2)
	end
	$body$ language 'plpgsql'
---------------------------------------------------------
create or replace function banco_java.concatena_doisnomes (varchar, varchar)
returns varchar as
$body$
declare 
	texto varchar;
begin
		return ( $1 || $2);
end
$body$ language 'plpgsql'
---------------------------------------------------------
create or replace function funcao_insere_curso()
returns trigger as $insere_curso$
begin
	insert into banco_java.curso(10, 1, $1);
	return null;
end;
$insere_curso$ language 'plpgsql'
---------------------------------------------------------
create or replace function funcao_insere_curso(varchar)
returns trigger as $insere_curso$
begin
	insert into banco_java.curso(10, 1, $1);
	return null;
end;
$insere_curso$ language 'plpgsql'


create trigger insere_curso
after insert on banco_java.aluno 
for each row execute procedure funcao_insere_curso('portugues');


---------------------------------------------------------

CREATE TABLE emp (
    empname           text NOT NULL,
    salary            integer
);

CREATE TABLE emp_audit(
    operation         char(1)   NOT NULL,
    stamp             timestamp NOT NULL,
    userid            text      NOT NULL,
    empname           text      NOT NULL,
    salary integer
);

CREATE OR REPLACE FUNCTION process_emp_audit() RETURNS TRIGGER AS $emp_audit$
    BEGIN
        --
        -- Create a row in emp_audit to reflect the operation performed on emp,
        -- make use of the special variable TG_OP to work out the operation.
        --
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO emp_audit SELECT 'D', now(), user, OLD.*;
            RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO emp_audit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO emp_audit SELECT 'I', now(), user, NEW.*;
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$emp_audit$ LANGUAGE plpgsql;

CREATE TRIGGER emp_audit
AFTER INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW EXECUTE PROCEDURE process_emp_audit();
