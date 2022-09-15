set serveroutput on
declare
              
        cursor seq_cersor is
            select distinct cons.table_name, tab.column_name
            from all_cons_columns  cons
            join all_constraints  acons
            on cons.constraint_name = acons.index_name
            join all_tab_cols tab
            on tab.column_name = cons.column_name
            where cons.owner = 'HR' and constraint_type = 'P' and tab.data_type = 'NUMBER';

begin  
        for seq_data in seq_cersor loop
        execute immediate 'CREATE SEQUENCE '||seq_data.table_name||'_SEQ  
             START WITH 600 
             INCREMENT BY 1 
             MAXVALUE 999999999999999999999999999 
             MINVALUE 1 
             NOCYCLE 
             CACHE 20 
             NOORDER';
         execute immediate 'create or replace trigger '||seq_data.table_name||'_trig 
            before insert on '||seq_data.table_name||' for each row begin
                    :new.'||seq_data.column_name||' := '||seq_data.table_name||'_SEQ.nextval; end;';
     end loop;
end;


