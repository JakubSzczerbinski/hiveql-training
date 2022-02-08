
WITH dtp AS
    (
        SELECT
            *,
            CASE WHEN dt >= 100000 THEN
                cast (dt as INT) DIV 100 * 12 + dt % 100
            ELSE
                cast (dt as INT) DIV 10 * 12 + dt % 10
            END as dtp
        FROM raw.employee
        WHERE dt >= 10000 AND dt <= 999999
    ),
    pay_groups AS
    (
        SELECT
            *,
            dtp - COUNT(*) OVER (PARTITION BY id, company_id ORDER BY dtp) AS pay_groups
        FROM
            dtp
    ),
    employment_length AS
    (
        SELECT id, company_id, COUNT(*) as employment_length
        FROM pay_groups GROUP BY pay_groups, company_id, id
    )
    -- SELECT * FROM dtp ORDER BY DTP DESC LIMIT 20;
    SELECT company_id, AVG(employment_length) as avg_employment_length
    FROM employment_length
    GROUP BY company_id
    ORDER BY avg_employment_length DESC
    LIMIT 20;
