declare
        cursor insert_installment_paid_cur is
            select contract_id
            from contracts;
begin 
        for paid_row in insert_installment_paid_cur loop
                insert_installment_paid(paid_row.contract_id);
        end loop;
end;