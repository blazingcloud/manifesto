module Manifesto
  class Reporter
    class Markdown < Reporter
      FORMAT = 'md'

      def header
        str = "# Licence Manifesto\n\n"
        str << super
        str << "***\n"
      end

      def print_gem gem_name, info
        str = "## #{gem_name}, version #{info['version']}, #{info['licenses'].size} license(s):\n"
        info['licenses'].each_with_index do |license, i|
          str << "#{license['body']}\n"
          str << "***\n"
        end
        str << "***\n"
        str
      end
    end
  end
end
