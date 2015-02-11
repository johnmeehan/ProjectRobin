module Admin::PermissionsHelper
# Method returns a hash containing permissions configurable by admins
	def permissions
		{ "view" => "View" }
	end
end
