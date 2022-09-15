declare
        
        cursor payment_installment_cur is
            select * from contracts;
            
begin
        for cont_row in payment_installment_cur loop
            update_payment_no(cont_row.contract_id, cont_row.contract_payment_type, cont_row.contract_enddate, cont_row.contract_startdate);
        end loop;
end;
