package util;

import java.security.MessageDigest;

public class PasswordUtil {

    public static String hash(String password) throws Exception {

        MessageDigest md = MessageDigest.getInstance("SHA-256");

        byte[] bytes = md.digest(password.getBytes("UTF-8"));

        StringBuilder sb = new StringBuilder();

        for (byte b : bytes) {
            sb.append(String.format("%02x", b));
        }

        System.out.println("INPUT PASS: " + password);
        System.out.println("HASHED: " + sb.toString());

        return sb.toString();
    }
}