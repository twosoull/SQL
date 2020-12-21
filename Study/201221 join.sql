select e.first_name,
        ddepartment_name,
        e.department_id
from employees e,departments d
where e.department_id = d.department_id;


select emp.first_name,
        job.job_title,
        dep.department_name,
        emp.department_id,
        dep.department_id,
        emp.job_id,
        job.job_id
from employees emp,departments dep,jobs job
where emp.job_id = job.job_id
and emp.department_id = dep.department_id;

--left 조인

select em.department_id,
       em.first_name,
       de.department_name
from employees em left outer join departments de
on em.department_id = de.department_id;

--right 조인

select em.department_id,
       em.first_name,
       de.department_name
from employees em right outer join departments de
on em.department_id = de.department_id;

--right 조인 --> left 조인

select em.department_id,
       em.first_name,
       de.department_id,
       de.department_name
from departments de left outer join employees em
on de.department_id = em.department_id;

select e.department_id, e.first_name, d.department_name
  from employees e, departments d
 where e.department_id = d.department_id(+) ; 



select em.first_name,
       de.department_id, 
       de.department_name
from departments de left outer join employees em
on em.department_id = de.department_id;



select e.first_name,
        e.job_id,
       j.job_id ,
       j.job_title
from employees e left outer join jobs j
on e.job_id = j.job_id;


select e.department_id , e.first_name, d.department_name
from employees e, departments d
where e.department_id(+) = d.department_id;


--full outer join

select *
from employees em full outer join departments de
on em.department_id = de.department_id;

select
       em.first_name,  
    de.department_name
  
from employees em,departments de
where em.department_id = de.department_id
order by em.department_id desc;


select e.first_name,
        e.manager_id,
        m.employee_id,
        m.first_name
from employees e, employees m
where m.employee_id = e.manager_id;

--잘못된 사용예
select *
from employees em, locations lo
where em.salary = lo.location_id ;