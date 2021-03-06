package com.example;

import java.util.Properties;
import redis.clients.jedis.JedisPool;  

import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Store;
public class Connections {

	
public static JedisPool connectionJedis(String redisHost, int redisPort)
{
	JedisPool pool = null;
	 pool = new JedisPool(redisHost, redisPort);  
	return pool;
}

	public static Store imapConnectionNP(String host, String port, String id, String pass)
	{
		 Store store = null;
		 try
		 {
		Properties properties = new Properties(); 
		properties.put("mail.store.protocol", "imaps"); 
		//properties.put("mail.store.protocol", "imap"); 
		properties.put("mail.imap.port", port); 
		properties.put("mail.imap.starttls.enable", "true"); 
		//properties.put("mail.imap.starttls.enable", "false"); 
		Session emailSession = Session.getDefaultInstance(properties); 
		store = emailSession.getStore("imaps"); 
		//store = emailSession.getStore("imap"); 
		store.connect(host, id, pass); 
		 }
		 catch(Exception e)
		 {
			 e.printStackTrace();
		 }
		 return store;
	}
	
	
	public static Store imapConnectionSmallNP(String host, String id, String pass)
	{
		 Store store = null;
		 try
		 {
			 Properties props = System.getProperties();
		    props.setProperty("mail.store.protocol", "imaps");
		     //props.setProperty("mail.store.protocol", "imap");
		     Session ses = Session.getDefaultInstance(props, null);
             store = ses.getStore("imaps");
             //store = ses.getStore("imap");
             store.connect(host,id, pass);
		 }
		 catch(Exception e)
		 {
			 e.printStackTrace();
		 }
		 return store;
	}
	
	
	public static Session smtpConnectionNP(String host, String port, String id, String pass)
	{
		final String username = id;//change accordingly
		final String password = pass;//change accordingly
		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		
		Session ses = Session.getInstance(props,
		  new javax.mail.Authenticator() {
		    protected PasswordAuthentication getPasswordAuthentication() {
		        return new PasswordAuthentication(username, password);
		    }
		  });
		
		
		/*Properties props = new Properties();
		props.put("mail.smtp.starttls.enable", "false");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		Session ses = Session.getDefaultInstance(props); */

		
		return ses;
	}
	
}
