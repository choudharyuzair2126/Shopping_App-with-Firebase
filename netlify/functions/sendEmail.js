const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

exports.sendEmail = functions.https.onRequest(async (req, res) => {
  const { address, productName, productPrice, productDescription } = req.body;

  // Validate request
  if (!address || !productName || !productPrice || !productDescription) {
    return res.status(400).send('Missing parameters');
  }

  // Create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'choudhary14949@gmail.com',
      pass: 'xwjj hrqr zfzs ajyl',
    },
  });

  // Setup email data
  let mailOptions = {
    from: 'choudhary14949@gmail.com',
    to: 'uzair2126@proton.me', // Change to your email
    subject: 'New Order Details',
    text: `
      New order details:
      Address: ${address}
      Product Name: ${productName}
      Product Price: ${productPrice}
      Product Description: ${productDescription}
    `,
  };

  // Send email
  try {
    let info = await transporter.sendMail(mailOptions);
    console.log('Email sent: ' + info.response);
    res.status(200).send('Email sent successfully');
  } catch (error) {
    console.error('Error sending email:', error);
    res.status(500).send('Error sending email');
  }
});
