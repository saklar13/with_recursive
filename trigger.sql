create or replace function change_product_num() returns trigger as
$$

begin
    if tg_op = 'INSERT' then
        update company
            set products_num = products_num + 1
        where id = new.company_id;
        return new;
    elsif tg_op = 'DELETE' then
        update company
            set products_num = products_num - 1
        where id = old.company_id;
        return old;
    end if;
end;
$$ language plpgsql;


create trigger t
after insert or delete on product for each row
execute procedure change_product_num;
