=begin
 This class extends the original IPAddr with a number of functions. 
 * #address:
       returns the original address that the object was initialized with
 * #netmask:
       returns the netmask in ip notation
 * #prefix_length:
        returns the prefix length as an integer
=end
require 'ipaddr'
class IPAddress < IPAddr 
    def initialize(addr = '::', family = Socket::AF_UNSPEC)
        if !addr.kind_of?(String)
            case family
            when Socket::AF_INET, Socket::AF_INET6
                set(addr.to_i, family)
                @mask_addr = (family == Socket::AF_INET) ? IN4MASK : IN6MASK
                return
            when Socket::AF_UNSPEC
                raise AddressFamilyError, "address family must be specified"
            else
                raise AddressFamilyError, "unsupported address family: #{family}"
            end
        end
        prefix, prefixlen = addr.split('/')
        if prefix =~ /^\[(.*)\]$/i
            prefix = $1
            family = Socket::AF_INET6
        end
        # It seems AI_NUMERICHOST doesn't do the job.
        #Socket.getaddrinfo(left, nil, Socket::AF_INET6, Socket::SOCK_STREAM, nil,
        #                  Socket::AI_NUMERICHOST)
        @addr = @family = nil
        if family == Socket::AF_UNSPEC || family == Socket::AF_INET
            @addr = in_addr(prefix)
            if @addr
                @family = Socket::AF_INET
                @addr_org = @addr
            end
        end
        if !@addr && (family == Socket::AF_UNSPEC || family == Socket::AF_INET6)
            @addr = in6_addr(prefix)
            @family = Socket::AF_INET6
        end
        if family != Socket::AF_UNSPEC && @family != family
            raise AddressFamilyError, "address family mismatch"
        end
        if prefixlen
            mask!(prefixlen)
        else
            @mask_addr = (@family == Socket::AF_INET) ? IN4MASK : IN6MASK
        end
    end
    def netmask
        return self.clone.set(@mask_addr)
    end
    def prefix_length
        # without leading slash please!
        self.netmask.to_i.to_s(2).count("1")
    end
    def address
        return self.clone.set(@addr_org)
    end
end
