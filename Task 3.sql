CREATE TRIGGER trg_AutoCreateBillAfterAppointment
ON appointment
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO patient_bill (appointment_id, amount, bill_status_id, payment_method_id, bill_paid_datetime)
    SELECT 
        i.appointment_id,
        NULL AS amount,          
        'B001' AS bill_status_id,
        NULL AS payment_method_id,
        NULL AS bill_paid_datetime                   -- chưa thanh toán
    FROM inserted i
    JOIN deleted d 
    ON i.appointment_id = d.appointment_id
    WHERE i.status_id = 'A003'      -- trạng thái Completed
      AND d.status_id <> 'A003'     -- chỉ khi chuyển từ trạng thái khác sang Completed
      AND NOT EXISTS (              -- tránh tạo trùng hóa đơn
          SELECT 1 FROM patient_bill pb 
          WHERE pb.appointment_id = i.appointment_id
      );
END;

CREATE TRIGGER trg_CreatePrescription_When_Confirmed
ON appointment
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO prescription (appointment_id, medicine_name, dosage, frequency, instructions)
    SELECT 
        i.appointment_id,
        NULL AS medicine_name,
        NULL AS dosage,
        NULL AS frequency,
        NULL AS instructions
    FROM inserted i
    JOIN deleted d ON i.appointment_id = d.appointment_id
    WHERE i.status_id = 'A002'       -- chuyển sang Confirmed
      AND d.status_id <> 'A002'      -- trước đó KHÔNG phải Confirmed
      AND NOT EXISTS (               
          SELECT 1 FROM prescription p 
          WHERE p.appointment_id = i.appointment_id
      );
END;
GO

CREATE TRIGGER trg_CheckAppointmentDate
ON appointment
INSTEAD OF INSERT
AS
BEGIN
    -- Kiểm tra trùng lịch: cùng doctor_id và appointment_datetime
    IF EXISTS (
        SELECT 1
        FROM appointment a
        JOIN inserted i 
            ON a.doctor_id = i.doctor_id
           AND a.appointment_datetime = i.appointment_datetime
    )
    BEGIN
        RAISERROR('Lịch hẹn này đã bị trùng (bác sĩ có lịch khác tại thời điểm đó).', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;

    -- Nếu không trùng, thực hiện chèn bình thường
    INSERT INTO appointment (patient_id, doctor_id, appointment_datetime, status_id, note)
    SELECT patient_id, doctor_id, appointment_datetime, status_id, note
    FROM inserted;
END;
GO
