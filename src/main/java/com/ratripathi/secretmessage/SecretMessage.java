package com.ratripathi.secretmessage;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity // Create secret message table
public class SecretMessage {
  @Id
  @GeneratedValue(strategy=GenerationType.AUTO)
  private Integer id;

  private String secretmessage;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getSecretmessage() {
    return secretmessage;
  }

  public void setSecretmessage(String secretmessage) {
    this.secretmessage = secretmessage;
  }
}
