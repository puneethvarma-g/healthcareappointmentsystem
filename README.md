# Healthcare Appointment System

## Overview
The Healthcare Appointment System is a full-stack application that allows users to manage their healthcare appointments. It consists of a frontend built with React.js using Vite and a backend developed with Spring Boot.

## Features
- User registration and authentication
- Appointment creation, viewing, and management
- Responsive design for various devices

## Technologies Used
- **Frontend**: React.js, Vite, TypeScript, CSS
- **Backend**: Spring Boot, Java, Maven
- **Database**: H2 (in-memory database for development)

## Project Structure
```
healthcare-appointment-system
├── frontend                # Frontend application
│   ├── src                 # Source files for React application
│   ├── package.json        # NPM configuration
│   ├── vite.config.ts      # Vite configuration
│   └── tsconfig.json       # TypeScript configuration
├── backend                 # Backend application
│   ├── src                 # Source files for Spring Boot application
│   ├── pom.xml             # Maven configuration
│   └── resources           # Resource files including application.yml
├── docker-compose.yml      # Docker configuration
└── README.md               # Project documentation
```

## Getting Started

### Prerequisites
- Node.js (for frontend)
- Java JDK (for backend)
- Maven (for backend)
- Docker (optional, for containerization)

### Frontend Setup
1. Navigate to the `frontend` directory:
   ```
   cd frontend
   ```
2. Install dependencies:
   ```
   npm install
   ```
3. Start the development server:
   ```
   npm run dev
   ```

### Backend Setup
1. Navigate to the `backend` directory:
   ```
   cd backend
   ```
2. Build the project using Maven:
   ```
   mvn clean install
   ```
3. Run the Spring Boot application:
   ```
   mvn spring-boot:run
   ```

### Running with Docker
To run the application using Docker, execute the following command in the root directory:
```
docker-compose up
```

## Usage
- Access the frontend application at `http://localhost:3000`
- The backend API is available at `http://localhost:8080`

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any enhancements or bug fixes.

## License
This project is licensed under the MIT License.