#!/usr/local/bin/perl

# This program splits a large fasta file into a series of smaller files.  It takes as
# input a job ID and the machine name it is being run on (passed on the cmd line).
# It also communicates with the GeneConnect XML-RPC server.

# Author: Robert Freimuth, July 2006
# Washington University

use warnings;
use strict;

use Bio::SeqIO;
use Data::Dumper;
use File::Spec;
use Frontier::Client;
use Getopt::Long;

use GeneConnect::Config qw( get_config_params );
use GeneConnect::Params;
use SplitSeqFile 0.01 qw( split_file );

our $VERSION = 0.01;

#*****************************************************************************************

#print "Entering split_fasta_file.pl\n";

# parse job id and mach id from cmd line

my ( $job_id, $q_mgr, $machine_id );

GetOptions ( 'job_id=s' => \$job_id, 'qmgr=s' => \$q_mgr, 'mach_id=s' => \$machine_id );

print "Starting job ID $job_id on $machine_id\n";

# create a server object for contacting the XML RPC server

my $params_href = GeneConnect::Config::get_config_params();

my $server = Frontier::Client->new( 
									url   => join( '',
												   'http://', $params_href->{'server.IP'},
#												   $params_href->{'server.URL'},
											 	   ':', $params_href->{'server.port'},
											 	   '/RPC2' )
								   )
	or die "Error creating Frontier::Client object\n";
# SHOULDN'T DIE YET - MUST FREE MACHINE FIRST - CAN'T FREE MACHINE WITHOUT A CLIENT!


# call server to get params for this job and to set the machine id

#print "setting machine for $job_id to $machine_id\n";

my $mach_set = $server->call( 'set_machine_for_job_id', $job_id, $machine_id );

if( $mach_set ne $machine_id )
{
	warn "   ERROR - machine was set to $mach_set!\n";
}

#print "params for $job_id:\n";

my $params = $server->call( 'get_params_for_job_id', $job_id );

my $record = $server->call( 'get_record_for_job_id', $job_id );

my $working_dir = $record->{working_dir};

# split up the source fasta file into several smaller fasta files

my $infile = GeneConnect::Params::source_file( $params );
my $infile_path = GeneConnect::Params::path_source( $params );
my $num_seqs_per_file = GeneConnect::Params::config_num_seqs_per_job( $params );
my $inpathfile = File::Spec->catfile( $infile_path, $infile );

#print "splitting $infile:\n";

my @outfiles = SplitSeqFile::split_file( { infile => $inpathfile,
                                           infile_format => 'fasta',
                                           outpath => $working_dir,
                                           outfile_format => 'fasta',
                                           seqs_per_file => $num_seqs_per_file } );

my %split_files;

foreach my $filename ( @outfiles )
{
#	print "   $filename\n";
	$split_files{$filename} = { jobStatus => 'incomplete', path => $infile_path };
}

# call server to add the split files to the db, add new jobs to the pipeline queue,
# and free this machine when finished

#print "Updating database on the server\n";

$server->call( 'update_split_source_files', $job_id, \%split_files ) or
	warn "Error: unable to update status for $job_id\n";

print "Submitting alignment jobs to the server\n";

foreach my $filename ( keys %split_files )
{
	$server->call( 'do_alignments', { job_id => $job_id, seqfile => $filename } ) or
		warn "Error creating alignment job for $filename - skipping\n";

# errors should be logged and rerun
}

print "Job $job_id complete on $machine_id\n";

my $new_num_running = $server->call( 'job_done_on_machine', $machine_id, $q_mgr );

