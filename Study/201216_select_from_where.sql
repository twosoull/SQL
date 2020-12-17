select * 
from employees; -- employees의 모든 데이터를 불러옴

select employee_id, 
        first_name,
        last_name
from employees; -->employees의 아이디 이름 성 순서대로 불러옴

--사원의 이름(fisrt_name)과 전화번호 입사일 연봉을 출력하세요

select first_name
from employees;

--사원의 이름(first_name)과 성(last_name) 급여, 전화번호, 이메일, 입사일을 출력하세요
select first_name,
       last_name,
       salary,
       phone_number,
       email,
       hire_date
from employees;

select employee_id as empNo, 
       first_name "E-name", 
       salary  "연봉"
from employees; -->엠플로이 아이디를 empNo로(""안에 넣어야 대소문자 구분됌)  first_name 은 E-name,salary는 연봉으로 별명을 붙였다

--사원의 이름(fisrt_name)과 전화번호 입사일 급여 로 표시되도록 출력하세요
select first_name as 이름,
       phone_number as 전화번호,
       hire_date as 입사일,
       salary as 급여
from employees;

--사원의 사원번호 이름(first_name) 성(last_name) 급여 전화번호 이메일 입사일로 표시되도록 출력하세요

select first_name 이름,
       last_name 성,
       salary 급여,
       phone_number 전화번호,
       email 이메일 
from employees;

select first_name, last_name
from employees; --> 엠플로이의 이름과 성을 차례로 불러온다

select first_name || last_name
from employees; -->  엠플로이의 이름과성을 합쳐서 불러온다

select first_name || ' ' || last_name
from employees; -->엠플로이의 이름과 성을 합치는데 중간에 여백 하나와 함께 불러온다 (제목으로는 first_name || ' ' || last_name들어감)

select first_name || ' hire date is ' || hire_date
from employees; --> 엠플로이의 이름과 압서일이 합쳐지며 중간에 hire date is 가 들어간다

select job_id*12
from employees; -->job_id는 곱할 수가 없다.

/*
전체직원의 정보를 다음과 같이 출력하세요
성명(first_name last_name)
      성과 이름사이에 ? 로 구분 ex) 
William-Gietz
급여
연봉(급여*12)
연봉2(급여*12+5000)
전화번호
*/

select first_name || '-'|| last_name "성명",
       salary 급여,
       salary*12 연봉,
       salary*12+5000 연봉2,
       phone_number
from employees;

select first_name
from employees
where department_id = 10; -->엠플로이스에서 아이디가 10인 이름을 불러온다

select first_name, salary
from employees
where salary >= 14000 
and salary <= 17000; -->엠플로이에서 급여가 14000이상이면서 17000이하인 사원의 이름과 급여를 불러온다


--연봉이 14000 이하이거나 17000 이상인 사원의 이름과 연봉을 출력하세요
select first_name,
       salary 
from employees
where salary<=14000
or salary>=17000;

--입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name,
       hire_date 
from employees
where hire_date between '04/01/01' and '05/12/31';

select first_name, salary
from employees
where salary >= 14000 
and salary <= 17000;-->엠플로이스 에서 급여가 14000이상이고 17000이하인 사원의 이름과 급여를 불러와라

select first_name, last_name, salary
from employees
where first_name in ('Neena', 'Lex', 'John'); -->엠플로이스에서 이름이 Neena 또는Lex 또는 John 인 사원의 이름 성 급여를 불러와라


--연봉이 2100, 3100, 4100, 5100 인 사원의 이름과 연봉을 구하시오

select first_name,
       salary 
from employees
where salary in (2100, 3100, 4100, 5100);

select first_name, last_name, salary
from employees
where first_name like 'L%';-->이름의 첫 글자가L인 사원의 이름과 성 급여를 불러와라

--이름에 am 을 포함한 사원의 이름과 연봉을 출력하세요

select first_name,
       salary 
from employees
where first_name like '%am%';

--이름의 두번째 글자가 a 인 사원의 이름과 연봉을 출력하세요

select first_name,
       salary 
from employees
where first_name like '_a%';

--이름의 네번째 글자가 a 인 사원의 이름을 출력하세요

select first_name
from employees
where first_name like '___a%';

--이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요

select first_name
from employees
where first_name like '%a_';

select first_name, salary, commission_pct, salary*commission_pct
from employees
where salary between 13000 and 15000 -- 엠플로이에서 급여가 13000이상 15000이하인 사원의 이름 급여 커피션퍼센트, 급여*커미션퍼센트를 출력

select first_name, salary, commission_pct
from employees
where commission_pct is null; -- 엠플러이에서 커피션퍼센트가 null인 사원의 이름 급여 커피션퍼센트

--커미션비율이 있는 사원의 이름과 연봉 커미션비율을 출력하세요
select first_name,
       salary,
       commission_pct
from employees
where commission_pct is not null;

--담당매니저가 없고 커미션비율이 없는 직원의 이름을 출력하세요

SELECT first_name
from employees
where manager_id is null
and commission_pct is null;
                 
select first_name, salary
from employees
order by salary desc; --> 엠플로이에서 급여를 내림차순으로 직원의 이름과급여를 출력해라

select first_name, salary
from employees
where salary >= 9000
order by salary desc; --> 엠플로이에서 급여가 9000이상인 직원의 급여를 내림차순으로 만들고 직원의 이름과 급여를 출력해라

--부서번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하세요

select department_id,
       salary, 
       first_name
from employees
order by department_id asc;

--급여가 10000 이상인 직원의 이름 급여를 급여가 큰직원부터 출력하세요
select first_name,
       salary 
from employees
where 10000<=salary
order by salary desc;

--부서번호를 오름차순으로 정렬하고 부서번호가 같으면 급여가 높은 사람부터 부서번호 급여 이름을 출력하세요  
select department_id,
       salary, 
       first_name
from employees
order by department_id asc, salary desc;

