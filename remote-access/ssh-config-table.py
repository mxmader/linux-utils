#!/usr/bin/env python2

from prettytable import PrettyTable
from storm import ConfigParser
import os

my_ssh_config = os.path.expanduser('~/.ssh/config')

my_ssh_config_data = ConfigParser(my_ssh_config).load()

data = []
table = PrettyTable()
table.field_names = ['SSH Host', 'Hostname/IP', 'Key']
table.align['SSH Host'] = 'l'
table.align['Hostname/IP'] = 'l'
table.align['Key'] = 'l'

for entry in my_ssh_config_data:
    if entry['type'] == 'entry':
        table.add_row([
            entry['host'],
            entry['options']['hostname'] if 'hostname' in entry['options'] else '',
            entry['options']['identityfile'] if 'identityfile' in entry['options'] else ''
        ])

print table
