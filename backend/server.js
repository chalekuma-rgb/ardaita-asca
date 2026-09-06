const express = require('express');
const cors = require('cors');
const nodemailer = require('nodemailer');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Configure email transporter
const transporter = nodemailer.createTransport({
  service: process.env.EMAIL_SERVICE || 'gmail',
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASSWORD,
  },
});

// Contact form endpoint
app.post('/api/contact', async (req, res) => {
  try {
    const { fullName, email, message } = req.body;

    if (!fullName || !email || !message) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    // Send email to info@ardaita-asca.org
    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: 'info@ardaita-asca.org',
      subject: `Contact request from ${fullName}`,
      html: `
        <h2>New Contact Form Submission</h2>
        <p><strong>Name:</strong> ${fullName}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Message:</strong></p>
        <p>${message.replace(/\n/g, '<br>')}</p>
      `,
      replyTo: email,
    });

    res.status(200).json({ success: true, message: 'Email sent successfully' });
  } catch (error) {
    console.error('Error sending email:', error);
    res.status(500).json({ error: 'Failed to send email' });
  }
});

// Volunteer application endpoint
app.post('/api/volunteer', async (req, res) => {
  try {
    const { fullName, email, initiative, motivation } = req.body;

    if (!fullName || !email || !initiative || !motivation) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    // Send email to info@ardaita-asca.org
    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: 'info@ardaita-asca.org',
      subject: `Volunteer application from ${fullName}`,
      html: `
        <h2>New Volunteer Application</h2>
        <p><strong>Name:</strong> ${fullName}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Initiative:</strong> ${initiative}</p>
        <p><strong>Motivation:</strong></p>
        <p>${motivation.replace(/\n/g, '<br>')}</p>
      `,
      replyTo: email,
    });

    res.status(200).json({ success: true, message: 'Application sent successfully' });
  } catch (error) {
    console.error('Error sending email:', error);
    res.status(500).json({ error: 'Failed to send application' });
  }
});

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'Server is running' });
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
