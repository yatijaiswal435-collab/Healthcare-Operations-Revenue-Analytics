-- Healthcare Operations & Revenue Analytics
-- Reproduces the core analyses in notebook/hospital_data_analysis.ipynb
-- Database: healthcare_analysis
-- Revenue path: billing -> treatment -> appointment -> doctor

USE healthcare_analysis;

-- 01. DATABASE OVERVIEW
SELECT 'patients' table_name, COUNT(*) row_count FROM patients
UNION ALL SELECT 'doctors', COUNT(*) FROM doctors
UNION ALL SELECT 'appointments', COUNT(*) FROM appointments
UNION ALL SELECT 'treatments', COUNT(*) FROM treatments
UNION ALL SELECT 'billing', COUNT(*) FROM billing;

-- 02. DATA QUALITY
SELECT 'patients' table_name, SUM(patient_id IS NULL) missing_key_values FROM patients
UNION ALL SELECT 'doctors', SUM(doctor_id IS NULL) FROM doctors
UNION ALL SELECT 'appointments', SUM(appointment_id IS NULL) FROM appointments
UNION ALL SELECT 'treatments', SUM(treatment_id IS NULL) FROM treatments
UNION ALL SELECT 'billing', SUM(bill_id IS NULL) FROM billing;

SELECT * FROM billing WHERE amount IS NULL OR amount <= 0;
SELECT * FROM treatments WHERE cost IS NULL OR cost <= 0;
SELECT status, COUNT(*) appointment_count FROM appointments GROUP BY status ORDER BY appointment_count DESC;

-- Referential integrity
SELECT COUNT(*) invalid_appointment_patient_links FROM appointments a LEFT JOIN patients p ON a.patient_id=p.patient_id WHERE p.patient_id IS NULL;
SELECT COUNT(*) invalid_appointment_doctor_links FROM appointments a LEFT JOIN doctors d ON a.doctor_id=d.doctor_id WHERE d.doctor_id IS NULL;
SELECT COUNT(*) invalid_treatment_appointment_links FROM treatments t LEFT JOIN appointments a ON t.appointment_id=a.appointment_id WHERE a.appointment_id IS NULL;
SELECT COUNT(*) invalid_billing_patient_links FROM billing b LEFT JOIN patients p ON b.patient_id=p.patient_id WHERE p.patient_id IS NULL;
SELECT COUNT(*) invalid_billing_treatment_links FROM billing b LEFT JOIN treatments t ON b.treatment_id=t.treatment_id WHERE t.treatment_id IS NULL;

-- 03. CORE KPIs
SELECT COUNT(DISTINCT patient_id) total_patients FROM patients;
SELECT COUNT(DISTINCT doctor_id) total_doctors FROM doctors;
SELECT COUNT(DISTINCT appointment_id) total_appointments FROM appointments;
SELECT COUNT(DISTINCT treatment_id) total_treatments FROM treatments;
SELECT ROUND(SUM(amount),2) total_billing_revenue FROM billing;
SELECT ROUND(AVG(amount),2) average_bill_amount FROM billing;
SELECT ROUND(MAX(amount),2) highest_bill FROM billing;
SELECT ROUND(MIN(amount),2) lowest_bill FROM billing;

-- 04. PATIENT ANALYSIS
SELECT gender, COUNT(*) patient_count FROM patients GROUP BY gender ORDER BY patient_count DESC;
SELECT insurance_provider, COUNT(*) patient_count FROM patients GROUP BY insurance_provider ORDER BY patient_count DESC;

-- 05. APPOINTMENT ANALYSIS
SELECT status, COUNT(*) appointment_count FROM appointments GROUP BY status ORDER BY appointment_count DESC;
SELECT DATE_FORMAT(appointment_date,'%Y-%m') month, COUNT(*) appointment_count FROM appointments GROUP BY DATE_FORMAT(appointment_date,'%Y-%m') ORDER BY month;
SELECT d.specialization, COUNT(a.appointment_id) appointment_count FROM appointments a JOIN doctors d ON a.doctor_id=d.doctor_id GROUP BY d.specialization ORDER BY appointment_count DESC;
SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) doctor_name, d.specialization, COUNT(a.appointment_id) appointment_count FROM appointments a JOIN doctors d ON a.doctor_id=d.doctor_id GROUP BY d.doctor_id,d.first_name,d.last_name,d.specialization ORDER BY appointment_count DESC;

-- 06. APPOINTMENT PERFORMANCE
SELECT COUNT(*) total_appointments, SUM(status='No-show') no_show_appointments, ROUND(100*SUM(status='No-show')/COUNT(*),2) no_show_rate FROM appointments;
SELECT COUNT(*) total_appointments, SUM(status='Completed') completed_appointments, ROUND(100*SUM(status='Completed')/COUNT(*),2) completed_rate FROM appointments;
SELECT COUNT(*) total_appointments, SUM(status='Cancelled') cancelled_appointments, ROUND(100*SUM(status='Cancelled')/COUNT(*),2) cancellation_rate FROM appointments;
SELECT d.specialization, COUNT(*) total_appointments, SUM(a.status='No-show') no_show_appointments, ROUND(100*SUM(a.status='No-show')/COUNT(*),2) no_show_rate FROM appointments a JOIN doctors d ON a.doctor_id=d.doctor_id GROUP BY d.specialization ORDER BY no_show_rate DESC;
SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) doctor_name, d.specialization, COUNT(*) total_appointments, SUM(a.status='No-show') no_show_appointments, ROUND(100*SUM(a.status='No-show')/COUNT(*),2) no_show_rate FROM appointments a JOIN doctors d ON a.doctor_id=d.doctor_id GROUP BY d.doctor_id,d.first_name,d.last_name,d.specialization ORDER BY no_show_rate DESC;

-- 07. TREATMENT ANALYSIS
SELECT treatment_type, COUNT(*) treatment_count FROM treatments GROUP BY treatment_type ORDER BY treatment_count DESC;
SELECT treatment_type, ROUND(AVG(cost),2) average_treatment_cost FROM treatments GROUP BY treatment_type ORDER BY average_treatment_cost DESC;
SELECT treatment_type, ROUND(SUM(cost),2) total_treatment_cost FROM treatments GROUP BY treatment_type ORDER BY total_treatment_cost DESC;
SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) doctor_name, d.specialization, COUNT(t.treatment_id) treatment_count, ROUND(SUM(t.cost),2) total_treatment_cost FROM treatments t JOIN doctors d ON t.doctor_id=d.doctor_id GROUP BY d.doctor_id,d.first_name,d.last_name,d.specialization ORDER BY total_treatment_cost DESC;

-- 08. REVENUE BY PATIENT
SELECT p.patient_id, CONCAT(p.first_name,' ',p.last_name) patient_name, ROUND(SUM(b.amount),2) total_billed FROM billing b JOIN patients p ON b.patient_id=p.patient_id GROUP BY p.patient_id,p.first_name,p.last_name ORDER BY total_billed DESC;
SELECT p.patient_id, CONCAT(p.first_name,' ',p.last_name) patient_name, ROUND(AVG(b.amount),2) average_bill_amount FROM billing b JOIN patients p ON b.patient_id=p.patient_id GROUP BY p.patient_id,p.first_name,p.last_name ORDER BY average_bill_amount DESC;

-- 09. REVENUE BY SPECIALIZATION - CORRECT RELATIONSHIP
WITH billing_context AS (
 SELECT b.bill_id,b.amount,t.appointment_id,a.doctor_id,d.specialization
 FROM billing b JOIN treatments t ON b.treatment_id=t.treatment_id JOIN appointments a ON t.appointment_id=a.appointment_id JOIN doctors d ON a.doctor_id=d.doctor_id
)
SELECT specialization, ROUND(SUM(amount),2) total_revenue FROM billing_context GROUP BY specialization ORDER BY total_revenue DESC;

-- 10. REVENUE BY DOCTOR
WITH billing_context AS (
 SELECT b.amount,a.doctor_id FROM billing b JOIN treatments t ON b.treatment_id=t.treatment_id JOIN appointments a ON t.appointment_id=a.appointment_id
)
SELECT d.doctor_id, CONCAT(d.first_name,' ',d.last_name) doctor_name, d.specialization, ROUND(SUM(bc.amount),2) total_revenue
FROM billing_context bc JOIN doctors d ON bc.doctor_id=d.doctor_id
GROUP BY d.doctor_id,d.first_name,d.last_name,d.specialization ORDER BY total_revenue DESC;

-- 11. MONTHLY REVENUE
SELECT DATE_FORMAT(bill_date,'%Y-%m') month, ROUND(SUM(amount),2) total_revenue FROM billing GROUP BY DATE_FORMAT(bill_date,'%Y-%m') ORDER BY month;

-- 12. REVENUE PER APPOINTMENT BY SPECIALIZATION
WITH appointment_summary AS (
 SELECT d.specialization,COUNT(DISTINCT a.appointment_id) appointment_count FROM appointments a JOIN doctors d ON a.doctor_id=d.doctor_id GROUP BY d.specialization
), revenue_summary AS (
 SELECT d.specialization,SUM(b.amount) total_revenue FROM billing b JOIN treatments t ON b.treatment_id=t.treatment_id JOIN appointments a ON t.appointment_id=a.appointment_id JOIN doctors d ON a.doctor_id=d.doctor_id GROUP BY d.specialization
)
SELECT a.specialization,a.appointment_count,ROUND(r.total_revenue,2) total_revenue,ROUND(r.total_revenue/NULLIF(a.appointment_count,0),2) revenue_per_appointment
FROM appointment_summary a LEFT JOIN revenue_summary r ON a.specialization=r.specialization ORDER BY revenue_per_appointment DESC;

-- 13. DOCTOR WORKLOAD VS REVENUE
WITH doctor_appointments AS (
 SELECT doctor_id,COUNT(DISTINCT appointment_id) appointment_count FROM appointments GROUP BY doctor_id
), doctor_revenue AS (
 SELECT a.doctor_id,SUM(b.amount) total_revenue FROM billing b JOIN treatments t ON b.treatment_id=t.treatment_id JOIN appointments a ON t.appointment_id=a.appointment_id GROUP BY a.doctor_id
)
SELECT d.doctor_id,CONCAT(d.first_name,' ',d.last_name) doctor_name,d.specialization,COALESCE(da.appointment_count,0) appointment_count,ROUND(COALESCE(dr.total_revenue,0),2) total_revenue,ROUND(COALESCE(dr.total_revenue,0)/NULLIF(da.appointment_count,0),2) revenue_per_appointment
FROM doctors d LEFT JOIN doctor_appointments da ON d.doctor_id=da.doctor_id LEFT JOIN doctor_revenue dr ON d.doctor_id=dr.doctor_id ORDER BY appointment_count DESC;

-- 14. DOCTOR REVENUE RANKING
WITH doctor_revenue AS (
 SELECT a.doctor_id,SUM(b.amount) total_revenue FROM billing b JOIN treatments t ON b.treatment_id=t.treatment_id JOIN appointments a ON t.appointment_id=a.appointment_id GROUP BY a.doctor_id
)
SELECT d.doctor_id,CONCAT(d.first_name,' ',d.last_name) doctor_name,d.specialization,ROUND(dr.total_revenue,2) total_revenue,RANK() OVER(ORDER BY dr.total_revenue DESC) revenue_rank
FROM doctor_revenue dr JOIN doctors d ON dr.doctor_id=d.doctor_id ORDER BY revenue_rank;

-- 15. MONTH-OVER-MONTH REVENUE
WITH monthly_revenue AS (
 SELECT DATE_FORMAT(bill_date,'%Y-%m') month,SUM(amount) revenue FROM billing GROUP BY DATE_FORMAT(bill_date,'%Y-%m')
), comparison AS (
 SELECT month,revenue,LAG(revenue) OVER(ORDER BY month) previous_month_revenue FROM monthly_revenue
)
SELECT month,ROUND(revenue,2) revenue,ROUND(previous_month_revenue,2) previous_month_revenue,ROUND(100*(revenue-previous_month_revenue)/NULLIF(previous_month_revenue,0),2) mom_change_percent
FROM comparison ORDER BY month;

-- END OF ANALYSIS
