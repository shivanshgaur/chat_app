class RoomMessagesController < ApplicationController
  before_action :load_entities

  def create
    @room_message = RoomMessage.create(
      user: current_user,
      room: @room,
      message: params.dig(:room_message, :message)
    )

    @data = @room_message.as_json
    @data['created_at'] = @data['created_at'].strftime("%a, %e %b %Y %I:%M%p")

    RoomChannel.broadcast_to(
      @room,
      @data.merge(user_avatar_url: current_user.gravatar_url)
    )
  end

  private

  def load_entities
    payload = params.dig(:room_message)
    unless payload[:room_id].present?
      @room = Room.new(name: "#{current_user.id}_#{payload[:user_id]}")
      @room.save!
      @user_room1 = UserRoom.new(user: current_user, room: @room)
      @user_room2 = UserRoom.new(user_id: payload[:user_id], room: @room)
      @user_room1.save!
      @user_room2.save!
    else
      @room = Room.find payload[:room_id]
    end
  end
end
