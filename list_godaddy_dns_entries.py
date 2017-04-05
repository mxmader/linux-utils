#!/usr/bin/env python2

import json
import pprint
import os
import requests

cfg_file = os.path.expanduser("~/.godaddy-dns.json")
config = json.loads(open(cfg_file, 'r').read())

url = "https://api.godaddy.com/v1/domains/%s/records" % config['domain']
	
headers = {
	'Authorization':"sso-key %s:%s" % (config['api_key'], config['api_secret'])
}
	
r = requests.get(url, headers=headers)
	
if r.status_code == requests.codes.ok:
	pprint.pprint(json.loads(r.text))
else:
	print "failed: %s" % r.text
