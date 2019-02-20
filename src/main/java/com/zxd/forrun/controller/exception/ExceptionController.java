package com.zxd.forrun.controller.exception;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class ExceptionController {

    @RequestMapping("/err")
    public String error(){
        return "admin/error/error";
    }
}
