package ch.bbw.archictecturerefcard01;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import java.net.InetAddress;

@Controller
public class HomeController {

    @GetMapping("")
    public String home(Model model) {

        Message message = new Message();

        try {
            message.setText("IP Address (Server): " + InetAddress.getLocalHost().getHostAddress());
        } catch(Exception e) {
            message.setText("IP Address (Server): ---");
        }

        model.addAttribute("message", message.getText());
        return "index";
    }

}
