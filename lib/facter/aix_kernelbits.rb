#
#  FACT(S):     aix_kernelbits
#
#  PURPOSE:     This custom fact returns a simple string with the kernel
#		bit-size for this AIX system.
#
#  RETURNS:     (hash)
#
#  AUTHOR:      Chris Petersen, Crystallized Software
#
#  DATE:        July 16, 2021
#
#  NOTES:       Myriad names and acronyms are trademarked or copyrighted by IBM
#               including but not limited to IBM, PowerHA, AIX, RSCT (Reliable,
#               Scalable Cluster Technology), and CAA (Cluster-Aware AIX).  All
#               rights to such names and acronyms belong with their owner.
#
#-------------------------------------------------------------------------------
#
#  LAST MOD:    (never)
#
#  MODIFICATION HISTORY:
#
#       (none)
#
#-------------------------------------------------------------------------------
#
Facter.add(:aix_kernelbits) do
    #  This only applies to the AIX operating system
    confine :osfamily => 'AIX'

    #  Define an unfortunate value for our default return
    l_aixKernelBits = '(unknown)'

    #  Do the work
    setcode do
        #  Run the command to check the kernel bit length
        l_lines = Facter::Util::Resolution.exec('/usr/sbin/bootinfo -K 2>/dev/null')

        #  Loop over the lines that were returned
        l_lines && l_lines.split('\n').each do |l_oneLine|
            #  Strip leading and trailing whitespace 
            l_list          = l_oneLine.strip()
            l_aixKernelBits = l_list
        end

        #  Implicitly return the contents of the variable
        l_aixKernelBits
    end
end
