class RoomsController < ApplicationController
  before_action :load_entities

  def index
  end

  def show
    @room_message = RoomMessage.new room: @room, user: current_user
    @room_messages = @room.room_messages.includes(:user).last(20)
  end

  def create
    @room = Room.new permitted_parameters

    if @room.save
      @user_room = UserRoom.new(user: current_user, room: @room)
      @user_room.save!
      flash[:success] = "Chat #{@room.name} was created successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  def update
    if @room.update_attributes(permitted_parameters)
      flash[:success] = "Chat #{@room.name} was updated successfully"
      redirect_to rooms_path
    else
      render :new
    end
  end

  private

  def load_entities
    @room = Room.joins('INNER JOIN user_rooms ON rooms.id = user_rooms.room_id INNER JOIN user_rooms
      as ur ON rooms.id = ur.room_id')
      .where('user_rooms.user_id = ? AND ur.user_id = ?', params[:id], current_user.id).last
    @users = User.all - [current_user]

    if @room.blank?
      @room = Room.new(name: 'New room')
      # passing user_id as @chat_room_user_id here
      @chat_room_user_id = params[:id]
    end
  end

  def permitted_parameters
    params.require(:room).permit(:name)
  end
end
