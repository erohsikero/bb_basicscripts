# bb_basicscripts
Personal Bug Bounty Basic scripts

Add these script as function in .bash_profile file to execute them as commnand whenever needed

Example : getalldns() { hostname=$(hostname) nslookup $hostname '0.0.0.0' }

Then we can call getalldns to execte the script
