SELECT *
FROM `case_study`.`healthcare-dataset-stroke-data`;

CREATE TABLE stroke_staging_1
like `healthcare-dataset-stroke-data`;

INSERT stroke_staging_1
SELECT *
FROM `healthcare-dataset-stroke-data`;

SELECT *
FROM `stroke_staging_1`;


CREATE TABLE `stroke_staging_2` (
  `id` int DEFAULT NULL,
  `gender` text,
  `age` int DEFAULT NULL,
  `hypertension` int DEFAULT NULL,
  `heart_disease` int DEFAULT NULL,
  `ever_married` text,
  `work_type` text,
  `Residence_type` text,
  `avg_glucose_level` double DEFAULT NULL,
  `bmi` text,
  `smoking_status` text,
  `stroke` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO stroke_staging_2
SELECT * ,
ROW_NUMBER() OVER (
PARTITION BY id,gender,age,hypertension,heart_disease,ever_married,work_type,Residence_type,avg_glucose_level,bmi,smoking_status,stroke) AS row_num
from stroke_staging_1;


DELETE
FROM stroke_staging_2
WHERE row_num>1;


update stroke_staging_2
set gender = trim(gender);


select distinct gender
from stroke_staging_2;

update stroke_staging_2
set age = trim(age);


update stroke_staging_2
set hypertension = trim(hypertension);

update stroke_staging_2
set heart_disease = trim(heart_disease);


update stroke_staging_2
set ever_married = trim(ever_married);

select distinct ever_married
from stroke_staging_2;

update stroke_staging_2
set work_type = trim(work_type);

select distinct work_type
from stroke_staging_2;

update stroke_staging_2
set Residence_type = trim(Residence_type);

select distinct Residence_type
from stroke_staging_2;

update stroke_staging_2
set Residence_type = trim(Residence_type);

update stroke_staging_2
set bmi = trim(bmi);

select distinct bmi
from stroke_staging_2;

update stroke_staging_2
set smoking_status = trim(smoking_status);

select distinct smoking_status
from stroke_staging_2;
update stroke_staging_2
SET smoking_status='smokes'
where smoking_status LIKE 'smokes%';

update stroke_staging_2
set stroke = trim(stroke);

update stroke_staging_2
set row_num = trim(row_num);

select *
from stroke_staging_2;

select id
from stroke_staging_2
where id ='' or id= NULL or id ='N/A';

select gender
from stroke_staging_2
where gender ='' or id= NULL or gender ='N/A';

select age
from stroke_staging_2
where age ='' or id= NULL or age ='N/A';

select hypertension
from stroke_staging_2
where hypertension ='' or hypertension= NULL or hypertension ='N/A';

select heart_disease
from stroke_staging_2
where heart_disease ='' or heart_disease= NULL or heart_disease ='N/A';

select ever_married
from stroke_staging_2
where ever_married ='' or ever_married= NULL or ever_married='N/A';

select work_type
from stroke_staging_2
where work_type ='' or work_type= NULL or work_type='N/A';

select Residence_type
from stroke_staging_2
where Residence_type ='' or Residence_type= NULL or Residence_type='N/A';

select avg_glucose_level
from stroke_staging_2
where avg_glucose_level ='' or avg_glucose_level= NULL or avg_glucose_level='N/A';


select bmi
from stroke_staging_2
where bmi ='' or bmi= NULL or bmi='N/A';

UPDATE stroke_staging_2
SET bmi = null
WHERE bmi = 'N/A';

UPDATE stroke_staging_2
SET bmi = (
    SELECT avg_bmi
    FROM (
        SELECT AVG(bmi) AS avg_bmi
        FROM stroke_staging_2
        WHERE bmi IS NOT NULL
    ) AS derived_table
)
WHERE bmi IS NULL;





select bmi
from stroke_staging_2
where bmi =NULL;

select smoking_status
from stroke_staging_2
where smoking_status ='' or smoking_status= NULL or smoking_status='N/A';



select stroke
from stroke_staging_2
where stroke ='' or stroke= NULL or stroke='N/A';


alter table stroke_staging_2
drop column row_num;

update stroke_staging_2
set bmi=round(bmi,2);

select *
from stroke_staging_2









