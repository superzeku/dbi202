create database Doctor_Clinic

create table patient(
	auto_id int identity,
	patient_id as cast(
		('P' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
	) persisted,
	first_name varchar(50),
	last_name varchar(50),
	gender char(1) check (gender in ('M','F')),
	date_of_birth date,
	phone_number char(12),
	constraint PK_patient_id primary key (patient_id)
)
insert into patient (first_name, last_name, gender, date_of_birth, phone_number) values
('Nguyen', 'An', 'M', '1990-03-12', '0905123456'),
('Tran', 'Binh', 'M', '1988-07-22', '0902345678'),
('Le', 'Chi', 'F', '1992-05-17', '0908765432'),
('Pham', 'Dung', 'F', '1995-11-01', '0909988776'),
('Vo', 'Hai', 'M', '1999-09-09', '0902233445'),
('Dang', 'Hanh', 'F', '2001-01-15', '0904455667'),
('Ho', 'Long', 'M', '1987-06-06', '0906677889'),
('Phan', 'Minh', 'M', '1993-12-25', '0905566778'),
('Do', 'Nga', 'F', '1994-04-04', '0907788990'),
('Bui', 'Oanh', 'F', '1998-02-19', '0908899001'),
('Nguyen', 'Phuong', 'F', '1991-08-30', '0909001122'),
('Le', 'Quang', 'M', '1989-10-14', '0901111222'),
('Tran', 'Son', 'M', '1996-03-03', '0903333444'),
('Pham', 'Trang', 'F', '1997-09-23', '0905555666'),
('Vo', 'Uy', 'M', '1990-12-12', '0906666777'),
('Ho', 'Vy', 'F', '2000-07-07', '0907777888'),
('Dang', 'Xuan', 'M', '1985-02-02', '0908888999'),
('Phan', 'Yen', 'F', '1992-01-21', '0909999000'),
('Do', 'Zung', 'F', '1993-05-11', '0901111333'),
('Bui', 'Khanh', 'M', '1988-08-18', '0902222444')

create table doctor (
    auto_id int identity,
    doctor_id as cast(
        ('D' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
    ) persisted,
    first_name varchar(50),
    last_name varchar(50),
    gender char(1) check (gender in ('M','F')),
	specialisation varchar(100) not null,
    constraint PK_doctor_id primary key (doctor_id)
)
insert into doctor (first_name, last_name, gender, specialisation) values
('Nguyen', 'Van An', 'M', 'Cardiology'),
('Tran', 'Thi Bich', 'F', 'Dermatology'),
('Le', 'Hoang Nam', 'M', 'Neurology'),
('Pham', 'Thi Lan', 'F', 'Pediatrics'),
('Hoang', 'Minh Duc', 'M', 'Orthopedics'),
('Do', 'Ngoc Anh', 'F', 'Ophthalmology'),
('Bui', 'Van Long', 'M', 'ENT'),
('Vo', 'Thi Thu', 'F', 'Endocrinology'),
('Dang', 'Minh Tuan', 'M', 'Urology'),
('Ngo', 'Thi Huong', 'F', 'Gynecology'),
('Pham', 'Van Phuc', 'M', 'Psychiatry'),
('Nguyen', 'Bao Chau', 'F', 'Oncology'),
('Tran', 'Thanh Dat', 'M', 'Radiology'),
('Le', 'Thi Kim', 'F', 'Hematology'),
('Ho', 'Van Thanh', 'M', 'Gastroenterology'),
('Do', 'Thi Mai', 'F', 'Nephrology'),
('Phan', 'Van Toan', 'M', 'Surgery'),
('Vo', 'Thi Hong', 'F', 'Obstetrics'),
('Nguyen', 'Van Tien', 'M', 'Anesthesiology'),
('Tran', 'Thi Quynh', 'F', 'Immunology')

create table appointment_status (
    auto_id int identity,
    app_status_id as cast(
        ('A' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
    ) persisted,
    name varchar(50),
    constraint PK_app_status_id primary key (app_status_id)
)
insert into appointment_status(name) values
('Pending'),
('Confirmed'),
('Completed'),
('Cancelled')

create table appointment (
    auto_id int identity,
    appointment_id as cast(
        ('R' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
    ) persisted,
    patient_id varchar(10) references patient(patient_id),
    doctor_id varchar(10) references doctor(doctor_id),
    appointment_datetime datetime not null,
    status_id varchar(10) references appointment_status(app_status_id),
    reason varchar(200),
    note text,
    constraint PK_appointment_id primary key (appointment_id)
)
insert into appointment (patient_id, doctor_id, appointment_datetime, status_id, reason, note)
values
('P001', 'D001', '2025-11-07 09:00', 'A001', 'Headache', 'Patient reports mild pain, pending consultation.'),
('P002', 'D002', '2025-11-07 09:30', 'A002', 'Skin rash', 'Confirmed appointment. Possible allergy check.'),
('P003', 'D003', '2025-11-07 10:00', 'A003', 'Follow-up', 'Completed follow-up visit, stable condition.'),
('P004', 'D004', '2025-11-07 10:30', 'A004', 'Cough', 'Appointment cancelled by patient.'),
('P005', 'D005', '2025-11-07 11:00', 'A001', 'Fever', 'Patient has mild fever, waiting to confirm visit.'),
('P006', 'D006', '2025-11-07 13:00', 'A002', 'Check-up', 'Confirmed for general health examination.'),
('P007', 'D007', '2025-11-07 13:30', 'A003', 'Toothache', 'Completed consultation, referred to dental clinic.'),
('P008', 'D008', '2025-11-07 14:00', 'A002', 'Back pain', 'Confirmed physiotherapy session.'),
('P009', 'D009', '2025-11-07 14:30', 'A003', 'Blood test', 'Completed blood test and awaiting results.'),
('P010', 'D010', '2025-11-07 15:00', 'A004', 'Headache', 'Cancelled due to doctor unavailability.'),
('P011', 'D011', '2025-11-08 09:00', 'A001', 'Vision issues', 'Pending eye examination appointment.'),
('P012', 'D012', '2025-11-08 09:30', 'A002', 'Allergy test', 'Confirmed skin test for allergy diagnosis.'),
('P013', 'D013', '2025-11-08 10:00', 'A003', 'Heart check-up', 'Completed ECG, results normal.'),
('P014', 'D014', '2025-11-08 10:30', 'A003', 'Blood pressure', 'Completed BP check, slightly high reading.'),
('P015', 'D015', '2025-11-08 11:00', 'A002', 'Diabetes follow-up', 'Confirmed follow-up with endocrinologist.'),
('P016', 'D016', '2025-11-08 13:00', 'A003', 'Abdominal pain', 'Completed consultation, ultrasound recommended.'),
('P017', 'D017', '2025-11-08 13:30', 'A004', 'Chest pain', 'Cancelled — patient admitted to emergency.'),
('P018', 'D018', '2025-11-08 14:00', 'A002', 'Pregnancy check', 'Confirmed prenatal checkup at week 24.'),
('P019', 'D019', '2025-11-08 14:30', 'A001', 'Insomnia', 'Pending confirmation for sleep evaluation.'),
('P020', 'D020', '2025-11-08 15:00', 'A003', 'Routine check-up', 'Completed health examination, all normal.')

create table bill_status (
	auto_id int identity,
	bill_status_id as cast(
		('B' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
	) persisted,
	name varchar(50),
	constraint PK_bill_status_id primary key (bill_status_id)
)
insert into bill_status(name) values
('Unpaid'),
('Paid'),
('Cancelled')

create table payment_method (
	auto_id int identity,
	payment_method_id as cast(
		('M' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
	) persisted,
	name varchar(50),
	constraint PK_payment_method_id primary key (payment_method_id)
)
insert into payment_method(name) values
('Cash'),
('Credit Card'),
('Bank Transfer')

create table patient_bill (
	auto_id int identity,
	bill_id as cast(
		('H' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
	) persisted,
	appointment_id varchar(10) references appointment(appointment_id),
	amount decimal(10,2),
	bill_status_id varchar(10) references bill_status(bill_status_id),
	payment_method_id varchar(10) references payment_method(payment_method_id),
	bill_paid_datetime datetime,
	constraint PK_bill_id primary key (bill_id)
)
insert into patient_bill (appointment_id, amount, bill_status_id, payment_method_id, bill_paid_datetime)
values
('R001', 300000.00, 'B002', 'M001', getdate()),
('R002', 450000.00, 'B002', 'M002', getdate()),
('R003', 200000.00, 'B002', 'M001', getdate()),
('R004', 0.00, 'B003', 'M001', null),
('R005', 250000.00, 'B001', 'M001', null),
('R006', 500000.00, 'B002', 'M003', getdate()),
('R007', 150000.00, 'B002', 'M001', getdate()),
('R008', 400000.00, 'B002', 'M003', getdate()),
('R009', 350000.00, 'B002', 'M001', getdate()),
('R010', 0.00, 'B003', 'M001', null),
('R011', 200000.00, 'B001', 'M002', null),
('R012', 600000.00, 'B002', 'M003', getdate()),
('R013', 450000.00, 'B002', 'M001', getdate()),
('R014', 300000.00, 'B002', 'M003', getdate()),
('R015', 400000.00, 'B002', 'M002', getdate()),
('R016', 500000.00, 'B002', 'M001', getdate()),
('R017', 0.00, 'B003', 'M003', null),
('R018', 550000.00, 'B002', 'M002', getdate()),
('R019', 200000.00, 'B001', 'M001', null),
('R020', 450000.00, 'B002', 'M001', getdate())

create table prescription (
	auto_id int identity,
	prescription_id as cast(
		('P' + right('000' + cast(auto_id as varchar(10)), 3)) as varchar(10)
	) persisted,
	appointment_id varchar(10) references appointment(appointment_id),
	medicine_name varchar(100),
	dosage varchar(50),
	frequency varchar(50),
	instructions varchar(200),
	constraint PK_prescription_id primary key (prescription_id)
)
insert into prescription (appointment_id, medicine_name, dosage, frequency, instructions)
values
('R001', 'Paracetamol 500mg', '1 tablet', '3 times a day', 'Take after meals'),
('R002', 'Cetirizine 10mg', '1 tablet', 'Once daily', 'Take before bedtime'),
('R003', 'Vitamin C 1000mg', '1 tablet', 'Once daily', 'Take in the morning'),
('R004', 'Cough syrup', '10ml', '3 times a day', 'Shake well before use'),
('R005', 'Amoxicillin 500mg', '1 capsule', '3 times a day', 'Take after food'),
('R006', 'Ibuprofen 400mg', '1 tablet', '2 times a day', 'Take after meal'),
('R007', 'Mouthwash', '15ml', 'Twice daily', 'Rinse for 30 seconds'),
('R008', 'Pain relief gel', 'Apply small amount', '3 times a day', 'Apply to affected area'),
('R009', 'Iron supplement', '1 tablet', 'Once daily', 'Take with food'),
('R010', 'Vitamin D3', '1 capsule', 'Once weekly', 'Take after breakfast'),
('R011', 'Eye drops', '2 drops', '3 times a day', 'Apply gently to both eyes'),
('R012', 'Antihistamine 5mg', '1 tablet', 'Once daily', 'Avoid alcohol'),
('R013', 'Aspirin 81mg', '1 tablet', 'Once daily', 'Take after food'),
('R014', 'Losartan 50mg', '1 tablet', 'Once daily', 'Take at night'),
('R015', 'Metformin 500mg', '1 tablet', '2 times a day', 'Take after meal'),
('R016', 'Omeprazole 20mg', '1 capsule', 'Once daily', 'Take before breakfast'),
('R017', 'Nitroglycerin 0.5mg', '1 tablet', 'As needed', 'Place under tongue for chest pain'),
('R018', 'Prenatal vitamins', '1 tablet', 'Once daily', 'Take in the morning'),
('R019', 'Melatonin 3mg', '1 tablet', 'At bedtime', 'Take 30 minutes before sleep'),
('R020', 'Multivitamin', '1 tablet', 'Once daily', 'Take after breakfast')
