from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

DOCUMENTATION = """
  lookup: token
  author: Author
  options:
    base_url:
      type: string
      required: True
    username:
      type: string
      required: True
    password:
      type: string
      required: True
"""

from ansible.plugins.lookup import LookupBase
from ansible.utils.display import Display
from ansible.errors import AnsibleError
import requests

display = Display()

class LookupModule(LookupBase):
    def run(self, _terms, variables=None, **kwargs):
        self.set_options(var_options=variables, direct=kwargs)
        base_url=self.get_option('base_url')
        username=self.get_option('username')
        password=self.get_option('password')
        data = {
            "username": username,
            "password": password,
        }
        r = requests.post(f"{base_url}/api/v1/auth/login", json=data, verify=False)
        # retrieve cookies from session an return them
        if r.status_code != 200:
          raise AnsibleError(r.text)
        return [r.json()['access_token']]