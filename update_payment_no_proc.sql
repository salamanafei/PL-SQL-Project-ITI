CREATE OR REPLACE procedure HR.update_payment_no (
            v_contract_id number,
            v_contract_payment_type varchar2,
            v_contract_enddate date,
            v_contract_startdate date)
is
begin 

            update contracts
            set payment_installment_no = 
                    case v_contract_payment_type when 'annual' then months_between(v_contract_enddate, v_contract_startdate) / 12
                    when  'half_annual' then months_between(v_contract_enddate, v_contract_startdate) / 6
                    when  'quarter' then months_between(v_contract_enddate, v_contract_startdate) / 3
                    else months_between(v_contract_enddate, v_contract_startdate)
                    end
             where contract_id = v_contract_id;
end;