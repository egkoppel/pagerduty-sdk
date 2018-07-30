class Pagerduty
    class AssignedUsers
      include Virtus.model
  
      attribute :assignee, AssignedUser
  
    end
  end
  