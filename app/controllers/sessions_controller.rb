class SessionsController < ApplicationController
    def new
    end 
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && check_password(params[:session][:password],user.password,user.email)
            session[:user_id] = user.id
            flash[:success] = "Succesfully Logged In"
            redirect_to root_path
        else 
            flash[:danger] = "Something went wrong "
            render 'new'
        end

    end
    
    def destroy
        session[:user_id] = nil
        flash[:success] = "Succesfully logged out"
        redirect_to root_path
    end



    def check_password(password,password2,email)
        password = encrypt_password(password,email);
        password == password2
    end
 
       def encrypt_password(password,email)
         if password.present?
           salt= Digest::SHA1.hexdigest("# We add #{email} as unique value")
           password= Digest::SHA1.hexdigest("Adding #{salt} to #{password}")
         end
       end
    
end