
CREATE OR REPLACE VIEW salaries AS
SELECT
    id,
    name,
    company_id,
    cast(trim(substr(salary, 0, length(salary) - 3)) as int) as paycheck,
    trunc(from_unixtime(unix_timestamp(dt , 'yyyyMM')), 'MONTH') as dt,
    substr(salary, -3) as currency
FROM raw.employee
WHERE dt >= 10000 AND dt <= 999999;

CREATE OR REPLACE VIEW salary_exchange_rates AS
    SELECT 
        trunc(dt, 'MONTH') as dt,
        from_currency,
        to_currency,
        rate
    FROM raw.exchange_rate;

CREATE OR REPLACE VIEW pln_salary_exchange_rate AS
    SELECT
        dt,
        from_currency as currency,
        MAX(rate) as rate
    FROM salary_exchange_rates
    WHERE to_currency = "PLN"
    GROUP BY dt, from_currency;

CREATE OR REPLACE VIEW salaries_pln AS
    SELECT
        salaries.paycheck,
        salaries.currency,
        pln_salary_exchange_rate.rate,
        salaries.paycheck * 
            CASE WHEN salaries.currency = "PLN" THEN 1
                ELSE rate
            END 
        AS paycheck_pln
    FROM salaries
    LEFT JOIN pln_salary_exchange_rate
        ON salaries.currency = pln_salary_exchange_rate.currency
        AND salaries.dt = pln_salary_exchange_rate.dt
    WHERE salaries.paycheck IS NOT NULL;

SELECT MAX(paycheck_pln) FROM salaries_pln;

-- SELECT MAX(paycheck_pln) 
-- FROM salaries_pln;
