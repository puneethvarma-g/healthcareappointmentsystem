import React, { useState } from 'react';
import { Appointment } from '../types';

interface AppointmentFormProps {
    onSubmit: (appointment: Appointment) => void;
    existingAppointment?: Appointment;
}

const AppointmentForm: React.FC<AppointmentFormProps> = ({ onSubmit, existingAppointment }) => {
    const [date, setDate] = useState(existingAppointment?.date || '');
    const [time, setTime] = useState(existingAppointment?.time || '');
    const [doctor, setDoctor] = useState(existingAppointment?.doctor || '');
    const [patient, setPatient] = useState(existingAppointment?.patient || '');

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        onSubmit({ date, time, doctor, patient });
    };

    return (
        <form onSubmit={handleSubmit}>
            <div>
                <label>Date:</label>
                <input type="date" value={date} onChange={(e) => setDate(e.target.value)} required />
            </div>
            <div>
                <label>Time:</label>
                <input type="time" value={time} onChange={(e) => setTime(e.target.value)} required />
            </div>
            <div>
                <label>Doctor:</label>
                <input type="text" value={doctor} onChange={(e) => setDoctor(e.target.value)} required />
            </div>
            <div>
                <label>Patient:</label>
                <input type="text" value={patient} onChange={(e) => setPatient(e.target.value)} required />
            </div>
            <button type="submit">Submit</button>
        </form>
    );
};

export default AppointmentForm;