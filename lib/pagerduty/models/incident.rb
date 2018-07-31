class Pagerduty
  class Incidents

    class Incident
      include Virtus.model

      attribute :id
      attribute :incident_number
      attribute :created_at
      attribute :status
      attribute :html_url
      attribute :incident_key
      attribute :service, Service
      attribute :escalation_policy, EscalationPolicy
      attribute :assignments, Array[Pagerduty::Incidents::Incident::Assignment]
      #attribute :trigger_summary_data, TriggerSummaryData
      #attribute :trigger_details_html_url
      #attribute :trigger_type
      #attribute :last_status_change_at
      #attribute :last_status_change_by, LastStatusChangeBy
      #attribute :number_of_escalations
      #attribute :resolved_by_user, ResolvedByUser
      attribute :urgency
    end

  end
end
