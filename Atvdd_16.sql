-- 1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.
DO $$ 
DECLARE --1 declarando cursor
    cur_youtubers CURSOR FOR 
        SELECT rank, youtuber 
        FROM tb_top_youtubers 
        WHERE video_count >= 1000 
          AND category IN ('Sports', 'Music'); 
    tupla RECORD; 
BEGIN --2 abrindo cursor
    OPEN cur_youtubers; 
    LOOP -- 3 recuperando dados de interesse
        FETCH cur_youtubers INTO tupla; 
        EXIT WHEN NOT FOUND; 
        RAISE NOTICE 'Rank: %, Youtuber: %', tupla.rank, tupla.youtuber; 
    END LOOP; --4 fechando cursor
    CLOSE cur_youtubers; 
END; 
$$

-- 2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal O SELECT deverá ordenar em ordem não reversa;
-- - O Cursor deverá ser movido para a última tupla;
-- - Os dados deverão ser exibidos de baixo para cima;

DO $$
DECLARE 
--1 Declarando cursor
    cur_reverse REFCURSOR;
    tupla RECORD;
BEGIN -- 2 abrindo cursor
    OPEN cur_reverse SCROLL FOR --SCROLL É PARA ROLAR DE BAIXO PARA CIMA
        SELECT * FROM tb_top_youtubers;
    LOOP
    --3 Recuperando dados de interesse
        FETCH cur_reverse INTO tupla;
        EXIT WHEN NOT FOUND;
        --oque esta a direita do ponto é membro de quem esta a esquerda do ponto
    END LOOP;
    LOOP
        FETCH BACKWARD FROM cur_reverse INTO tupla;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE '%', tupla.youtuber;
    END LOOP;
    --4 fechando o cursor
    CLOSE cur_reverse;
END;
$$