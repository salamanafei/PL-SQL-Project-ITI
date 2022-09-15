create or replace procedure insert_installment_paid(v_con_id number)
is
        v_payment_installment_no number(11);
        v_contract_payment_type varchar2(50);
        v_contract_id number(5);
        v_startdate date;
        v_installment_amount number(10);
        v_contract_startdate date;
        v_contract_total_fees number(11);
        v_contract_deposit_fees number(11);
begin
        select payment_installment_no, contract_payment_type, contract_startdate, contract_total_fees, nvl(contract_deposit_fees,0)
        into v_payment_installment_no, v_contract_payment_type, v_startdate, v_contract_total_fees, v_contract_deposit_fees
        from contracts
        where contract_id = v_con_id ;
        
        v_contract_startdate := v_startdate;
        v_installment_amount := (v_contract_total_fees - v_contract_deposit_fees) / v_payment_installment_no;
        
        for i in 1..v_payment_installment_no loop
            
            if v_contract_payment_type  =  'annual' then
                insert into installments_paid (contract_id, installment_date, installment_amount, paid)
                values(v_con_id, v_contract_startdate, v_installment_amount, 0);
                v_contract_startdate := add_months(v_contract_startdate, 12);
              
            elsif v_contract_payment_type  = 'half_annual' then
                insert into installments_paid (contract_id, installment_date, installment_amount, paid)
                values(v_con_id, v_contract_startdate, v_installment_amount, 0);
                v_contract_startdate := add_months(v_contract_startdate, 6);
                
            elsif v_contract_payment_type  = 'quarter' then
                insert into installments_paid (contract_id, installment_date, installment_amount, paid)
                values(v_con_id, v_contract_startdate, v_installment_amount, 0);
                v_contract_startdate := add_months(v_contract_startdate, 3);
                
            else 
                insert into installments_paid (contract_id, installment_date, installment_amount, paid)
                values(v_con_id, v_contract_startdate, v_installment_amount, 0);
            end if;
        end loop;
end;
show errors;

