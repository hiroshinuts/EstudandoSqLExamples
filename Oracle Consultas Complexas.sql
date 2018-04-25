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
