/***********************************
*****Practice05*********************
***********************************/

--문제1.담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
--이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
--(45건)


select first_name||' ' ||last_name as 이름,
       manager_id,
       commission_pct,
       salary
from employees 
where manager_id is not null
and commission_pct is null
and salary >3000;

--문제2.  각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 
        --전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
--조건절비교 방법으로 작성하세요
--급여의 내림차순으로 정렬하세요
--입사일은 2001-01-13 토요일 형식으로 출력합니다.
--전화번호는 515-123-4567 형식으로 출력합니다.
--(11건)
--1.
select department_id,
       max(salary) 
from employees
group by department_id;

--2.
select employee_id as 직원번호,
       first_name as 이름,
       salary as 급여,
       to_char(hire_date,'yyyy-mm-dd day') as 입사일,
       replace(phone_number,'.','-') as 전화번호,
       department_id as 부서번호
from employees
where (department_id,salary) in (select department_id,
                                        max(salary) 
                                 from employees
                                 group by department_id)
order by 급여 desc;


--문제3 매니저별 담당직원들의 평균급여 최소급여 최대급여를 알아보려고 한다.
--통계대상(직원)은 2005년 이후의 입사자 입니다.
--매니저별 평균급여가 5000이상만 출력합니다.
--매니저별 평균급여의 내림차순으로 출력합니다.
--매니저별 평균급여는 소수점 첫째자리에서 반올림 합니다.
--출력내용은 매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여 입니다.
--(9건)
--1. 매니저아이디별로 그룹화 및 조건넣기
select manager_id,
       round(avg(salary),0), 
       max(salary),
       min(salary)
from employees
where to_char(hire_date,'yyyy') >='2005'
group by manager_id
having avg(salary)>=5000;

--2.대입
select em.employee_id,
       em.first_name as 매니저이름,
       o.매니저별평균급여,
       o.매니저별최소급여,
       o.매니저별최대급여
from employees em ,(select  manager_id,
                            round(avg(salary),0) as 매니저별평균급여, 
                            max(salary) as 매니저별최대급여,
                            min(salary) as 매니저별최소급여
                    from employees
                    where to_char(hire_date,'yyyy') >='2005'
                    group by manager_id
                    having avg(salary)>=5000) o
where em.employee_id = o.manager_id;


--문제4.각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 
                                --매니저(manager)의 이름(first_name)을 조회하세요.
--부서가 없는 직원(Kimberely)도 표시합니다.
--(106명)

select em.employee_id as 사번,
       em.first_name as 이름,
       em.department_id as 부서명,
       pl.first_name as 매니저이름
from employees em inner join employees pl
on em.manager_id = pl.employee_id;


--문제5. 2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
--사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요

--1. lownum을 사용하기 전에 미리 정렬을 해둠 (lownum이후 정렬은 번호를 다시 섞는다)
select employee_id ,
       first_name,
       department_id,
       salary,
       hire_date
from employees
where to_char(hire_date,'yyyy')>='2005'
order by hire_date asc;

--2. lownum이 있는 상태로 조건을 걸게되면 1번이 계속지워져서 조회자체가 안된다.

select rownum,
       o.employee_id ,
       o.first_name,
       o.department_id,
       o.salary,
       o.hire_date
from (select employee_id ,
             first_name,
             department_id,
             salary,
             hire_date
      from employees
      where to_char(hire_date,'yyyy')>='2005'
      order by hire_date asc)o;
 --3. 조건 대입을 하지만 불러온 테이블에  rownum 자체를 사용하면 rownum을 한번더 사용하는 꼴이기 때문에 꼭 별명을 붙여줘야한다
 
 select ln.rnum,
        ln.employee_id as 사번,
        ln.first_name as 이름,
        de.department_name as 부서명,
        ln.salary as 급여,
        ln.hire_date as 입사일
 from departments de ,(select rownum as rnum,
              o.employee_id ,
              o.first_name,
              o.department_id,
              o.salary,
              o.hire_date
        from (select employee_id ,
                     first_name,
                     department_id,
                     salary,
                     hire_date
              from employees
              where to_char(hire_date,'yyyy')>='2005'
              order by hire_date asc)o
              )ln
where ln.department_id = de.department_id
and ln.rnum between 11 and 20 ;

--문제6.
--가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
--1. 가장늦게입사한 날
select *
from employees;

select max(hire_date)
from employees;


--2. 동일한 입사날을 가진 직원이름 연봉 그리고 부서이름을 알기위해 departments의 테이블을 가져와 사용

select em.first_name||' ' || em.last_name as 이름,
       em.salary as 연봉,
       de.department_name as "부서 이름",
       em.hire_date
from employees em ,departments de , (select max(hire_date) maxhire
                                     from employees)mh
where em.hire_date = mh.maxhire
and de.department_id = em.department_id;

--문제7. 평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  
--업무(job_title), 연봉(salary)을 조회하시오.

--1.부서의 평균연봉을 먼저 구한다
select department_id,
       avg(salary) 
from employees
group by department_id;

--1.5 모든부서의 평균연봉중 가장 높은연봉을 구한다
select max(salary)
from (select  department_id as depar_id,
              avg(salary) as salary
      from employees
      group by department_id);
--2. 1과 1.5를 이용해 가장높은 평균연봉의 부서를 구한다
select avgde.avgsal,
       maxde.maxsal,
       avgde.de_id
from (select department_id de_id,
            avg(salary) as avgsal
      from employees
      group by department_id)avgde , (select max(salary) as maxsal
                                      from (select  department_id ,
                                                    avg(salary) salary
                                            from employees
                                            group by department_id)
                                      ) maxde
where avgde.avgsal = maxde.maxsal;
--3. 2를 대입해서 직원의 정보를 구한다.
select em.employee_id as 직원번호,
       em.first_name  as 이름,
       em.last_name as 성,
       jo.job_title as 업무,
       em.salary as 급여
from employees em, jobs jo,(select avgde.avgsal,
                                   maxde.maxsal,
                                   avgde.de_id as de_id
                            from (select department_id de_id,
                                         avg(salary) as avgsal
                                  from employees
                                  group by department_id)avgde , (select max(salary) as maxsal
                                                                  from (select  department_id ,
                                                                                avg(salary) salary
                                                                                from employees
                                                                                group by department_id)
                                                                  ) maxde
                             where avgde.avgsal = maxde.maxsal)de 
where em.department_id = de.de_id
and em.job_id = jo.job_id;


--문제8.평균 급여(salary)가 가장 높은 부서는? 

--1.부서의 평균 급여를 먼저 구해준다
select department_id,
       avg(salary) 
from employees
group by department_id;

--2 1번을 이용해서 그 중 최고 급여를 구한다
select max(salary) 
from (select department_id,
             avg(salary) salary 
      from employees
      group by department_id);

--3. 2번 테이블의 맥스 값으로 1번테이블의 평균급여중 가장 높은 급여를찾고 그 department_id를 찾아서 대입한다

select de.department_name
from departments de , (select department_id avgde_id,
                              avg(salary) avgsal
                       from employees
                       group by department_id)avgde, (select max(salary) maxsal
                                                       from (select department_id,
                                                                     avg(salary) salary 
                                                             from employees
                                                             group by department_id)
                                                       )maxde
where avgde.avgsal = maxde.maxsal
and  avgde.avgde_id = de.department_id;


--문제9. 평균 급여(salary)가 가장 높은 지역은? 

--평균급여 구하기전에 급여와 지역을 맞춰줘야한다 그 뒤에 평균급여를 구한다
select re.region_name,
       avg(salary) 
from employees em, departments de, locations lo, countries co, regions re
where em.department_id = de.department_id
and de.location_id = lo.location_id
and lo.country_id = co.country_id
and co.region_id = re.region_id
group by re.region_name;


-- 구해진 평균급여를 이용해 그 중 최고 급여를 구한다
select max(salary)
from (select re.region_name,
             avg(salary) salary 
      from employees em, departments de, locations lo, countries co, regions re
      where em.department_id = de.department_id
      and de.location_id = lo.location_id
      and lo.country_id = co.country_id
      and co.region_id = re.region_id
      group by re.region_name)ags;

--구해진 평균최고 급여와 그 전 테이블을 대입해서 평균급여가 가장높은 지역을 뽑아준다

select avgre.reg_name as region_name
from (select re.region_name as reg_name,
             avg(salary) as avgsal
      from employees em, departments de, locations lo, countries co, regions re
      where em.department_id = de.department_id
      and de.location_id = lo.location_id
      and lo.country_id = co.country_id
      and co.region_id = re.region_id
       group by re.region_name)avgre , (select max(salary) as maxsal
                                         from (select re.region_name,
                                                        avg(salary) salary 
                                               from employees em, departments de, locations lo, countries co, regions re
                                               where em.department_id = de.department_id
                                               and de.location_id = lo.location_id
                                               and lo.country_id = co.country_id
                                               and co.region_id = re.region_id
                                               group by re.region_name)ags
                                          )maxre
where avgre.avgsal = maxre.maxsal;


--문제10.
--평균 급여(salary)가 가장 높은 업무는? 

--job_id별로 평균 급여를 구해준다

select avg(salary),
       job_id 
from employees em
group by job_id;

--최고 값을 구해준다

select max(salary) 
from (select avg(salary) salary,
                        job_id 
      from employees em
      group by job_id);



--대입해준다
select jo.job_title
from jobs jo , (select avg(salary) avgsal,
                        job_id 
                from employees em
                group by job_id)avgjob, (select max(salary) maxsal 
                                             from (select avg(salary) salary,
                                                          job_id 
                                                   from employees em
                                                   group by job_id))maxjob
where  jo.job_id = avgjob.job_id
and avgjob.avgsal = maxjob.maxsal;