drop  PROCEDURE sp_dimTempoinicial;

delimiter $$
CREATE  PROCEDURE sp_dimTempoinicial()
begin
declare min_date date;
declare max_date date;
select min(str_to_date(date_format(payment_date,'%d%m%Y'),'%d%m%Y')) into min_date from sakila.payment;
select max(str_to_date(date_format(payment_date,'%d%m%Y'),'%d%m%Y')) into max_date from sakila.payment;
WHILE (min_date <= max_date) do
	INSERT INTO sakila_dw.dim_Tempo
	(Data, data_dia, data_mes, data_ano, data_trimestre,data_semana,data_nome_dia,data_feriado,data_fim_semana,Etiqueta_DTA)
	VALUES (min_date, 
		Day(min_date),
		Month(min_date),
		Year(min_date),
        Quarter(min_date),
        Week(min_date),
        Dayname(min_date),
        (select  Feriado from sakila_AR.AR_Feriados a1 where a1.data=min_date),
		(select  if(util='U','N','S') from sakila_AR.AR_Feriados a1 where a1.data=min_date),
now());	
        set min_date = adddate(min_date,interval 1 day);
END while;
end $$

call sp_dimTempoinicial();