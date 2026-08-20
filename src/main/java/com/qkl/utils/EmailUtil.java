package com.qkl.utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    // Gmail dùng để gửi email
    private static final String FROM_EMAIL = "hoanhao101@gmail.com";

    // App Password 16 ký tự của Gmail
    private static final String APP_PASSWORD = "xmzusrxtdnsdxdcj";


    public static void sendEmail(String toEmail, String subject, String content) throws MessagingException {

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");

        props.put("mail.smtp.host", "smtp.gmail.com");

        props.put("mail.smtp.port", "587");


        Session session = Session.getInstance(props, new Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });


        Message message = new MimeMessage(session);


        message.setFrom(new InternetAddress(FROM_EMAIL));


        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));


        message.setSubject(subject);


        message.setText(content);


        Transport.send(message);
    }
}