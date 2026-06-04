use HealthcareDB
go

select * from healthcare_data;

select count(*) from healthcare_data;

--- deleting null values
select count(*) from healthcare_data
where Billing_Amount is null;

delete from healthcare_data
where Billing_Amount is null;


--checking duplicate values
WITH duplicate_cte AS
(
SELECT *,

ROW_NUMBER() OVER
(
PARTITION BY

Name,
Age,
Gender,
[Blood_Type],
[Medical_Condition],
[Date_of_Admission],
Doctor,
Hospital,
[Insurance_Provider],
[Billing_Amount],
[Room_Number],
[Admission_Type],
[Discharge_Date],
Medication,
[Test_Results]

ORDER BY Name

) AS rn

FROM healthcare_data
)

SELECT *
FROM duplicate_cte
WHERE rn > 1;

SELECT
Name,
Age,
Gender,
[Blood_Type],
[Medical_Condition],
[Date_of_Admission],
Doctor,
Hospital,
[Insurance_Provider],
[Billing_Amount],
[Room_Number],
[Admission_Type],
[Discharge_Date],
Medication,
[Test_Results],

COUNT(*) AS duplicate_count

FROM healthcare_data

GROUP BY
Name,
Age,
Gender,
[Blood_Type],
[Medical_Condition],
[Date_of_Admission],
Doctor,
Hospital,
[Insurance_Provider],
[Billing_Amount],
[Room_Number],
[Admission_Type],
[Discharge_Date],
Medication,
[Test_Results]

HAVING COUNT(*) > 1;
 ---CHECKED DUPLICATE VALUES

 ---LEN OF STAY
 ALTER TABLE healthcare_data
ADD Length_of_Stay INT;

UPDATE healthcare_data
SET Length_of_Stay =
DATEDIFF(
DAY,
Date_of_Admission,
Discharge_Date
);

--check 
select * from healthcare_data;

--Insights
--1.TOTAL PATIENTS
select COUNT(Name) as total_patients from healthcare_data;

--2. TOTAL REVENUE
select SUM(Billing_Amount) as total_revenue from healthcare_data;

--3. AVERAGE BILLING
select avg(Billing_Amount) as average_billing from healthcare_data;

--3. AVERAGE BILLING hospital wise
select Hospital,avg(Billing_Amount) as average_billing from healthcare_data
group by Hospital order by average_billing desc;

--4. TOP  expensive MEDICAL CONDITIONS
select Medical_condition, sum(Billing_Amount) as topmedical from healthcare_data
group by Medical_Condition order by topmedical desc;

--5.top medical conditions
select Medical_condition, count(*) as totalcount from healthcare_data
group by Medical_Condition order by totalcount desc;

--6.gender distributiopn 
select Gender,count(*) as genderwise from healthcare_data
group by Gender ;

--7.age group distribution
select 
case 
when Age < 18 then 'child'
when Age  between 18 and 35 then 'young'
when Age between 36 and 60 then 'adult'
else 'senior'end as age_group, count(*) as total_p from healthcare_data
group by case 
when Age < 18 then 'child'
when Age  between 18 and 35 then 'young'
when Age between 36 and 60 then 'adult'
else 'senior'end ;

--8. TOP REVENUE HOSPITALS
select Top 10 Hospital,sum(Billing_Amount) as Total_revenue from healthcare_data
group by Hospital order by Total_revenue desc;

--9 doctor performance ranking
select Doctor,sum(Billing_Amount) as total_bill,dense_rank()over( order by sum(Billing_Amount) desc) as ranking from healthcare_data
group by Doctor;

--10 . AVERAGE STAY BY DISEASE
select Medical_Condition,avg(Length_of_Stay) as avgstay from healthcare_data
group by Medical_Condition;

--11.INSURANCE REVENUE ANALYSIS
select Insurance_Provider,sum(Billing_Amount) as total_revenue from healthcare_data
group by Insurance_Provider
order by total_revenue desc;

--12.emergency adns
select count(*) as Emergency_admsns from healthcare_data
where Admission_Type='Emergency';

--14.RUNNING REVENUE
select Date_of_Admission,SUM(Billing_Amount) as totalrevenue,sum(SUM(Billing_Amount))over(order by Date_of_Admission ) as running_revenue from healthcare_data
group by Date_of_Admission;

--15.Long time satay persons
Select * from healthcare_data
where Length_of_Stay=(select MAX(Length_of_Stay) as maxsatay from healthcare_data);

--16.High Billing patienets to 10
with Highbillingpatient as 
(select top 10 Name ,max(Billing_Amount) as maxbill  from healthcare_data
group by Name )
select * from Highbillingpatient
order by maxbill desc;