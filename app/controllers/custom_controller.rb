class CustomController < ApplicationController
  include Cms::Authentication::Controller
  def send_email
    recipients=params[:recipient].split(',')
    page_url=params[:page_url]
    subject=params[:subject]
    email_message=params[:email_message]
    for recipient in recipients
      Emailer.deliver_send_email(page_url, recipient, subject, email_message)
    end
  end
  
  #This function is for live search
  def search
    unless params[:search_text].blank?
      search_text="%" + params[:search_text] + "%"
      @pages=Page.find(:all, :conditions=>"name like '#{search_text}'")
    end
    render :partial=>'/custom/search', :object=>@pages
  end
  #This function to save the artcle
  def save_article
    unless params[:article_name].blank?
      link_url=params[:link_url].delete('#')
      SaveArticle.create(:name=>params[:article_name], :link=>link_url, :user_id=>current_user.id)
    end
    render :text=>"Article saved successfully."
  end
  #This is for updating the account email alert setting
  def account_email_alert
    if logged_in?
      @contact=Contact.find_by_ship_address_id(current_user.ship_address_id)
      render :partial=>'/custom/account_email_alert', :locals=>{:contact=>@contact}
    else
      render :text=> "To see this page, you should be log in."
    end
  end
  #This function save the account email alerts
  def save_account_email_alert
    contact=Contact.find(params[:contact_id])
    if params[:new_subscription_setting]=="false"
      contact.email_flag='No'
    else
      contact.email_flag='Yes'
    end
    if contact.save
      render :text=>true
    end  
  end
  #This function for updating the account subscription
  def acc_subscription
    if logged_in?
      @current_interest=[]
      @user_functions=Function.find( :all, 
                                    :joins  =>  " as f INNER JOIN contacts c ON c.id=f.contact_id and c.ship_address_id=#{current_user.ship_address_id}" ,
      :select =>  "f.id as function_id, f.contact_id as contact_id, f.contact_function_id as contact_function_id"
      )
      @user_functions.collect{|user_functions| @current_interest << user_functions.contact_function_id} unless @user_functions.blank?
      @contact_functions=ContactFunction.find(:all)
      unless @contact_functions.blank?
        if(@contact_functions.length%2==0)
          @contact_functions_left=@contact_functions.first(@contact_functions.length/2)
        else
          @contact_functions_left=@contact_functions.first(@contact_functions.length/2 +1)
        end
        @contact_functions_right=@contact_functions.last(@contact_functions.length/2)
      end
      render :partial=>'/custom/account_subscription', :locals=>{:user_functions=>@user_functions, :contact_functions=>@contact_functions, :current_interest=>@current_interest}
    else
      render :text=> "To see this page, you should be log in."
    end 
  end
  #This function saves the new account subscription.
  def save_account_subscription
    user_contact=Contact.find_by_ship_address_id(current_user.ship_address_id)
    #Delete exising interests.
    Function.delete_all("contact_id=#{user_contact.id}")
    #Insert new interest.
    new_interest=params[:new_interest].split(',') unless params[:new_interest].blank?
    unless new_interest.blank?
      new_interest.each do |interest|
        Function.create(:contact_id=>user_contact.id, :contact_function_id=>interest)
      end
    end
    render :text=>true
  end
  #This function is for saving new user password.
  def save_account_password
    user=current_user
    user.password=params[:new_password]
    user.password_confirmation=params[:confirm_password]
    user.save
    render :text=>true
  end
  #This function shows existing account information.
  def show_account_information
    if logged_in?
      @contact=Contact.find_by_ship_address_id(current_user.ship_address_id)
      @contact_email=ContactEmail.find(:first, :conditions=>"contact_id=#{@contact.id}")
      @user=current_user
      @billing_address=Address.find(current_user.bill_address_id)
      @billing_address_state=State.find(:all, :conditions=>"country_id=#{@billing_address.country_id}") unless @billing_address.country_id.blank?
      @ship_address=Address.find(current_user.ship_address_id)
      @ship_address_state=State.find(:all, :conditions=>"country_id=#{@ship_address.country_id}")
      @country=Country.find(:all)
      render :partial=>'/custom/account_information', :locals=>{:contact=>@contact,:contact_email=>@contact_email, :billing_address=>@billing_address, :ship_address=>@ship_address, :country=>@country, :ship_address_state=>@ship_address_state, :billing_address_state=>@billing_address_state}
    else
       render :text=> "To see this page, you should be log in."
    end
  end
  #This function saves the updated account information.
  def save_account_information
    bcountry_id=nil
    bstate_id=nil
    bstate_name=nil
    scountry_id=nil
    sstate_id=nil
    sstate_name=nil
    user=current_user
    contact=Contact.find_by_ship_address_id(user.ship_address_id)
    #update email for user and contact email
    unless contact.blank?
      bill_address=Address.find(contact.bill_address_id)
      ship_address=Address.find(contact.ship_address_id)
      contact.company=params[:company]
      contact.job_title=params[:job]
      contact.save
      contact_email=ContactEmail.find(:first, :conditions=>"contact_id=#{contact.id}")
      unless params[:email].blank?
        unless contact_email.blank?
          contact_email.email=params[:email] 
          contact_email.save
        end
        user.email=params[:email]
        user.save
      end
      #Update billing address information
      unless bill_address.blank?
        if params[:bcountry]!="0"
          bcountry_id=params[:bcountry]
        end
        if !params[:bstate].blank? and params[:bstate]!="0"
          bstate_id=params[:bstate]
        end
        if !params[:bstate_name].blank?
          bstate_id=nil
          bstate_name=params[:bstate_name]
        end
        bill_address.update_attributes(:firstname=>params[:bfname], :lastname=>params[:blname], :address1=>params[:bad1], :address2=>params[:bad2], :city=>params[:bcity],
                                       :phone=>params[:bphone], :zipcode=>params[:bzip], :country_id=>bcountry_id, :state_id=>bstate_id, :state_name=>bstate_name)
      end
      #Update shipping address information
      unless ship_address.blank?
        if params[:scountry]!="0"
          scountry_id=params[:scountry]
        end
        if !params[:sstate].blank? and params[:sstate]!="0"
          sstate_id=params[:sstate]
        end
        if !params[:sstate_name].blank?
          sstate_id=nil
          sstate_name=params[:sstate_name]
        end
        ship_address.update_attributes(:firstname=>params[:sfname], :lastname=>params[:slname], :address1=>params[:sad1], :address2=>params[:sad2], :city=>params[:scity],
                                       :phone=>params[:sphone], :zipcode=>params[:szip], :country_id=>scountry_id, :state_id=>sstate_id, :state_name=>sstate_name)
      end
    end  
    render :text=>true
  end
  #This function shows the state list.
  def show_state_list
    @state=State.find(:all, :conditions=>"country_id=#{params[:country_id].to_i}")
    unless params[:address_type].blank?
      case params[:address_type]
        when "bs"
        @state_id="bstate"
        when "ss"
        @state_id="sstate"
      end  
    end
    render :partial=>'/custom/state_list', :locals=>{:state=>@state}
  end
  
  #This function is for global search. Do a query on pages table and return the matched results.
  def global_search
    unless params[:global_search_text].blank?
      search_text="%" + params[:global_search_text] + "%"
      @pages=Page.find(:all, :conditions=>"name like '#{search_text}'")
    end
    render :partial=>'/custom/global_search', :object=>@pages
  end
end
