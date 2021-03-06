class Pagerduty
  class Incidents
    class Incident
      include Pagerduty::Core

      def initialize(options={})
        super
        @@subdomain = Pagerduty.class_variable_get(:@@subdomain)
      end

      def inspect
        puts "<Pagerduty::#{self.class}"
        self.attributes.each { |attr,val| 
          puts "\t#{attr}=#{val.class == Class ? "BLOCK" : val.inspect}"
        }
        puts ">"

        self.attributes
      end

      def notes
        Notes.new(curl({
          uri: "https://api.pagerduty.com/incidents/#{self.id}/notes",
          method: 'GET'
        }))
      end

      def acknowledge(email)
        curl_with_headers({
          uri: "https://api.pagerduty.com/incidents",
          data: {
            incidents: [
              {
                id:self.id,
                status:'acknowledged',
                type: 'incident_reference'
              }
            ]
          },
          method: 'PUT'
        },
        {
          "Content-Type" => "application/json",
          "Authorization" => "Token token=#{Pagerduty.class_variable_get(:@@token)}",
          "Accept" => "application/vnd.pagerduty+json;version=2",
          "From" => email
        })
      end

      def resolve(email)
        print("resolving")
        curl_with_headers({
          uri: "https://api.pagerduty.com/incidents",
          data: {
            incidents: [
              {
                id:self.id,
                status:'resolved',
                type: 'incident_reference'
              }
            ]
          },
          method: 'PUT'
        },
        {
          "Content-Type" => "application/json",
          "Authorization" => "Token token=#{Pagerduty.class_variable_get(:@@token)}",
          "Accept" => "application/vnd.pagerduty+json;version=2",
          "From" => email
        })
      end

      def reassign(options={})
        curl({
          uri: "https://#@@subdomain.pagerduty.com/api/v1/incidents/#{self.id}/resolve",
          data: { 'requester_id' => self.assigned_to_user.id, }.merge(options),
          method: 'PUT'
        })
      end
      
      self.instance_eval do
        %w(triggered open acknowledged resolved).each do |status|
          define_method("#{status}?") { self.status == "#{status}" }
        end
      end


      def log_entries(options={})
        LogEntries.new(curl({
          uri: "https://#@@subdomain.pagerduty.com/api/v1/incidents/#{self.id}/log_entries",
          params: options,
          method: 'GET'
        }))
      end

    end
  end
end
