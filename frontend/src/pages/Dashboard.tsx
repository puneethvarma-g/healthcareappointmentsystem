import React from 'react';
import { Link } from 'react-router-dom';

const Dashboard: React.FC = () => {
    return (
        <div className="dashboard">
            <h1>Dashboard</h1>
            <p>Welcome to your dashboard! Here you can manage your appointments and view your profile.</p>
            <nav>
                <ul>
                    <li>
                        <Link to="/appointments">View Appointments</Link>
                    </li>
                    <li>
                        <Link to="/profile">View Profile</Link>
                    </li>
                </ul>
            </nav>
        </div>
    );
};

export default Dashboard;