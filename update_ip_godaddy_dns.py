#!/usr/bin/env python3

import json
import os
import requests
import sys

cfg_file = os.path.expanduser("~/.godaddy-dns.json")
config = json.load(open(cfg_file, 'r'))


def get_wan_ip():
    return requests.get('https://api.ipify.org').text


def update_record(name, ip):
    url = f"https://api.godaddy.com/v1/domains/{config['domain']}/records/A/{name}"
    headers = {
        'Authorization': f"sso-key {config['api_key']}:{config['api_secret']}"
    }
    data = [
        {
            'name': name,
            'type': 'A',
            'data': ip,
            'ttl': 600
        }
    ]

    print(f"attempting to set {name} = {ip} in GoDaddy DNS")
    r = requests.put(url, headers=headers, json=data)
    
    try:
        r.raise_for_status()
    except requests.exceptions.HTTPError:
        print("updated failed:", r.text)
        sys.exit(1)

    print("update successful")

update_record(config['hostname'], get_wan_ip())
