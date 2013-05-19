#encoding: utf-8
class UsersController < ApplicationController

	#before_filter :save_login_state, :only => [:new, :create]
	before_filter :authenticate_user, :only => [:index, :show, :edit, :update, :destroy]

	def index
		if check_admin
			@users = User.all
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end

	def new
		@user = User.new
	end

	def signup
		if session[:user_id].nil?
			@user = User.new
		else
			user = User.find session[:user_id]
			redirect_to(user)
		end
	end

	def create
		@user = User.new(params[:user])
		@user.utype = 0
		
		if @user.save
			flash[:notice] = "Usuario creado de manera exitosa. Haga Sign In."
		else
			flash[:error] = "Sus datos no son válidos."
		end

		redirect_to(root_path)
	end


	def show
		if check_admin || @current_user.id.to_s == params[:id]
			@user = User.find(params[:id])
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end

	def edit
		if check_admin || @current_user.id.to_s == params[:id]
			@user = User.find(params[:id])
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end

	def update
		if check_admin || @current_user.id.to_s == params[:id]
			@user = User.find(params[:id])
		 
			if @user.update_attributes(params[:user])
				flash[:notice] = 'El usuario fue actualizado de manera correcta.'
		    else
		    	flash[:error] = "No se pudieron actualizar los datos del usuario."
		    end

		    redirect_to(@user)
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end

	def destroy
		if check_admin
			@user = User.find(params[:id])
			@user.destroy

			redirect_to :action => 'index'
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end

	def get_users
		if check_prof
			tempStr = ""
			@users = {}
			hash = params[:groups_ids_]
			hash.each_with_index{ |h, index|
				tempStr += "#{h[1][:id]}"
		    	if index < ( hash.length-1 )
					tempStr += ","
				end
			}
			if tempStr != ""
				u = User.joins(:groups).select("DISTINCT users.id").where("groups_users.group_id in (#{tempStr})")
				@users = User.select("DISTINCT id, username, fname, lname").where("id not in (?)", u)

			else
				@users = User.where("id != #{session[:user_id]}").select("DISTINCT users.id, users.username, users.fname, users.lname")
			end
		    respond_to do |format|
		      format.json { render json: @users.to_json }
		    end
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end	

	def get_current_user
		respond_to do |format|
			format.json { render json: session[:user_id].to_json }
		end
	end

	def set_users_cantake
		if check_prof
			exam_name = params[:exam_name]
			checked_groups = params[:checked_groups]
	      	usersFromGroups = User.joins(:groups).select("DISTINCT users.id").where("groups_users.group_id in (?)", checked_groups)
			thisMasterExam = MasterExam.where(name: exam_name).where(user_id: session[:user_id]).last
	      	usersFromGroups.each do |user|
	      		if !Cantake.exists?(master_exam_id: exam_name, user_id: user[:id])
		  			c = Cantake.new
		  			c.master_exam_id = thisMasterExam.id
		  			c.user_id = user[:id]
		  			c.save!
	  			end
	      	end
			respond_to do |format|
				format.json { render json: usersFromGroups.to_json }
			end
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end

	# Used for setting up cantake for exercise purposes
	def set_user_cantake_own
		if authenticate_user
			exam_name = params[:exam_name]
			thisMasterExam = MasterExam.where(name: exam_name).where(user_id: session[:user_id]).last
	      	
			user = @current_user

	  		if !Cantake.exists?(master_exam_id: exam_name, user_id: user[:id])
	  			c = Cantake.new
	  			c.master_exam_id = thisMasterExam.id
	  			c.user_id = user[:id]
	  			c.save!
			end

			respond_to do |format|
				format.json { render json: usersFromGroups.to_json }
			end
		else
			flash[:error] = "Acceso restringido."
			redirect_to(root_path)
		end
	end

end