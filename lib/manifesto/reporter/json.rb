module Manifesto
  class Reporter
    class Json < Reporter
      FORMAT = 'json'

      def full_report
        JSON.pretty_generate({
          :information => {
            :overview => self.class::HEADER,
            :generated_at => Time.now
          },

          :gems => gems
        })
      end
    end
  end
end
