/**************************************
*
**************************************/

--급여를 가장 많이 받는 5명의 직원의 이름을 출력하시오.

--rownum이 orderby 보다 먼저 생겨서 번호가 섞인다.
select  rownum as num,
        employee_id,
       first_name,
       salary
from employees
order by salary desc;

--정렬하고 rownum을 사용

select rownum,
       o.id,
       o.first_name,
       o.salary
from   (select  emp.employee_id id,
        emp.first_name,
        emp.salary
        from employees emp
        order by salary desc) o; -- salary로 정렬되어있는 테이블 사용
        
        
where rownum >= 1
and rownum <=5;

select  emp.employee_id,
        emp.first_name,
        emp.salary
from employees emp
order by salary desc;

--일련번호주고 바로 조건을 판단해서 
select   --rownum  -- 이건 테이블에서 끌어오는게 아닌 또 rownum을 매기는 것이니 이전 테이블에 별명을 넣어 사용해야한다
        ro.rnum,
        ro.id,
        ro.first_name,
        ro.salary
from (select rownum rnum,  
             o.id,
             o.first_name,
             o.salary
      from   (select  emp.employee_id id,
                      emp.first_name,
                      emp.salary
              from employees emp
              order by salary desc) o
      ) ro
where  rnum>=11
and rnum <=20;


--예제)
--07년에 입사한 직원중 급여가 많은 직원중 3에서 7등의 이름 급여 입사일은?


(select first_name,
       salary,
       hire_date
from employees
where to_char(hire_date,'yy') = '07'
order by salary desc)o;

select rownum,
       em.first_name,
       em.salary
from (select first_name,
             salary,
             hire_date
      from employees
      where to_char(hire_date,'yy') = '07'
      order by salary desc) em;
      
select rr.rnum,
       rr.first_name,
       rr.salary,
       rr.hire_date
from (select rownum as rnum,
             em.first_name,
             em.salary,
             em.hire_date
      from (select first_name,
                   salary,
                   hire_date
            from employees
            where to_char(hire_date,'yy') = '07'
            order by salary desc) em
      )rr 
where rnum>=3
and rnum<=7;