package web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;
import service.DepartmentServise;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.*;




@Controller
public class ControllerWeb {
	
	@Autowired
	private DepartmentServise departmentServise;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String index(Model model) {
		model.addAttribute("list", departmentServise.listDepartment());
		return "locality";
	}
	@RequestMapping(value = "/admin-mail", method = RequestMethod.GET)
	public String admin(Model model) {
		model.addAttribute("list", departmentServise.listDepartment());
		return "admin";
	}
	
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String admin2(Model model) {
		model.addAttribute("list", departmentServise.listDepartment());
		return "admin2";
	}
	
	@RequestMapping(value = "/mail")
	public String mail(WebRequest req,Model model,@RequestParam("subject") String subject,@RequestParam("body") String body,@RequestParam("from") String from,@RequestParam("to") String to) {
		try {
			send("10.93.1.63", 25, from,to, subject,body);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "male";
	}
	
	public void send(String smtpHost, int smtpPort, String from,String to, String subject, String content) throws MessagingException {

		java.util.Properties props = System.getProperties();
		props.setProperty("mail.smtp.host", smtpHost); 
		props.setProperty("mail.smtp.port", ""+smtpPort);
		Session session = Session.getDefaultInstance (props, null);
		// Construct the message
		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(from));
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		msg.setSubject(subject);
		//msg.setText(content);
		
		MimeMultipart mm = new MimeMultipart();
	    MimeBodyPart mbp = new MimeBodyPart();
	    mbp.setContent(content, "text/html; charset=windows-1251");
	    mm.addBodyPart(mbp);
	    msg.setContent(mm);
				
		Transport.send(msg);
		}
	

}
