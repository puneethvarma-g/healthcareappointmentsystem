import React, { useEffect, useState } from 'react';
import AppointmentList from '../components/AppointmentList';
import AppointmentForm from '../components/AppointmentForm';
import { getAppointments, createAppointment } from '../services/api';

const Appointments = () => {
    const [appointments, setAppointments] = useState([]);
    const [isEditing, setIsEditing] = useState(false);
    const [currentAppointment, setCurrentAppointment] = useState(null);

    useEffect(() => {
        fetchAppointments();
    }, []);

    const fetchAppointments = async () => {
        const data = await getAppointments();
        setAppointments(data);
    };

    const handleCreateAppointment = async (appointment) => {
        await createAppointment(appointment);
        fetchAppointments();
    };

    const handleEditAppointment = (appointment) => {
        setCurrentAppointment(appointment);
        setIsEditing(true);
    };

    const handleUpdateAppointment = async (updatedAppointment) => {
        // Logic to update the appointment
        fetchAppointments();
        setIsEditing(false);
        setCurrentAppointment(null);
    };

    return (
        <div>
            <h1>Manage Appointments</h1>
            <AppointmentForm 
                onSubmit={isEditing ? handleUpdateAppointment : handleCreateAppointment} 
                appointment={currentAppointment} 
                setIsEditing={setIsEditing} 
            />
            <AppointmentList 
                appointments={appointments} 
                onEdit={handleEditAppointment} 
            />
        </div>
    );
};

export default Appointments;