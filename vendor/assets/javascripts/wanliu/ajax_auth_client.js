//author : huxinghai
//describe : 登陆系统客户端

// example 
//    #绑定与设置跨域访问回调方法, 传回参数登陆url
//    AjaxAuthClient.setupAjaxAuth(function(url){
//    }) 
//            
//    #注册成功后回调方法, 传回登陆用户信息
//    AjaxAuthClient.RegistreSuccess(function(user){
//    })

var AjaxAuth = function(options){

    this.default_params = {
        //iframe消息type
        message_type : "login_message"                          
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

AjaxAuth.prototype.RegistreSuccess = function(callback){
    if(typeof callback == "function") this.loginSuccessCallback = callback
    pm.bind(this.default_params.message_type, $.proxy(function(data){             
        this.loginSuccessCallback.apply(this, data)
    }, this)) 
}

AjaxAuth.prototype.setupAjaxAuthCallback = function(url){}

AjaxAuth.prototype.setupAjaxAuth = function(callback){

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