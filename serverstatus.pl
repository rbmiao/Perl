#!/usr/bin/perl
# This is a Perl script for checking whether ports(:20,:80, :2222) on remote server are working. 
# Port:2222 should not be good.
# It runs around 60 seconds and stop after that.
#
# Author: Rongbing Miao
# Date: 12/09/2014
# 
use strict;
use IO::Socket;
my @servers;

$servers[0]=['104.236.33.124',2222];
$servers[1]=['104.236.33.124',22];
$servers[2]=['104.236.33.124',80];

my $i=0;
my $interval=3;
my $count=int(60/$interval);

while($i < $count){
	foreach (@servers){
		if(fetch_server_status(@$_)){
			print $$_[0] . ':' . $$_[1] ."ok\n";
		}else{
			print $$_[0] . ':' . $$_[1] ."bad\n";
		}
	}
	$i++;

	sleep $interval;
}

sub fetch_server_status(){
	my($ip,$port)=@_;
	my $socket=IO::Socket::INET->new(
		PeerAddr => $ip,
		PeerPort => $port,
		Timeout => 1,
		);
		if(!$socket){
			return 0;
		}else{
			return 1;
	}
	$socket->close;
}
