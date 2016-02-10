class User < ActiveRecord::Base

  after_destroy :ensure_an_admin_remains
  validates :name, presence: true, uniqueness: true
  has_secure_password

  private

    # if the users table is empty after the deletion undo the delete and
    # restore that last user
    def ensure_an_admin_remains
      if User.count.zero?
        raise "Can't delete last user"
      end
    end

end
