module Admin::PermissionsHelper
  # Method returns a hash containing permissions configurable by admins
  def permissions
    {
      'view' => 'View',
      'create tickets' => 'Create Tickets',
      'edit tickets' => 'Edit Tickets',
      'delete tickets' => 'Delete Tickets',
      'change states' => 'Change States'
    }
  end
end
