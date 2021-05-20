package com.ratripathi.secretmessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.nio.charset.Charset;
import java.util.Random;

@Controller
@RequestMapping(path="/api/v1")
public class GenerateSecretMessageResource {
  @Autowired
  private SecretMessageRepository secretMessageRepository;

  @Value("${secretKey}")
  private String secretKey;

  @GetMapping(path="/createSecretMessage")
  public @ResponseBody String createSecretMessage() {
    // This returns an encrypted random string using AES encryption
    byte[] array = new byte[20];
    new Random().nextBytes(array);
    String originalString = new String(array, Charset.forName("UTF-8"));
    String encryptedString = SecretMessageEncDec.encrypt(originalString, secretKey) ;
    SecretMessage s = new SecretMessage();
    s.setSecretmessage(encryptedString);
    secretMessageRepository.save(s);
    return encryptedString;
  }


}
