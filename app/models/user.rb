require 'net/ldap'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable, :omniauthable, :omniauth_providers => [:cas]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :reservations, :foreign_key => 'reserver_id'
  nilify_blanks :only => [:deleted_at] 
  has_and_belongs_to_many :requirements,
                          :class_name => "Requirement",
                          :association_foreign_key => "requirement_id",
                          :join_table => "users_requirements"

  attr_accessible :login, :first_name, :last_name, :nickname, :phone, :email,
                  :affiliation, :is_banned, :is_checkout_person, :is_admin,
                  :adminmode, :checkoutpersonmode, :normalusermode, :bannedmode, 
                  :deleted_at, :requirement_ids, :user_ids, :terms_of_service_accepted,
                  :created_by_admin, :provider, :uid

  attr_accessor(:full_query, :created_by_admin)

  validates :login,       :presence => true,
                          :uniqueness => true
  validates :first_name, 
            :last_name, 
            :affiliation, :presence => true
  validates :phone,       :presence    => true,
                          :format      => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i },
                          :length      => { :minimum => 10 }
  validates :email,       :presence    => true,
                          :format      => { :with => /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i },
                          :uniqueness => true
  validates :nickname,    :format      => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/ },
                          :allow_blank => true
  validates :terms_of_service_accepted,
                          :acceptance => {:accept => true, :message => "You must accept the terms of service."},
                          on: :create,
                          :if => Proc.new { |u| !u.created_by_admin == "true" }
                          
                          
                          

   default_scope where(:deleted_at => nil)
   
    def self.include_deleted
      self.unscoped
    end

  def name
     [((nickname.nil? || nickname.length == 0) ? first_name : nickname), last_name].join(" ")
  end
  
  def can_checkout?
    self.is_checkout_person? || self.is_admin_in_adminmode? || self.is_admin_in_checkoutpersonmode?
  end

  def is_admin_in_adminmode?
    is_admin? && adminmode?
  end

  def is_admin_in_checkoutpersonmode?
    is_admin? && checkoutpersonmode?
  end

  def is_admin_in_bannedmode?
    is_admin? && bannedmode?
  end
  
  def equipment_objects
    self.reservations.collect{ |r| r.equipment_objects }.flatten
  end

  # Returns array of the checked out equipment models and their counts for the user
  def checked_out_models
    #Make a hash of the checked out eq. models and their counts for the user
    model_ids = self.reservations.collect do |r|
      if (!r.checked_out.nil? && r.checked_in.nil?) # i.e. if checked out but not checked in yet
        r.equipment_model_id
      end        
    end

    #Remove nils, then count the number of unique model ids, and store the counts in a sub hash, and finally sort by model_id
    arr = model_ids.compact.inject(Hash.new(0)) {|h,x| h[x]+=1;h}.sort
    #Change into a hash of model_id => quantities
    Hash[*arr.flatten]
    
    #There might be a better way of doing this, but I realized that I wanted a hash instead of an array of hashes
  end
  
  def self.search_ldap(login)
    @app_configs = AppConfig.first
    ldap = Net::LDAP.new(:host => @app_configs.ldap_host, :port => @app_configs.ldap_port)
    filter = Net::LDAP::Filter.eq(@app_configs.ldap_login, login)
    attrs = [@app_configs.ldap_login, @app_configs.ldap_first_name, @app_configs.ldap_last_name, 
             @app_configs.ldap_phone, @app_configs.ldap_email]
    result = ldap.search(:base => @app_configs.ldap_base_query, :filter => filter, :attributes => attrs)
    unless result.empty?
    return { :first_name  => result[0][@app_configs.ldap_first_name.to_sym][0],
             :last_name   => result[0][@app_configs.ldap_last_name.to_sym][0],
             #:phone     => result[0][@app_configs.ldap_phone.to_sym][0],
             # Above line removed because the phone number in the Yale phonebook is always wrong
             :login       => result[0][@app_configs.ldap_login.to_sym][0],
             :email       => result[0][@app_configs.ldap_email.to_sym][0] 
           }
    end
  end

  def self.select_options
    self.find(:all, :order => 'last_name ASC').collect{ |item| ["#{item.last_name}, #{item.first_name}", item.id] }
  end
  
  def render_name
     [((nickname.nil? || nickname.length == 0) ? first_name : nickname), last_name, login].join(" ")
  end

  def self.find_for_cas(access_token, signed_in_resource=nil)
    user = User.where(:login => access_token[:uid]).first

    unless user
      user = User.create(
                         login: access_token.uid,
                         password: Devise.friendly_token[0,20]
                        )
    end
    user
  end


end
