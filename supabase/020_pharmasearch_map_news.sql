-- V3 carte et recherche ciblée
create or replace function public.search_medicine_in_pharmacy(p_pharmacy_id uuid,p_query text)
returns table(medicine_id uuid,medicine_name text,dci text,dosage text,pharmaceutical_form text,availability text,updated_at timestamptz)
language sql stable security definer set search_path=public as $$
select m.id,m.commercial_name,m.dci,m.dosage,m.form,
case when sum(i.quantity)>10 then 'Disponible' when sum(i.quantity)>0 then 'Stock limité' else 'Indisponible' end,max(i.updated_at)
from medicines m join inventory_items i on i.medicine_id=m.id join pharmacies p on p.id=i.pharmacy_id
where i.pharmacy_id=p_pharmacy_id and p.is_verified and p.is_active and m.is_active
and (i.expiry_date is null or i.expiry_date>=current_date)
and (coalesce(trim(p_query),'')='' or m.commercial_name ilike '%'||trim(p_query)||'%' or coalesce(m.dci,'') ilike '%'||trim(p_query)||'%' or coalesce(m.dosage,'') ilike '%'||trim(p_query)||'%')
group by m.id,m.commercial_name,m.dci,m.dosage,m.form order by max(i.updated_at) desc limit 50$$;
grant execute on function public.search_medicine_in_pharmacy(uuid,text) to anon,authenticated;
notify pgrst,'reload schema';