class AddUserIdToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :user, null: false, foreign_key: true, default: User.first.id
  end

  # Second variant
  # class AddUserIdToQuestions < ActiveRecord::Migration[6.1]
  #   def change
  #     opts = {null: false, foreign_key: true}
  #     opts = opts.merge({default: User.first.id}) if User.all.any?
  #     add_reference :questions, :user, **opts
  #   end
  # end
end
