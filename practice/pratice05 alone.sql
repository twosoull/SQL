select  first_name,
        manager_id,
        commission_pct,
        salary
from employees
where manager_id is not null
and commission_pct is null
and salary > 3000;

--2.

--부서별 최고급여를 찾고 그 아이디를 찾은 뒤에 아이디와 최고급여를 가진 사원을 비교해 찾는다
select  department_id,
        max(salary)
from employees
group by department_id;

select employee_id,
       first_name,
       salary,
       hire_date,
       phone_number,
       department_id
from employees
where (department_id , salary) in (select  department_id,
                                           max(salary) salary
                                   from employees
                                   group by department_id)
order by salary desc;


--3

select manager_id,
       round(avg(salary),0),
       min(salary),
       max(salary)
from employees
where to_char(hire_date, 'yyyy') >= '2005'
group by manager_id;

select em.employee_id as 매니저아이디,
       em.first_name as 매니저이름,
       avgsal as 매니저별평균급여,
       minsal as 매니저별최소급여,
       maxsal as 매니저별최대급여
from employees em , (select  manager_id,
                            round(avg(salary),0) avgsal,
                            min(salary) minsal,
                            max(salary)maxsal
                     from employees
                     where to_char(hire_date, 'yyyy') >= '2005'
                     group by manager_id) ma
where em.employee_id = ma.manager_id;



----4


select em.employee_id as 사번,  
       em.first_name as 이름,
       de.department_name as 부서명,
       pl.first_name as 매니저이름
from employees em left outer join departments de 
on em.department_id = de.department_id  ,(select employee_id,   
                                                 first_name             
                                          from employees)pl
where em.manager_id = pl.employee_id;


--5.
select employee_id,
       first_name,
       department_id,
       salary,
       hire_date
from employees
where to_char(hire_date, 'yyyy')>= '2005'
order by hire_date;

select rownum,
       employee_id,
       first_name,
       department_id,
       salary,
       hire_date 
from (select employee_id,
             first_name,
             department_id,
             salary,
             hire_date
      from employees
      where to_char(hire_date, 'yyyy')>= '2005'
    order by hire_date);
    
select emp.rnum,
       emp.employee_id as 사번,
       emp.first_name as 이름,
       de.department_name as 부서명,
       emp.salary as 급여,
       emp.hire_date as 입사일
from departments de,(select rownum rnum,
                           employee_id,
                           first_name,
                           department_id,
                           salary,
                           hire_date 
                     from (select employee_id,
                                  first_name,
                                  department_id,
                                  salary,
                                  hire_date
                           from employees
                           where to_char(hire_date, 'yyyy')>= '2005'
                           order by hire_date)) emp
where de.department_id = emp.department_id
and emp.rnum between 11 and 20
order by rnum asc;