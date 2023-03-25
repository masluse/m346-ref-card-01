package ch.bbw.archictecturerefcard01;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;

@RestController
public class RestAPIController {

    @GetMapping("api")
    public ResponseEntity<Message> hello(HttpServletRequest request) {

        Message message = new Message("Application Ref. Card 01 - API hello");
        try {
            String serverIp = InetAddress.getLocalHost().getHostAddress();
            message.setText(message.getText() + " - Server IP Address: " + serverIp);
        } catch(Exception e) {
        }
        return ResponseEntity.ok(new Message());
    }
}
