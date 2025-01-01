SELECT schools.name, expenditures.per_pupil_expenditure, graduation_rates.graduated
FROM "districts"
JOIN "expenditures" ON districts.id = expenditures.district_id
JOIN "schools" ON districts.id = schools.district_id
JOIN "graduation_rates" ON schools.id = graduation_rates.school_id
ORDER BY expenditures.per_pupil_expenditure DESC, schools.name;