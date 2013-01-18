# Omniauth::Wanliu

使用omniauth登陆系统, 支持ajax登陆

## Installation

Add this line to your application's Gemfile:

    gem 'omniauth-wanliu', :github => "huxinghai1988/omniauth-wanliu"

And then execute:

    $ bundle

## Usage

1. 在项目config目录新建<code>sso.yml</code>文件, 内容格式如下：
    
    ```ruby
        accounts:
            provider_url: http://192.168.2.167:3002                     #帐户服务器地址
            app_id: 4224b3ed9c840c0d7b284f                              #授权id
            app_secret: oXIuKylcvf73EXe6R0Lhooxms2hfxcna7yfQs+9acHc=    #授权安全码
    ```

2. <code>config/initializers/omniauth.rb</code>文件初始化middleware, 例如:
    
    ```ruby
        info = OmniAuth::Wanliu.config
        Rails.application.config.middleware.use OmniAuth::Builder do 
            provider :WanliuId , info["app_id"], info["app_secret"]
        end
    ```

## 使用ajax登陆帐户配置

1. <code>ApplicationController</code> 控制器包含ajax helper方法, 例如:
    
    ```ruby
        OmniAuth::Wanliu::AjaxHelpers 
    ```

2. 在登陆过虑器方法添加ajax请求<code>ajax_set_response_headers</code>方法设置头部，例如:   
    
    ```ruby
        def login_required        
            if !current_user                
                respond_to do |format|    
                    format.js{
                        ajax_set_response_headers
                        render :text => :ok } 
                    format.html{ 
                        redirect_to '/auth/wanliuid'  }            
                end
            end
        end
    ```

3. 客户端引用js文件, 例如:
  
  ```ruby  
    #在application.js添加如下代码
    //= require wanliu/ajax_auth_client.js

    #ajax验证， 传参平台登陆页面url
    AjaxAuthClient.setupAjaxAuth(function(url){                
    })

    #注册登陆成功事件
    AjaxAuthClient.RegistreSuccess(function(user){        
    })

  ```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request