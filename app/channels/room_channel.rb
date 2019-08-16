class RoomChannel < ApplicationCable::Channel
  def subscribed
    return if params[:room].blank?

    room = Room.find params[:room]
    stream_for room

    # or
    # stream_from "room_#{params[:room]}"
  end
end
