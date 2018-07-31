class Pagerduty
  class Incidents
    class Incident
      class Assignment
        include Virtus.model
        attribute :assignee, AssignedUser
        attribute :at
      end
    end
  end
end
  