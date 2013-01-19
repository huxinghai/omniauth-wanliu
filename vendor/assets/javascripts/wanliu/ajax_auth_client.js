//author : huxinghai
//describe : 登陆系统客户端

// example 
//    #绑定与设置跨域访问回调方法, 传回参数登陆url
//    AjaxAuthClient.setupRetrieveLoginUrlCallback(function(url){
//    }) 
//            
//    #登陆成功后回调方法, 传回登陆用户信息
//    AjaxAuthClient.registreLoginSuccess(function(user){
//    })
//      
//    #加载注册页面触发事件
//    AjaxAuthClient.registreLoadCreateUser(function(){
//    })
//
//    #加载找回密码触发事件
//    AjaxAuthClient.registreLoadForgotPassword(function(){
//    })  

var AjaxAuth = function(options){

    this.default_params = {
        //iframe消息type
        // message_type : "login_message"                          
    }   

    if(!$.pm){ 
        console.error("include postMessage.js file ? ");
        return 
    }

    this.setParams(options);
}

AjaxAuth.prototype.setParams = function(options){
    $.extend(this.default_params, options);
}

AjaxAuth.prototype.loginSuccessCallback = function(data){}

//登陆成功触发
AjaxAuth.prototype.registreLoginSuccess = function(callback){
    if(typeof callback == "function") this.loginSuccessCallback = callback
    pm.bind("login_message", $.proxy(function(data){             
        this.loginSuccessCallback.apply(this, data)
    }, this)) 
}

AjaxAuth.prototype.registreLoadCreateUserCallback = function(){}

//加载注册页面触发
AjaxAuth.prototype.registreLoadCreateUser = function(callback){
    if(typeof callback == "function") this.registerLoadCreateUserCallback = callback
    pm.bind("user_register", this.registerLoadCreateUserCallback)
}

AjaxAuth.prototype.registreLoadForgotPasswordCallback = function(){}

//加载找回密码触发
AjaxAuth.prototype.registreLoadForgotPassword = function(callback){
    if(typeof callback == "function") this.registreLoadForgotPasswordCallback = callback
    pm.bind("user_forgot_password", this.registreLoadForgotPasswordCallback)
}

AjaxAuth.prototype.setupAjaxAuthCallback = function(url){}

AjaxAuth.prototype.setupRetrieveLoginUrlCallback = function(callback){

    if(typeof callback == "function") this.setupAjaxAuthCallback = callback        

    $(document).ajaxComplete(function(event, xhr){

        var url = xhr.getResponseHeader("sso_auth_url");
        if(!url)  return 
        var data = JSON.parse(xhr.getResponseHeader("sso_auth_params"));
        $.ajax({
            url : url,  
            data : data,
            dataType : "jsonp",                    
            jsonpCallback : "AjaxAuthClient.setupAjaxAuthCallback"
        });       
    })
}

window.AjaxAuthClient || (window.AjaxAuthClient = new AjaxAuth())