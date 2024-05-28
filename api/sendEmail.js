// api/sendEmail.js

const nodemailer = require('nodemailer');

module.exports = async (req, res) => {
  const { address } = req.body;

  // Initialize the transporter
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'uzairch296@gmail.com', // Replace with your email
      pass: 'owck nutj stnm ikth' // Replace with your email password or app-specific password
    }
  });

  // Email content
  const mailOptions = {
    from: 'uzairch296@gmail.com', // Replace with your email
    to: 'choudhary14949@gmail.com', // Replace with your recipient email
    subject: 'New Order Received',
    text: `New order placed!\nAddress: ${address}`
  };

  try {
    await transporter.sendMail(mailOptions);
    console.log('Email sent successfully');
    res.status(200).json({ message: 'Email sent successfully' });
  } catch (error) {
    console.error('Error sending email:', error);
    res.status(500).json({ error: 'Failed to send email' });
  }
};
