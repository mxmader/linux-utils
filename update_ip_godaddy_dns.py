#!/usr/bin/env python2

import json
import os
import requests

cfg_file = os.path.expanduser("~/.godaddy-dns.json")
config = json.loads(open(cfg_file, 'r').read())


def get_wan_ip():
    return requests.get('https://api.ipify.org').text


def update_record(name, ip):

    url = "https://api.godaddy.com/v1/domains/%s/records/A/%s" % (config['domain'], name)

    headers = {
        'Authorization': "sso-key %s:%s" % (config['api_key'], config['api_secret'])
    }

    data = [
        {
            'name': name,
            'type': 'A',
            'data': ip,
            'ttl': 600

        }
    ]

    r = requests.put(url, headers=headers, json=data)

    if r.status_code == requests.codes.ok:
        print "update success: %s = %s" % (name, ip)
    else:
        print "update failed: %s = %s: %s" % (name, ip, r.text)

update_record(config['hostname'], get_wan_ip())
