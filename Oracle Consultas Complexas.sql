##########MOSTRANDO A TABELA##########

###ALUNO
ID
NOME
EMAIL

###CURSO
ID
NOME

###MATRICULA
ID
ALUNO_ID
CURSO_ID
DATA
TIPO


##########SELECTS##########

SELECT ALUNO.NOME, CURSO.NOME FROM ALUNO 
	JOIN MATRICULA ON MATRICULA.ALUNO_ID = ALUNO.ID
	JOIN CURSO ON CURSO.ID = MATRICULA.CURSO_ID;
	
SELECT A.NOME FROM ALUNO A;

##USANDO ALIAS

SELECT A.NOME, C.NOME FROM ALUNO A
	JOIN MATRICULA M ON M.ALUNO_ID = A.ID
	JOIN CURSO C ON M.CURSO_ID = C.ID;

SELECT COUNT(*) FROM ALUNO;

SELECT A.NOME FROM ALUNO A WHERE EXISTS(
	SELECT M.ID FROM MATRICULA M WHERE M.ALUNO_ID = A.ID);
	
SELECT A.NOME FROM ALUNO A WHERE NOT EXISTS(
	SELECT M.ID FROM MATRICULA M WHERE M.ALUNO_ID = A.ID);
	
SELECT * FROM EXERCICIO E WHERE NOT EXISTS(
	SELECT R.ID FROM RESPOSTA R WHERE R.EXERCICIO_ID = E.ID);

SELECT C.NOME FROM CURSO C WHERE NOT EXISTS(
	SELECT M.ID FROM MATRICULA M WHERE M.CURSO_ID = C._ID);
	
######### DESC TABELAS########

#TABELA NOTA
ID
REPOSTA_ID
NOTA

#TABELA RESPOSTA
ID
EXERCICIO_ID
ALUNO_ID
RESPOSTA_DADA

#TABELA EXERCICIO
ID
SECAO_ID
PERGUNTA
RESPOSTA_OFICIAL

# TABELA SECAO
ID
CURSO_ID
TITULO
EXPLICACAO
NUMERO

#TABELA ALUNO
ID
NOME
EMAIL

#TABELA CURSO
ID
NOME

#################### JOINS ###################

SELECT C.NOME, AVG(N.NOTA) FROM NOTA N
	JOIN RESPOSTA R  ON R.ID = N.RESPOSTA_ID
	JOIN EXERCICIO E  ON E.ID = R.EXERCICIO_ID
	JOIN SECAO S ON S.ID = E.SECAO_ID
	JOIN CURSO C ON C.ID = S.CURSO_ID 
	GROUP BY C.NOME;
	
SELECT COUNT(E.ID) FROM EXERCICIO E
		JOIN SECAO S ON S.ID = E.SECAO_ID
		JOIN CURSO C ON C.ID = S.CURSO_ID
		GROUP BY C.NOME;
		
SELECT C.NOME, COUNT(E.ID) AS QUANTIDADE FROM EXERCICIO E
	JOIN SECAO S ON S.ID = E.SECAO_ID
	JOIN CURSO C ON C.ID = S.CURSO_ID
	GROUP BY C.NOME;

SELECT C.NOME, COUNT(A.ID) FROM CURSO C
	JOIN MATRICULA M ON M.CURSO_ID = C.ID
	JOIN ALUNO A ON A.ID = M.ALUNO_ID
	GROUP BY C.NOME;

##MEDIA DAS NOTAS POR CURSO
select c.nome, avg(n.nota) as media from nota n
    join resposta r on r.id = n.resposta_id
    join exercicio e on e.id = r.exercicio_id
    join secao s on s.id = e.secao_id
    join curso c on c.id = s.curso_id
group by c.nome;

## SOMENTE ALUNOS QUE TENHAM "Silva" OU "Santos" no SOBRENOME
select c.nome, avg(n.nota) as media from nota n
    join resposta r on r.id = n.resposta_id
    join exercicio e on e.id = r.exercicio_id
    join secao s on s.id = e.secao_id
    join curso c on c.id = s.curso_id
    join aluno a on a.id = r.aluno_id
where a.nome like '%Santos%' or a.nome like '%Silva%'
group by c.nome;

##CONTE A QUANTIDADE DE RESPOSTAS POR EXERCICIO. EXIBA A PERGUNTA E O NUMERO DE RESPOSTAS
select e.pergunta, count(r.id) as quantidade from exercicio e 
    join resposta r on r.exercicio_id = e.id
group by e.pergunta;

##ORDENANDO PELA COLUNA ORDEM DECRESCENTE
select e.pergunta, count(r.id) as quantidade from exercicio e 
    join resposta r on r.exercicio_id = e.id 
group by e.pergunta
order by count(r.id) desc;

##AGRUPANDO POR MAIS DE UM CAMPO, ALUNO.NOME E CURSO.NOME
select a.nome, c.nome, avg(n.nota) as media from nota n
    join resposta r on r.id = n.resposta_id
    join exercicio e on e.id = r.exercicio_id
    join secao s on s.id = e.secao_id
    join curso c on c.id = s.curso_id
    join aluno a on a.id = r.aluno_id
group by a.nome, c.nome;


###################HAVING###################

###ERRO POIS QUEREMOS FILTRAR ANTES DE AGRUPAR, PARA ISSO UTILIZAR O HAVING
SELECT A.NOME, C.NOME, AVG(N.NOTA) FROM ALUNO A
	JOIN RESPOSTA R.ON R.ID = N.RESPOSTA_ID
	JOIN EXERCICIO E ON E.ID = R.EXERCICIO_ID
	JOIN SECAO S ON S.ID = E.SECAO_ID
	JOIN CURSO C ON C.ID = S.CURSO_ID
	JOIN ALUNO A ON A.ID = C.ALUNO_ID
	WHERE N.AVG(N.NOTA) < 5
	GROUP BY A.NOME, C.NOME;
	
SELECT A.NOME, C.CURSO, AVG(N.NOTA) FROM NOTA N
	JOIN RESPOSTA.R ON R.ID = N.RESPOSTA_ID
	JOIN EERCICIO E ON E.ID = R.EXERCICIO_ID
	JOIN SECAO S ON S.ID = E.SECAO_ID
	JOIN CURSO C ON C.ID = S.CURSO_ID
	JOIN ALUNO A ON A.ID = R.ALUNO_ID
	GROUP BY A.NOME, C.NOME
	HAVING AVG(N.NOTA) < 5;
	
SELECT COUNT(A.ID), C.NOME FROM CURSO C 
	JOIN MATRICULA M ON M.CURSO_ID = C.ID
	JOIN ALUNO A ON A.ID = M.ALUNO_ID
	GROUP BY C.NOME
	HAVING COUNT(A.ID) < 3;
	
##DEVOLVER TODOS OS ALUNOS, CURSOS E SUAS MEDIA DE SUAS NOTAS. AGRUPAR POR ALUNO E CURSO, FILTRANDO PARA MOSTRAR APENAS COM MEDIA MENOR QUE 5
select a.nome, c.nome, avg(n.nota) as media from nota n
    join resposta r on r.id = n.resposta_id
    join exercicio e on e.id = r.exercicio_id
    join secao s on s.id = e.secao_id
    join curso c on c.id = s.curso_id
    join aluno a on a.id = r.aluno_id
group by a.nome, c.nome
having avg(n.nota) < 5;

##TODOS CURSOS E QUANTIDADE DE MATRICULA, EXIBINDO CURSO QUE TENHA MAIS DE 1 MATRICULA
select c.nome, count(m.id) as quantidade from curso c 
    join matricula m on c.id = m.curso_id
group by c.nome
having count(m.id) > 1;

##NOME DE CURSO E QUANTIDADE DE SECAO QUE EXISTE NELE , EXIBIR CURSO COM MAIS DE 3 SECOES
select c.nome, count(s.id) as quantidade from curso c 
    join secao s on c.id = s.curso_id
group by c.nome
having count(s.id) > 3

###########MULTIPLOS VALORES E A CONDICAO """"IN""""""################

##PARA SELECIONAR APENAS OS TIPOS DE FORMAS DE PAGAMENTO
SELECT DISTINCT TIPO FROM MATRICULA;

## SELECIONAR SE SAO PESSOAS FISICAS (PF) OU PESSOA JURIDICA(PJ) QUE PAGARAM
SELECT C.NOME, M.TIPO, COUNT(M.ID) AS QUANTIDADE FROM MATRICULA M
	JOIN CURSO C ON C.ID = M.CURSO_ID
	WHERE M.TIPO = 'PAGA PF' OR M.TIPO = 'PAGA PJ'
	GROUP BY C.NOME, M.TIPO;
	
## PASSAR GRUPO DE VALORES , USAR IN
SELECT C.NOME, M.TIPO, COUNT(M.ID) AS QUANTIDAE FROM MATRICULA M
	JOIN CURSO C.ON C.ID = M.CURSO_ID
	WHERE M.TIPO IN ('PAGA PF' , 'PAGA PJ')
	GROUP BY C.NOME, M.TIPO;
	
##TODOS CURSOS QUE DETERMINADOS ALUNOS FIZERAM
SELECT A.NOME, C.NOME FROM CURSO C
	JOIN MATRICULA M ON M.CURSO_ID = C.ID
	JOIN ALUNO A ON A.ID = M.ALUNO_ID
	WHERE A.ID IN ( 1,3,4)
	ORDER BY A.NOME;
	
##SELECIONAR ALUNOS QUE FIZERAM SQL , BANCO DE DADOS, PHP E MYSQL PARA DIVULGAR UM CURSO NOVO
SELECT A.NOME, C.NOME FROM CURSO C
	JOIN MATRICULA M ON M.CURSO_ID = C.ID
	JOIN ALUNO A ON ID = M.ALUNO_ID
	WHERE C.ID IN (1, 9);

###Exiba todos os tipos de matrícula que existem na tabela. Use DISTINCT para que não haja repetição.
select distinct tipo from matricula;

###Exiba todos os cursos e a sua quantidade de matrículas. Mas filtre por matrículas dos tipos PF ou PJ.
select c.nome, count(m.id) as quantidade from curso c 
    join matricula m on c.id = m.curso_id
where m.tipo = 'PAGA_PF' or m.tipo = 'PAGA_PJ'
group by c.nome;

##OU##
select c.nome, count(m.id) as quantidade from curso c 
    join matricula m on c.id = m.curso_id
where m.tipo in ('PAGA_PF', 'PAGA_PJ')
group by c.nome;

##Traga todas os exercícios e a quantidade de respostas de cada uma. Mas dessa vez, somente dos cursos com ID 1 e 3.
select e.pergunta, count(r.id) as quantidade from exercicio e 
    join resposta r on e.id = r.exercicio_id
    join secao s on s.id = e.secao_id
    join curso c on s.curso_id = c.id
where c.id in (1,3)
group by e.pergunta;

#######################SUBQUERY####################

#MEDIA INDIVIDUAL
SELECT A.NOME, C.NOME, AVG(N.NOTA) FROM NOTA N
	JOIN RESPOSTA R ON R.ID = N.RESPOSTA_ID
	JOIN EXERCICIO E ON E.ID = R.EXERCICIO_ID
	JOIN SECAO S ON S.ID = E.SECAO_ID
	JOIN CURSO C ON C.ID = S.CURSO_ID
	JOIN ALUNO A ON A.ID = R.ALUNO_ID
	GROUP BY C.NOME, A.NOME;
	
#MEDIA DOS ALUNOS
SELECT AVG(N.NOTA) FROM NOTA N;

#MEDIA INDIVIDUAL 0 MEDIA DA TURMA
SELECT A.NOME, C.NOME, AVG(N.NOTA) AS MEDIA, AVG(N.NOTA) - (SELECT AVG(N.NOTA) FROM NOTA N AS DIFERENCA FROM NOTA N
	JOIN RESPOSTA R ON R.ID = N.RESPOSTA_ID
	JOIN EXERCICIO E ON E.ID = R.EXERCICIO_ID
	JOIN SECAO S ON S.ID = E.SECAO_ID
	JOIN CURSO C ON C.ID = S.CURSO_ID
	JOIN ALUNO A ON A.ID = R.ALUNO_ID
	GROUP BY C.NOME, A.NOME;
	
##SELECIONA TODOS ALUNOS E A QUANTIDADE DE RESPOSTAS QUE CADA UM DEU

SELECT * A.NOME FROM ALUNO A;

SELECT COUNT(R.ID) FROM RESPOSTA R;

#UNIR AS 2 QUERYS

SELECT A.NOME, (SELECT COUNT(R.ID) FROM RESPOSTA R
	WHERE A.ID = R.ALUNO_ID) AS RESPOSTAS FROM ALUNO A;