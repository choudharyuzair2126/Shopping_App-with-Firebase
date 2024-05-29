const nodemailer = require('nodemailer');

exports.handler = async function(event, context) {
  try {
    const { address } = JSON.parse(event.body);

    if (!address) {
      throw new Error('Address is missing in the request body');
    }

    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: 'choudhary14949@gmail.com',
        pass: 'xwjj hrqr zfzs ajyl',
      },
    });

    const mailOptions = {
      from: 'choudhary14949@gmail.com',
      to: 'uzair2126@proton.me',
      subject: 'New Order Received',
      text: `
      New order details:
      Address: ${address}
      Product Name: ${productName}
      Product Price: ${productPrice}
      Product Description: ${productDescription}
    `,
    };

    const info = await transporter.sendMail(mailOptions);
    console.log('Email sent successfully:', info);
    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Email sent successfully' }),
    };
  } catch (error) {
    console.error('Error sending email:', error.message);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: `Failed to send email: ${error.message}` }),
    };
  }
};
