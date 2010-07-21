module RoutingFilter
  class Chain < Array
    def <<(filter)
      filter.previous, last.next = last, filter if last
      super
    end
    
    def run(method, *args, &final)
      active? ? first.run(method, *args, &final) : final.call
    end

    def run_reverse(method, *args, &final)
      active? ? last.run_reverse(method, *args, &final) : final.call
    end
    
    def active?
      RoutingFilter.active && !empty?
    end
  end
end