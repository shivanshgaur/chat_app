# == Schema Information
#
# Table name: room_messages
#
#  id         :bigint           not null, primary key
#  message    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  room_id    :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_room_messages_on_room_id  (room_id)
#  index_room_messages_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (room_id => rooms.id)
#  fk_rails_...  (user_id => users.id)
#

require 'test_helper'

class RoomMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
