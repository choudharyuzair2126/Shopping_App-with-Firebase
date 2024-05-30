const nodemailer = require('nodemailer');

module.exports = async (req, res) => {
  const { address, productName, productPrice, productDescription } = req.body;

  if (!address || !productName || !productPrice || !productDescription) {
    return res.status(400).json({ error: 'Missing required fields' });
  }

  let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'choudhary14949@gmail.com',
      pass: 'xwjj hrqr zfzs ajyl', // Use your app-specific password
    },
  });

  let mailOptions = {
    from: 'choudhary14949@gmail.com',
    to: 'uzair2126@proton.me',
    subject: 'New Order Details',
    text: `Address: ${address}\nProduct Name: ${productName}\nProduct Price: ${productPrice}\nProduct Description: ${productDescription}`,
  };

  try {
    await transporter.sendMail(mailOptions);
    res.status(200).json({ message: 'Email sent successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to send email' });
  }
};
