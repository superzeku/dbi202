CREATE PROCEDURE sp_CreatePrescription
    @MedicineName NVARCHAR(100),
    @Dosage NVARCHAR(50),
    @Frequency NVARCHAR(50),
    @Instructions NVARCHAR(255)
AS
BEGIN
    INSERT INTO prescription (medicine_name, dosage, frequency, instructions)
    VALUES (@MedicineName, @Dosage, @Frequency, @Instructions);
END;
GO

CREATE PROCEDURE sp_GetPrescriptionByAppointment
    @AppointmentID INT
AS
BEGIN
    SELECT 
        prescription_id,
        medicine_name,
        dosage,
        frequency,
        instructions
    FROM prescription
    WHERE appointment_id = @AppointmentID;
END;
GO

CREATE PROCEDURE sp_CreateBill
    @AppointmentID INT,
    @Amount DECIMAL(10,2),
    @BillStatusID INT,
    @PaymentMethodID INT
AS
BEGIN
    INSERT INTO patient_bill (appointment_id, amount, bill_status_id, payment_method_id, bill_paid_datetime)
    VALUES (@AppointmentID, @Amount, @BillStatusID, @PaymentMethodID, GETDATE());
END;
GO

CREATE PROCEDURE sp_UpdateBillStatus
    @BillID INT,
    @NewStatus NVARCHAR(3)  -- 'Yes' hoặc 'No'
AS
BEGIN
    IF @NewStatus NOT IN ('Yes', 'No')
    BEGIN
        RAISERROR('Error.', 16, 1);
        RETURN;
    END

    UPDATE patient_bill
    SET bill_status_id = @NewStatus
    WHERE bill_id = @BillID;
END;
GO

CREATE PROCEDURE sp_GetTotalRevenueByDoctor
    @DoctorID INT
AS
BEGIN
    SELECT 
        d.doctor_id,
        d.first_name + ' ' + d.last_name AS doctor_name,
        SUM(pb.amount) AS total_revenue
    FROM doctor d
    JOIN appointment a ON d.doctor_id = a.doctor_id
    JOIN patient_bill pb ON a.appointment_id = pb.appointment_id
    WHERE d.doctor_id = @DoctorID
    GROUP BY d.doctor_id, d.first_name, d.last_name;
END;
GO
