# Ardaita Backend Server

This is the Node.js Express backend server for handling form submissions from the Ardaita website.

## Setup Instructions

### Prerequisites
- Node.js (v14 or higher)
- npm or yarn

### Installation

1. Navigate to the backend directory:
```bash
cd backend
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file based on `.env.example`:
```bash
cp .env.example .env
```

4. Configure your email settings in `.env`:
   - `EMAIL_USER`: Your Gmail address or email service account
   - `EMAIL_PASSWORD`: Your app password (for Gmail, use an app password, not your main password)
   - `PORT`: Server port (default: 3000)

### Running the Server

**Development mode (with auto-reload):**
```bash
npm run dev
```

**Production mode:**
```bash
npm start
```

The server will be running at `http://localhost:3000`

## API Endpoints

### POST /api/contact
Handles contact form submissions.

**Request body:**
```json
{
  "fullName": "John Doe",
  "email": "john@example.com",
  "message": "Your message here"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Email sent successfully"
}
```

### POST /api/volunteer
Handles volunteer application submissions.

**Request body:**
```json
{
  "fullName": "Jane Doe",
  "email": "jane@example.com",
  "initiative": "Education",
  "motivation": "I want to help with education initiatives"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Application sent successfully"
}
```

### GET /health
Health check endpoint to verify the server is running.

## Email Configuration with Gmail

To use Gmail for sending emails:

1. Enable 2-Factor Authentication on your Gmail account
2. Generate an App Password:
   - Go to https://myaccount.google.com/apppasswords
   - Select Mail and Windows Computer
   - Copy the generated password
3. Use the generated password as `EMAIL_PASSWORD` in your `.env` file

## Troubleshooting

- **"Unable to open an email application" error**: The backend server is not running. Make sure to run `npm start` or `npm run dev` first.
- **Email not sending**: Check your `.env` file for correct EMAIL_USER and EMAIL_PASSWORD values.
- **CORS errors**: Make sure the frontend is connecting to the correct backend URL.
