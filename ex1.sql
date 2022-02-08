
SELECT AVG(year(CURRENT_DATE) - year(birthday) -
    CASE WHEN month(CURRENT_DATE) < month(birthday) THEN 1
         WHEN month(CURRENT_DATE) = month(birthday) AND day(CURRENT_DATE) < day(birthday) THEN 1
         ELSE 0
    END)
FROM raw.employee
WHERE company_id = "comp_294"
    AND birthday > to_date("1900-01-01")
    AND birthday < CURRENT_DATE;
