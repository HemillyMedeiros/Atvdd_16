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