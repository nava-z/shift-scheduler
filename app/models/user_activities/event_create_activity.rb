class EventCreateActivity < UserActivity
    
    def href
      event_path event
    end

    def representation
      "You have successfully created the '#{event.event_name}' event."
    end
end