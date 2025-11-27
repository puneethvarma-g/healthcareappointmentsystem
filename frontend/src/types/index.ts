export interface User {
    id: number;
    username: string;
    email: string;
    password: string;
}

export interface Appointment {
    id: number;
    userId: number;
    date: string;
    time: string;
    description: string;
}