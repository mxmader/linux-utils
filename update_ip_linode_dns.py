#!/usr/bin/env python2

import json
import requests
import os
import sys

settings = json.loads(open(os.path.expanduser('~') + "/.linode", 'r').read())

# figure out our internet-facing IP
r = requests.get('https://api.ipify.org', params={'format':'json'})

ip = json.loads(r.text)['ip']

print ip

params = {
    'api_key': settings['api_key'],
    'api_action': 'domain.resource.update',
    'DomainID': settings['domain_id'],
    'ResourceID': settings['resource_id'],
    'Target': ip
}

r = requests.post('https://api.linode.com', params=params)
print r.text
