with recursive
    tmp (id, price) as (
        select t1.id, t1.price
        from products t1
        
        union
        
        select t2.id, coalesce(t2.price, tmp.price) as price
        from products t2
        join tmp on t2.parent_id = tmp.id
        )
select *
from tmp
where price is not null
order by id;
