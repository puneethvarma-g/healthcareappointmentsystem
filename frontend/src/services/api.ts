import axios from 'axios';

const API_URL = 'http://localhost:8080/api'; // Adjust the URL as needed

// Function to register a new user
export const registerUser = async (userData) => {
    const response = await axios.post(`${API_URL}/register`, userData);
    return response.data;
};

// Function to log in a user
export const loginUser = async (credentials) => {
    const response = await axios.post(`${API_URL}/login`, credentials);
    return response.data;
};

// Function to fetch appointments for a user
export const fetchAppointments = async (userId) => {
    const response = await axios.get(`${API_URL}/appointments/${userId}`);
    return response.data;
};

// Function to create a new appointment
export const createAppointment = async (appointmentData) => {
    const response = await axios.post(`${API_URL}/appointments`, appointmentData);
    return response.data;
};

// Function to update an existing appointment
export const updateAppointment = async (appointmentId, appointmentData) => {
    const response = await axios.put(`${API_URL}/appointments/${appointmentId}`, appointmentData);
    return response.data;
};

// Function to delete an appointment
export const deleteAppointment = async (appointmentId) => {
    const response = await axios.delete(`${API_URL}/appointments/${appointmentId}`);
    return response.data;
};