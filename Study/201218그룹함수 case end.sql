/*
*****************
*그룹함수
*****************
*/
--이론적으로 알고있을것 avg는 하나의 행으로밖에 표현할수 없다
select avg(salary),
       first_name 
from employees;


--그룹함수 avg()
select avg(salary)
from employees;

--그룹함수 count()
select count(*) -- null 포함
from employees;

select count(commission_pct) -- null포함하지 않는다.
from employees;

select count(*)
from employees
where salary >16000;

select count(*), sum(salary), avg(salary)
from employees;

--그룹함수 - avg() null일때 0으로 변환

select  count(*),
        sum(salary),
        avg(nvl(salary,0))
from employees;

--그룹함수 - max() / min()

select max(salary)
from employees;

select min(salary)
from employees;

--정렬이 필요한 경우 많은 연산을 수행해야 한다.
select  max(salary),
        min(salary),
        count(*)
from employees;

/*
*group by 절
*/

select department_id,
       avg(salary)      ---오류 
from employees
order by department_id asc;

select department_id,
       round(avg(salary),0) 
from employees
group by department_id;

--group by 절 - 자주하는 오류

select  department_id,
        count(*),
        sum(salary),
        
from employees
group by department_id;

select  department_id,
        count(*),
        sum(salary),
        job_id
from employees
group by department_id;



select  department_id,
        job_id,
        count(*),
        sum(salary)
from employees
group by department_id, job_id
order by department_id asc;

--연봉의 합계가 20000 이상인 부서의 부서번호와, 인원수, 급여합계를 출력하세요

select department_id,
       count(*),
       sum(salary)
from employees
where sum(salary)>=20000
group by department_id;

--having 절
select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary)>=20000;

select department_id,
       count(*),
       sum(salary)
from employees
group by department_id
having sum(salary)>=20000
and department_id = 100;

/****
***case ~ end
****/

select  employee_id,
        salary,
        job_id,
        case
            when job_id = 'AC_ACCOUNT' then SALARY*0.1
            when job_id = 'SA_REP' then salary*0.2
            when job_id = 'ST_CLERK' then salary*0.3
            else salary*0
        end bonus -- 별명
       
from employees;


select  employee_id,
        salary,
        job_id,
        decode( job_id, 'AC_ACCOUNT', salary*0.1,
                        'SA_REP', salary*0.2,
                        'ST_CLERK',salary*0.3,
                salary*0
        ) as bonus
       
from employees;

--직원의 이름, 부서, 팀을 출력하세요
--팀은 코드로 결정하며 부서코드가 10~50이면 'A-TEAM'
--60~100이면 'B-TEAM' 110~150이면 'C-TEAM'나머지는 '팀없음'으로 출력하세요

select first_name,
       department_id,
       case
       when department_id >=10 AND department_id <=50 then 'A-TEAM'
       when department_id >=60 AND department_id <=100 then 'B-TEAM'
       when department_id >=110 AND department_id <=150 then 'C-TEAM'
            ELSE '팀없음'
       end TEAM
from employees;