-- from 절 where 절 표현방법 , (+) < == 오라클에서만 가능
/*
left/right/full outer join ~ on

inner join --> 양쪽이 만족하는 경우 null은 제외
 inner join ~ on





outer join --> 기준이 되는 쪽은 포함 비교되는 쪽은 null

left outer join ~ on
right outer join ~ on
full outer join ~ on
*/
--inner
select first_name , em.department_id,
department_name,de.department_id
from employees em inner join departments de
on em.department_id = de.department_id;


/**********************************
*서브 쿼리 
**********************************

'Den'보다 급여가 많은 사람의 이름과 급여는?
--> 10000보다 급여가 많은 사람의 이름과 급여는?
*/
select employee_id,
        first_name,
       salary
from employees
where salary > 11000;

--'Den'의 급여는?
select employee_id,
       first_name,
       salary
from employees
where first_name = 'Den';
--'Den'보다 급여 노휴은 사람
select employee_id,
        first_name,
       salary
from employees
where salary > 11000;

--1개의 질문으로 해결 (subquery)
select employee_id,
        first_name,
       salary
from employees
where salary > (select salary
                from employees
                where first_name = 'Den');
                
                
                
--예제)
--급여를 가장 적게 받는 사람의 이름, 급여, 사원번호는?
--1.가장 적은 급여액수 -->2100
--2.500을 받는 직원의 이름,급여,사원번호는?

select min(salary) 
from employees;


select first_name,
       salary,
       employee_id
from employees
where salary = (select min(salary) 
                from employees);
                
                
--평균 급여보다 적게 받는 사람의 이름, 급여를 출력하세요

--평균급여
select avg(salary)
from employees;


--

select first_name,
       salary     
from employees
where salary <  (select avg(salary)
                from employees);
                
                
--예제
--부서번호가 110인 직원의 급여와 같은 모든 직원의
--사번, 이름, 급여를, 출력하세요
--1. 부서번호 110인 직원의 이름,급여,...리스트
select  first_name,
        salary,
        department_id
from employees
where department_id = 110;


--2. 전체직원 중 급여가 12008,8300 인 직원
select employee_id,
       first_name,
       salary,
       department_id
from employees
where salary in(select  salary
                from employees
                where department_id = 110
                );


--예제
--부서별로 최고급여를 받는 사원을 출력하세요

--1. 부서별 최고 급여 얼마인지? 누구는 못구함

select  --employee --누구는 못구함
        department_id,
        max(salary)
from employees
group by department_id;
--2. 전체 사원테이블에서 부서번호와 급여 같은 사람을 찾는다
--   부서별 최고 급여 리스트를 기준으로
select first_name,
       employee_id,
       salary,
       department_id
from employees
where (department_id, salary) in(select department_id,
                                     max(salary)
                                from employees
                                group by department_id);


--부서가 110인 직원의 급여보다 큰 모든 직원의 
--사번, 이름, 급여를 출력하세요.(or연산 --> 8300보다 큰


--부서번호 100인 직원의 급여 리스트
select *
from employees
where department_id = 110; -- 12008, 8300

select employee_id,
       first_name,
       salary
from employees
where salary >any (  select salary
                    from employees
                    where department_id = 110); --12008,8300
                    


--Sub Query 로 테이블 만들기 --> join으로 사용
--각 부서별로 최고급여를 받는 사원을 출력하세요
--1. 각 부서별로 최고 급여 테이블
select department_id,
        max(salary)
from employees
group by department_id;

--2. 직원테이블 (1) 테이블을 join 한다.
select  e.employee_id,
        e.first_name,   
        e.salary,
        e.department_id,
        s.department_id,
        s.salary
from employees e, (select  department_id,
                             max(salary) as salary
                     from employees
                     group by department_id) s
where e.department_id = s.department_id
and e.salary = s.salary

