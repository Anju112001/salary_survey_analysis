use milestone_2;

SELECT * FROM SALARY_CLEANED;

-- Average Salary by Industry and Gender
SELECT 
    Industry, 
    Gender, 
    AVG(Total_Salary_with_Compensation) AS avg_salary
FROM salary_CLEANED
GROUP BY Industry, Gender
ORDER BY Industry, Gender;
-- -----------------------------------------------------------------------------------------------------------------------


-- Total Salary Compensation by Job Title
SELECT 
    Job_Title, 
    SUM(Total_Salary_with_Compensation) AS total_salary_compensation
FROM salary_CLEANED
GROUP BY Job_Title
ORDER BY total_salary_compensation DESC;

-- ---------------------------------------------------------------------------------------------------------------------

-- Salary Distribution by Education Level
SELECT 
    Highest_Level_of_Education_Completed AS Education_Level, 
    AVG(Total_Salary_with_Compensation) AS avg_salary,
    MIN(Total_Salary_with_Compensation) AS min_salary,
    MAX(Total_Salary_with_Compensation) AS max_salary
FROM salary_CLEANED
GROUP BY Highest_Level_of_Education_Completed
ORDER BY avg_salary DESC;

-- ------------------------------------------------------------------------------------------------------------------------

-- Number of Employees by Industry and Years of Experience
SELECT 
    Industry, 
    Years_of_Professional_Experience_Overall AS Experience_Level, 
    COUNT(*) AS num_employees
FROM salary_cleaned
GROUP BY Industry, Years_of_Professional_Experience_Overall
ORDER BY Industry, num_employees DESC;

-- ------------------------------------------------------------------------------------------------------------------

-- Median Salary by Age Range and Gender
SELECT Age_Range, Gender, 
       Salary AS median_salary
FROM (
    SELECT Age_Range, Gender, Total_Salary_with_Compensation AS Salary,
           ROW_NUMBER() OVER (PARTITION BY Age_Range, Gender ORDER BY Total_Salary_with_Compensation) AS row_num,
           COUNT(*) OVER (PARTITION BY Age_Range, Gender) AS total_rows
    FROM salary_cleaned
) ranked
WHERE row_num = CEIL(total_rows / 2);
-- ------------------------------------------------------------------------------------------------------------------------

-- Job Titles with the Highest Salary in Each Country

SELECT Country, Job_Title, Max_Salary
FROM (
    SELECT Country, Job_Title, Total_Salary_with_Compensation AS Max_Salary,
           RANK() OVER (PARTITION BY Country ORDER BY Total_Salary_with_Compensation DESC) AS salary_rank
    FROM salary_cleaned
) ranked
WHERE salary_rank = 1;
-- ---------------------------------------------------------------------------------------------------------------------
-- Average Salary by City and Industry
SELECT 
    City, 
    Industry, 
    AVG(Total_Salary_with_Compensation) AS avg_salary
FROM salary_cleaned
GROUP BY City, Industry
ORDER BY City, avg_salary DESC;


-- ------------------------------------------------------------------------------------------------------------------------------
-- Percentage of Employees with Additional Monetary Compensation by Gender
SELECT 
    Gender, 
    COUNT(CASE WHEN Additional_Monetary_Compensation > 0 THEN 1 END) * 100.0 / COUNT(*) AS percentage_with_compensation
FROM salary_cleaned
GROUP BY Gender
ORDER BY percentage_with_compensation DESC;

-- --------------------------------------------------------------------------------------------------------------------------------

-- Total Compensation by Job Title and Years of Experience
SELECT 
    Job_Title, 
    Years_of_Professional_Experience_Overall AS Experience_Level, 
    SUM(Total_Salary_with_Compensation) AS total_compensation
FROM salary_cleaned
GROUP BY Job_Title, Years_of_Professional_Experience_Overall
ORDER BY total_compensation DESC;


-- --------------------------------------------------------------------------------------------------------------------------------
-- Average Salary by Industry, Gender, and Education Level
SELECT 
    Industry, 
    Gender, 
    Highest_Level_of_Education_Completed AS Education_Level, 
    AVG(Total_Salary_with_Compensation) AS avg_salary
FROM salary_cleaned
GROUP BY Industry, Gender, Highest_Level_of_Education_Completed
ORDER BY Industry, Gender, avg_salary DESC;
