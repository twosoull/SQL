/*단일행 함수*/

--initcap (컬럼명) 앞글자만 대문자로
select email,
       initcap(email),
       department_id
from employees
where department_id = 100;

--문자함수 - LOWER(컬럼명)소문자로 변경 /  UPPER(컬럼명)
SELECT first_name,
       lower(first_name),
       UPPER(first_name) "Name"
from employees
where department_id = 100;

--문자함수 - SUBSTR (컬럼명, 시작위치, 글자수) 컬럼명을 시작위치부터 글자수 만큼만 보여준다
select  first_name,
        substr(first_name,3),--> 3번째부터 끝까지
        substr(first_name,2,6),
        substr(first_name,-3,3) -- >뒤에서 부터 -3 의 3개
from employees
where department_id = 100;

--문자함수 - LPAD(컬럼명, 자리수, '채울문자') / RPAD(컬럼명, 자리수, '채울문자)
select first_name,
       lpad(first_name,10,'*'),-- 글자수가 총 10개가 되도록 왼쪽 부터*을 채워라
       rpad(first_name,10,'*') -- 글자수가 총 10개가 되도록 오른쪽 부터*을 채워라
from employees;

--문자함수 - REPLACE(컬럼명, 문자1, 문자2)
select  first_name,
        replace(first_name,'a','****') -->'a'를 별표로 바꿔라
from employees
where department_id = 100;

--함수 조합
select first_name,
       replace(first_name,'a','*'),
       substr(first_name,'2','3'),
        replace(first_name,substr(first_name,'2','3'),'***')
from employees
where department_id = 100;

-----숫자함수 -ROUND(숫자, 출력을 원하는 자리수)
select round(123.456,1) r2,  --123.456은 반올림해서 소수점 1 자리까지 표기해라
       round(124.656,0) r1,
       round(124.556, -1) "r-1"
from dual;---> 아무것도 없는 데이터 함수를 테스트하기 위한 가상의 테이블

select salary,
       round(salary,-3) --   -3의경우는 .을 0번째 기준으로 -3번째 자리 수를 반올림  
from employees;


--숫자함수 TRUNC(숫자, 출력을 원하는 자리수) --올림은 ceil
select trunc(123.456,2) as r2, --소수점 3번쨰 자리에서 버림후 2번째자리까지 출력
       trunc(123.456,0) as r0,  -- .이 0이니 그 기준으로 그 아래의 같은 모두버림 
       trunc(123.456,-1) as"r-1"-- -1자리에서 반올림 한 수 출력
from dual;

--날짜함수 SYSDATE
select sysdate -->()가 없다  현재 날짜를 알려준다
from dual;

select sysdate,
       first_name
from employees;

--단일 함수>날짜함수 - Month_between (d1,d2)

select  sysdate,
        hire_date,
        months_between(sysdate, hire_date)as "workMonth",
        trunc(months_between(sysdate, hire_date),0) as "근무개월" -- > months_between은 소수점도 표기하기에 버림으로 소수점을 없애줬다
from employees
where department_id = 100;

--날짜 함수  - last_day(d1) 그 달의 마지막날을 알려준다
select last_day('19/02/06'),   
        last_day(sysdate)
from dual;

--to_char(숫자 ,'출력모양) 숫자형 -->문자형 표기

select salary,
        salary*12,
            to_char(salary*12,'$999,999,999.00'),
            to_char(salary*12,'$999,999.00'),
            to_char(salary*12,'999,999')
from employees;

--변환 함수 > to_char(날짜 ,'출력모양') 날짜 ->문자형으로 변환하기
select sysdate,
       to_char(sysdate, 'YYy') YYYY,
       to_char(sysdate,'yy') YY,
       to_char(sysdate, 'mm') mm,
       to_char(sysdate,'Month') MONTH, --한글로 12월이라 표시된다(한글윈도우이기 때문에 나라설정에 맞춰간다)
       to_char(sysdate,'DD') DD,
       to_char(sysdate, 'day') day,
       to_char(sysdate, 'HH') HH,
       TO_CHAR(sysdate, 'HH24') HH,
       to_char(sysdate, 'mi') mi,
       to_char(sysdate, 'ss') ss
from dual;

--년월일 시분초

select sysdate,
       to_char(sysdate, 'yyyy-MM-DD HH24:MI:SS')    
from dual;

select first_name,
       hire_date,
       to_char(hire_Date, 'yyyy-mm-dd hh24:mi:ss')
from employees;       

--일반함수 > NVL(컬럼명, null일때 값)/NVL2(컬럼명, null 아닐때 값, null일때 값)
select first_name,
       commission_pct,
       NVL(commission_pct, 0) ----> commission_pct가 null이면 0으로 바꿔라
from employees;

--NVL2 (컬렴명, null 아닐 때 값, null 일때 값)
select first_name,
        commission_pct,
        NVL2(commission_pct, 100, 0) --컬럼이 null이 아니면 100 null이면 0
from employees;