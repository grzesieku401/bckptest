create or replace FUNCTION test_git_backup_function RETURN VARCHAR2 IS
    v_counter   NUMBER;
BEGIN
    --how many records for backup
    SELECT
        count(*) INTO v_counter
    FROM
        test_table
    WHERE
        1 = 1;
    
    --no records to backup = no backup
    IF v_counter = 0   THEN
        RETURN 'The number of backup records is '|| v_counter;
    END IF;

    v_counter := 0;
    
    --create file with records to backup
    DECLARE
        b_file UTL_FILE.FILE_TYPE; 
        v_length    NUMBER;
        v_start     NUMBER :=1;
        v_size      NUMBER := 5000;
        v_part_of_clob  VARCHAR2(5000);
    BEGIN
        b_file := UTL_FILE.FOPEN(location     => 'TEST_DIR',
                       filename     => 'backup.txt',
                       open_mode    => 'w',
                       max_linesize => 32767);

        utl_file.put(b_file,'ID;NAME;TEXT;TEXT_XML;SOME_COLUMN');
        UTL_FILE.NEW_LINE (b_file);   
        FOR i IN (
            SELECT
                *
            FROM
                test_table
            WHERE
                1 = 1
        ) LOOP

            utl_file.put(b_file, i.id || ';');
            utl_file.put(b_file, i.name || ';');

            v_length := dbms_lob.getlength(i.text);

            WHILE v_start <= v_length
            LOOP
                v_part_of_clob :=DBMS_LOB.SUBSTR (i.TEXT, v_size, v_start);
                UTL_FILE.PUT(b_file,v_part_of_clob|| '');  
                v_start   := v_start + v_size;
            END LOOP;
            UTL_FILE.PUT(b_file,v_part_of_clob|| ';');  
            v_start := 1;

            v_length := dbms_lob.getlength(xmltype.getclobval(i.text_xml));

            WHILE v_start <= v_length
            LOOP
                v_part_of_clob :=DBMS_LOB.SUBSTR (xmltype.getclobval(i.text_xml), v_size, v_start);
                UTL_FILE.PUT(b_file,v_part_of_clob|| '');  
                v_start   := v_start + v_size;
            END LOOP;
            UTL_FILE.PUT(b_file,v_part_of_clob|| ';');  
            v_start := 1;

            utl_file.put(b_file, i.some_column);  
            UTL_FILE.NEW_LINE (b_file);           


            v_counter := v_counter + 1;
        END LOOP;

      UTL_FILE.FCLOSE(b_file);

    EXCEPTION
      WHEN OTHERS THEN
        UTL_FILE.FCLOSE(b_file);
        UTL_FILE.FREMOVE(location     => 'TEST_DIR',
                       filename     => 'backup.txt');
        RETURN 'Something went wrong while creating the backup file';
    END;
    
    --create file with bash script
    DECLARE
        b_file UTL_FILE.FILE_TYPE; 
    BEGIN
        b_file := UTL_FILE.FOPEN(location     => 'TEST_DIR',
               filename     => 'bs.sh',
               open_mode    => 'w',
               max_linesize => 32767);
               
        utl_file.put_line(b_file,'#!/bin/bash');      
        utl_file.put_line(b_file,'git --version');
        utl_file.put_line(b_file,'git status');    
        utl_file.put_line(b_file,'git init');    
        utl_file.put_line(b_file,'git switch -c develop');    
        utl_file.put_line(b_file,'git config --local user.name grzesieku401');    
        utl_file.put_line(b_file,'git config --local user.email regisu401@gmail.com');    
        utl_file.put_line(b_file,'git add backup.txt');    
        utl_file.put_line(b_file,'git commit -m "My file"'); 
        utl_file.put_line(b_file,'git remote add origin https://github.com/grzesieku401/testbash');
        utl_file.put_line(b_file,'git push origin develop');    
        
        UTL_FILE.FCLOSE(b_file);

    EXCEPTION
      WHEN OTHERS THEN
        UTL_FILE.FCLOSE(b_file);
        UTL_FILE.FREMOVE(location     => 'TEST_DIR',
                       filename     => 'bs.sh');
        RETURN 'Something went wrong while creating the bash file';
    END;

    RETURN 'The number of backup records is '|| v_counter;
END;