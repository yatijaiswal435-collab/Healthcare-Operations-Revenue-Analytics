-- ============================================================
-- Healthcare Operations & Revenue Analytics
-- SQL Analysis
-- Database: healthcare_analysis
-- ============================================================

USE healthcare_analysis;


-- ============================================================
-- 01. DATABASE OVERVIEW
-- ============================================================

-- Check total records in each table

SELECT 'Patients' AS table_name, COUNT(*) AS total_records
FROM patients

UNION ALL

SELECT 'Doctors', COUNT(*)
FROM doctors

UNION ALL

SELECT 'Appointments', COUNT(*)
FROM appointments

UNION ALL

SELECT 'Treatments', COUNT(*)
FROM treatments

UNION ALL

SELECT 'Billing', COUNT(*)
FROM billing;


-- ============================================================
-- 02. DATA QUALITY CHECKS
-- ============================================================

-- Check missing patient IDs and names

SELECT
    SUM(patient_id IS NULL) AS missing_patient_ids,
    SUM(name IS NULL) AS missing_patient_names
FROM patients;


-- Check missing doctor IDs and names

SELECT
    SUM(doctor_id IS NULL) AS missing_doctor_ids,
    SUM(name IS NULL) AS missing_doctor_names
FROM doctors;


-- Check duplicate patients

SELECT
    patient_id,
    COUNT(*) AS duplicate_count
FROM patients
GROUP BY patient_id
HAVING COUNT(*) > 1;


-- Check duplicate doctors

SELECT
    doctor_id,
    COUNT(*) AS duplicate_count
FROM doctors
GROUP BY doctor_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 03. CORE HOSPITAL KPIs
-- ============================================================

-- Total Patients

SELECT
    COUNT(*) AS total_patients
FROM patients;


-- Total Doctors

SELECT
    COUNT(*) AS total_doctors
FROM doctors;


-- Total Appointments

SELECT
    COUNT(*) AS total_appointments
FROM appointments;


-- Total Treatments

SELECT
    COUNT(*) AS total_treatments
FROM treatments;


-- Total Billing Revenue

SELECT
    ROUND(SUM(amount), 2) AS total_billing_revenue
FROM billing;


-- Average Billing Amount

SELECT
    ROUND(AVG(amount), 2) AS average_bill_amount
FROM billing;


-- Maximum Billing Amount

SELECT
    ROUND(MAX(amount), 2) AS highest_bill
FROM billing;


-- Minimum Billing Amount

SELECT
    ROUND(MIN(amount), 2) AS lowest_bill
FROM billing;


-- ============================================================
-- 04. PATIENT ANALYSIS
-- ============================================================

-- Patient distribution by gender

SELECT
    gender,
    COUNT(*) AS patient_count
FROM patients
GROUP BY gender
ORDER BY patient_count DESC;


-- Patient distribution by insurance provider

SELECT
    insurance_provider,
    COUNT(*) AS patient_count
FROM patients
GROUP BY insurance_provider
ORDER BY patient_count DESC;


-- Patient distribution by location / branch

SELECT
    address,
    COUNT(*) AS patient_count
FROM patients
GROUP BY address
ORDER BY patient_count DESC;


-- ============================================================
-- 05. DOCTOR ANALYSIS
-- ============================================================

-- Number of doctors by specialization

SELECT
    specialization,
    COUNT(*) AS doctor_count
FROM doctors
GROUP BY specialization
ORDER BY doctor_count DESC;


-- Number of doctors by branch

SELECT
    branch,
    COUNT(*) AS doctor_count
FROM doctors
GROUP BY branch
ORDER BY doctor_count DESC;


-- ============================================================
-- 06. APPOINTMENT ANALYSIS
-- ============================================================

-- Appointment status distribution

SELECT
    status,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY status
ORDER BY appointment_count DESC;


-- Monthly appointment trend

SELECT
    MONTHNAME(appointment_date) AS month,
    MONTH(appointment_date) AS month_number,
    COUNT(*) AS appointment_count
FROM appointments
GROUP BY
    MONTH(appointment_date),
    MONTHNAME(appointment_date)
ORDER BY month_number;


-- Appointments handled by each doctor

SELECT
    d.name AS doctor_name,
    d.specialization,
    COUNT(a.appointment_id) AS appointment_count
FROM appointments a
JOIN doctors d
    ON a.doctor_id = d.doctor_id
GROUP BY
    d.doctor_id,
    d.name,
    d.specialization
ORDER BY appointment_count DESC;


-- Appointments by specialization

SELECT
    d.specialization,
    COUNT(a.appointment_id) AS appointment_count
FROM appointments a
JOIN doctors d
    ON a.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY appointment_count DESC;


-- Appointment status by specialization

SELECT
    d.specialization,
    a.status,
    COUNT(*) AS appointment_count
FROM appointments a
JOIN doctors d
    ON a.doctor_id = d.doctor_id
GROUP BY
    d.specialization,
    a.status
ORDER BY
    d.specialization,
    appointment_count DESC;


-- ============================================================
-- 07. APPOINTMENT PERFORMANCE KPIs
-- ============================================================

-- No-show rate

SELECT
    ROUND(
        100.0 *
        SUM(CASE WHEN status = 'No-show' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS no_show_rate_percent
FROM appointments;


-- Completed appointment rate

SELECT
    ROUND(
        100.0 *
        SUM(CASE WHEN status = 'Completed' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS completed_rate_percent
FROM appointments;


-- Cancellation rate

SELECT
    ROUND(
        100.0 *
        SUM(CASE WHEN status = 'Cancelled' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS cancellation_rate_percent
FROM appointments;


-- ============================================================
-- 08. TREATMENT ANALYSIS
-- ============================================================

-- Number of treatments by treatment type

SELECT
    treatment_type,
    COUNT(*) AS treatment_count
FROM treatments
GROUP BY treatment_type
ORDER BY treatment_count DESC;


-- Average treatment cost by treatment type

SELECT
    treatment_type,
    ROUND(AVG(cost), 2) AS average_treatment_cost
FROM treatments
GROUP BY treatment_type
ORDER BY average_treatment_cost DESC;


-- Total treatment cost by treatment type

SELECT
    treatment_type,
    ROUND(SUM(cost), 2) AS total_treatment_cost
FROM treatments
GROUP BY treatment_type
ORDER BY total_treatment_cost DESC;


-- Treatment activity by doctor

SELECT
    d.name AS doctor_name,
    d.specialization,
    COUNT(t.treatment_id) AS treatment_count,
    ROUND(SUM(t.cost), 2) AS total_treatment_cost
FROM treatments t
JOIN doctors d
    ON t.doctor_id = d.doctor_id
GROUP BY
    d.doctor_id,
    d.name,
    d.specialization
ORDER BY total_treatment_cost DESC;


-- ============================================================
-- 09. BILLING & REVENUE ANALYSIS
-- ============================================================

-- Total revenue

SELECT
    ROUND(SUM(amount), 2) AS total_revenue
FROM billing;


-- Revenue by patient

SELECT
    p.name AS patient_name,
    ROUND(SUM(b.amount), 2) AS total_billed_amount
FROM billing b
JOIN patients p
    ON b.patient_id = p.patient_id
GROUP BY
    p.patient_id,
    p.name
ORDER BY total_billed_amount DESC;


-- Average billing amount by patient

SELECT
    p.name AS patient_name,
    ROUND(AVG(b.amount), 2) AS average_bill_amount
FROM billing b
JOIN patients p
    ON b.patient_id = p.patient_id
GROUP BY
    p.patient_id,
    p.name
ORDER BY average_bill_amount DESC;


-- Revenue by doctor

SELECT
    d.name AS doctor_name,
    d.specialization,
    ROUND(SUM(b.amount), 2) AS total_revenue
FROM billing b
JOIN doctors d
    ON b.doctor_id = d.doctor_id
GROUP BY
    d.doctor_id,
    d.name,
    d.specialization
ORDER BY total_revenue DESC;


-- Revenue by specialization

SELECT
    d.specialization,
    ROUND(SUM(b.amount), 2) AS total_revenue
FROM billing b
JOIN doctors d
    ON b.doctor_id = d.doctor_id
GROUP BY d.specialization
ORDER BY total_revenue DESC;


-- Monthly revenue trend

SELECT
    DATE_FORMAT(bill_date, '%Y-%m') AS month,
    ROUND(SUM(amount), 2) AS monthly_revenue
FROM billing
GROUP BY DATE_FORMAT(bill_date, '%Y-%m')
ORDER BY month;


-- ============================================================
-- 10. BUSINESS PERFORMANCE ANALYSIS
-- ============================================================

-- Appointment volume and revenue by specialization

SELECT
    d.specialization,
    COUNT(DISTINCT a.appointment_id) AS appointment_count,
    ROUND(SUM(DISTINCT b.amount), 2) AS total_revenue
FROM doctors d
LEFT JOIN appointments a
    ON d.doctor_id = a.doctor_id
LEFT JOIN billing b
    ON d.doctor_id = b.doctor_id
GROUP BY d.specialization
ORDER BY appointment_count DESC;


-- Doctor workload and treatment activity

SELECT
    d.name AS doctor_name,
    d.specialization,
    COUNT(DISTINCT a.appointment_id) AS appointment_count,
    COUNT(DISTINCT t.treatment_id) AS treatment_count
FROM doctors d
LEFT JOIN appointments a
    ON d.doctor_id = a.doctor_id
LEFT JOIN treatments t
    ON d.doctor_id = t.doctor_id
GROUP BY
    d.doctor_id,
    d.name,
    d.specialization
ORDER BY appointment_count DESC;


-- ============================================================
-- 11. ADVANCED SQL ANALYSIS
-- ============================================================

-- Doctor revenue ranking using RANK()

WITH doctor_revenue AS (

    SELECT
        d.doctor_id,
        d.name AS doctor_name,
        d.specialization,
        SUM(b.amount) AS total_revenue

    FROM billing b

    JOIN doctors d
        ON b.doctor_id = d.doctor_id

    GROUP BY
        d.doctor_id,
        d.name,
        d.specialization
)

SELECT
    doctor_name,
    specialization,
    ROUND(total_revenue, 2) AS total_revenue,

    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank

FROM doctor_revenue

ORDER BY revenue_rank;


-- ============================================================
-- 12. MONTH-OVER-MONTH REVENUE GROWTH
-- ============================================================

WITH monthly_revenue AS (

    SELECT
        DATE_FORMAT(bill_date, '%Y-%m') AS month,
        SUM(amount) AS revenue

    FROM billing

    GROUP BY DATE_FORMAT(bill_date, '%Y-%m')
),

revenue_comparison AS (

    SELECT
        month,
        revenue,

        LAG(revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue

    FROM monthly_revenue
)

SELECT
    month,

    ROUND(revenue, 2) AS revenue,

    ROUND(previous_month_revenue, 2)
        AS previous_month_revenue,

    ROUND(
        100.0 *
        (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_growth_percent

FROM revenue_comparison

ORDER BY month;


-- ============================================================
-- 13. REVENUE PER APPOINTMENT
-- ============================================================

WITH specialization_metrics AS (

    SELECT
        d.specialization,

        COUNT(DISTINCT a.appointment_id)
            AS appointment_count,

        SUM(b.amount)
            AS total_revenue

    FROM doctors d

    LEFT JOIN appointments a
        ON d.doctor_id = a.doctor_id

    LEFT JOIN billing b
        ON d.doctor_id = b.doctor_id

    GROUP BY d.specialization
)

SELECT

    specialization,

    appointment_count,

    ROUND(total_revenue, 2)
        AS total_revenue,

    ROUND(
        total_revenue /
        NULLIF(appointment_count, 0),
        2
    ) AS revenue_per_appointment

FROM specialization_metrics

ORDER BY revenue_per_appointment DESC;


-- ============================================================
-- 14. DOCTOR WORKLOAD VS REVENUE
-- ============================================================

WITH doctor_metrics AS (

    SELECT

        d.doctor_id,

        d.name AS doctor_name,

        d.specialization,

        COUNT(DISTINCT a.appointment_id)
            AS appointment_count,

        COALESCE(
            SUM(DISTINCT b.amount),
            0
        ) AS total_revenue

    FROM doctors d

    LEFT JOIN appointments a
        ON d.doctor_id = a.doctor_id

    LEFT JOIN billing b
        ON d.doctor_id = b.doctor_id

    GROUP BY
        d.doctor_id,
        d.name,
        d.specialization
)

SELECT

    doctor_name,

    specialization,

    appointment_count,

    ROUND(total_revenue, 2)
        AS total_revenue,

    ROUND(
        total_revenue /
        NULLIF(appointment_count, 0),
        2
    ) AS revenue_per_appointment

FROM doctor_metrics

ORDER BY appointment_count DESC;


-- ============================================================
-- 15. BUSINESS QUESTIONS COVERED
-- ============================================================

-- 1. How many patients are recorded?
-- 2. How many doctors are working in the hospital?
-- 3. How many appointments and treatments are recorded?
-- 4. What is the total hospital billing revenue?
-- 5. What is the average billing amount?
-- 6. Which specializations have the highest number of doctors?
-- 7. Which specializations receive the most appointments?
-- 8. Which doctors handle the highest appointment volume?
-- 9. What is the distribution of appointment statuses?
-- 10. What is the hospital's no-show rate?
-- 11. Which treatment types have the highest costs?
-- 12. Which doctors generate the highest treatment activity?
-- 13. Which patients have the highest billing amounts?
-- 14. Which doctors and specializations generate the highest revenue?
-- 15. How does revenue change month over month?
-- 16. Which specializations generate the highest revenue per appointment?
-- 17. Which doctors combine high workload with high revenue contribution?


-- ============================================================
-- END OF ANALYSIS
-- ============================================================
