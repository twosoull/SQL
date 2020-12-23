/**************************
******* Practice04*********
**************************/

--문제1. 평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
--(56건)

--1.평균 급여
select avg(salary)
from employees;

--2.급여구하기
select count(salary)
from employees
where salary <  (select avg(salary)
                 from employees);
                 
--문제2.  평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
--직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
--(51건)

-- 1. 평균금여와 최대급여
select avg(salary), max(salary)
from employees;

--2.답 구하기

select em.employee_id as 직원번호,
       em.first_name as 이름,
       em.salary as 급여,
       empl.avgsal as 평균급여,
       empl.maxsal as 최대급여
from employees em , (select avg(salary) avgsal, 
                            max(salary) maxsal
                     from employees) empl
where em.salary >= empl.avgsal
and em.salary<= empl.maxsal
order by 급여 asc;
--이렇게 구한 이유는 처음 문제를 봤을 때에 절대로 쿼리문 하나에서 그냥급여와 평균급여,최대급여같은 그룹함수가 나올 수 없다는 판단이었기에 다른 서브 쿼리문
--필요하다 느꼇고 웨어문의 경우에는 조건만 추가할 뿐 쿼리문을 따로 불러오는 식이 아니기 때문에 from절에 서브쿼리문을 추가하는 식으로 풀어보았다

--문제3. 직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
--도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 
--를 출력하세요
--(1건)

select em.first_name|| ' ' || em.last_name as 이름,
       em.department_id,
       lo.location_id , 
       lo.street_address,
       lo.postal_code,
       lo.city,
       lo.state_province,
       lo.country_id
from employees em,departments de,locations lo
where em.department_id = de.department_id
and de.location_id = lo.location_id
and em.first_name = 'Steven'
and em.last_name = 'King';

--이렇게 조인 식으로 완성 시킬 수도 있고
select department_id,
       first_name||' ' || last_name as name 
from employees
where upper(first_name) = 'STEVEN'
and upper(last_name) = 'KING';
-- 이렇게 미리 스티븐 킹의 정보를 만든 다음에 FROM 문에 서브쿼리로 넣을 수도 있다

select lo.location_id , 
       lo.street_address,
       lo.postal_code,
       lo.city,
       lo.state_province,
       lo.country_id
from departments de,locations lo,(select department_id,
                                         first_name||' ' || last_name as name  
                                        from employees
                                        where upper(first_name) = 'STEVEN'
                                        and upper(last_name) = 'KING') em
where em.department_id = de.department_id
and de.location_id = lo.location_id;


--문제4. job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용
--(74건)


--1. 먼저 job_id가 'ST_MAN'인 직원의 급여 구한다.
select salary 
from employees
where job_id = 'ST_MAN';

--2. 서브쿼리 대입해서 구하기

select department_id as 사번,
       first_name as 이름,
       salary as 급여
from employees
where salary <any(select salary 
                  from employees
                  where job_id = 'ST_MAN')
order by 급여 desc;

--문제5. 각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
--조건절비교, 테이블조인 2가지 방법으로 작성하세요
--(11건)

--1. 조건절 비교가 되었던 테이블조인이 되었던  일단 확실한 것은 부서별로 라는 이름에 그룹절을 사용해야 한다는 것을 암시한다.
--그룹절이 들어가게 되면 그룹이외의 직원번호,이름,급여 처럼 그룹함수가 아닌것은 사용할 수가 없게 되니, 조인을 쓰긴해야한다는 것
select department_id,
       max(salary) 
from employees
group by department_id;

--2. 조건절 비교
select  employee_id as 직원번호,
        first_name as 이름,
        salary as 급여,
        department_id as 부서번호
from employees
where (department_id,salary) in (select department_id,
                                max(salary)  
                                 from employees
                                 group by department_id);
--웨어절을 저렇게 표현한 것은 만약 급여의 값만 in을 사용했다면 디파트먼트 아이디가 달라도 급여가 맞다면 같이 조회될 수 있기 때문이다.
-- 그럼 아이디값만 넘어올 경우에는 아이디 값이 아예 모든 부서아이디를 가지고있기에 모두 출력되는 결과가 나온다

--3.테이블 조인

select  em.employee_id as 직원번호,
        em.first_name as 이름,
        em.salary as 급여,
        em.department_id as 부서번호   
from employees em, (select department_id,
                           max(salary) as salary
                    from employees
                    group by department_id) sq --1.테이블 조인을 쓰면 테이블 옆에 테이블이 하나더 생기는 식이다.
where em.department_id = sq.department_id
and em.salary = sq.salary;  --2. 그래서 이런 웨어문이 가능해진다

--문제6. 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
--(19건)


--1.업무별 연봉의 총합
select job_id,
       sum(salary)
from employees
group by job_id;

--2. 서브쿼리대입

select  jo.job_title,
        pl.salary
from jobs jo,(select job_id,
                    sum(salary) salary
              from employees
              group by job_id)pl 
where jo.job_id = pl.job_id
order by pl.salary desc;


--문제7. 자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
--(38건)

--1. 평균연봉 구하기

select  department_id,
        avg(salary)
from employees
group by department_id;

--2. 대입 , 서브쿼리 조인으로

select em.employee_id as 직원번호,
       em.first_name as 이름,
       em.salary as 급여
from employees em,(select  department_id,
                         avg(salary) sal
                 from employees
                 group by department_id) pl
where em.department_id = pl.department_id
and em.salary >all (pl.sal);

--부서별로 서로 다른 평균값을 가지고있기 때문에 먼저 department_ id로 같은 값을 잡아준 뒤에 비교로 평균임급값을 대입해 줬습니다


--문제8.
--직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
--1.rownum으로 숫자를 매기기는 모든 데이터가 다 준비가 된뒤에 붙여줘야 하기 때문에 입사일 순서먼저 정해줘야한다. rownum을 한뒤에
-- 정렬을 하면 다시 뒤섞이기 때문이다.
select employee_id,
       first_name,
       salary,
       hire_date
from employees
order by hire_date;

----

--rownum을 붙였다고 바로 1번째부터를 제외한 조건을 where문으로 넣으려하면 select 이전에 처리하기때문에 rownum문은 1번째를 계속 만드려고시도해서
--결국 아무것도 표시가 안된다.
select rownum,
       o.employee_id,
       o.first_name,
       o.salary,
       o.hire_date
from (select employee_id,
             first_name,
             salary,
             hire_date
      from employees
      order by hire_date)o;

---그러므로 rowmun이 모두 만들어진 다음에 where문을 넣어줘야하기 때문에 서브퀄리문으로 빼내야한다

select ro.rnum,
       ro.employee_id,
       ro.first_name,
       ro.salary,
       ro.hire_date
from (select rownum as rnum,
             o.employee_id,
             o.first_name,
             o.salary,
             o.hire_date
       from (select employee_id,
                    first_name,
                    salary,
                    hire_date
             from employees
             order by hire_date)o
             )ro
where ro.rnum >=11
and ro.rnum <=15