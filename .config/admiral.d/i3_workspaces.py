#!/usr/bin/env python
# 
# Print i3 workspaces on a given output on every change.
# 
# Uses i3py.py -> https://github.com/ziberna/i3-py
# Based in wsbar.py en examples dir
#
# 16 feb 2015 - Electro7
# 20 nov 2016 - osense


import sys
import time
import subprocess
import yaml
from os.path import expanduser

import i3


# get color config from the themer
config = yaml.load(open(expanduser("~/.config/themer/current/colors.yaml"), "r"))


class i3ws(object):
    outputs = []
    
    def __init__(self, select_outputs):
        # socket
        self.socket = i3.Socket()
        # get our output
        outputs = self.socket.get('get_outputs')
        for output in outputs:
            if output['name'] in select_outputs:
                self.outputs += [output]
        if self.outputs == []:
            print('Couldn\'t find any of the desired outputs.')
            sys.exit(1)
        self.output_names = list(map(lambda x: x['name'], self.outputs))
        # Initial output to console
        workspaces = self.socket.get('get_workspaces')
        self.change(['change'], workspaces)
        # Subscribe to an event
        callback = lambda data, event, _: self.change(data, event)
        self.subscription = i3.Subscription(callback, 'workspace')
    
    def change(self, event, workspaces):
        # Receives event and workspace data
        if 'change' in event:
            text = self.format(workspaces)
            self.display(text)
    
    def format(self, workspaces):
        # Formats the text according to the workspace data given.
        out = '' 
        for workspace in workspaces:
            if workspace['output'] in self.output_names:
                name = workspace['name'].split(':')[1]
                if workspace['focused']:
                    out += '%{B' + config['primary'] + '}' + name + '%{B-}'
                else:
                    out += name
        return out
    
    def display(self, text):
        # Displays the text in stout
        print(text)
        sys.stdout.flush()
    
    def quit(self):
        # Quits the i3ws; closes the subscription and terminates
        self.subscription.close()

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Please specify list of outputs to monitor (e.g. \'HDMI1,HDMI2\').')
        sys.exit(1)
    ws = i3ws(sys.argv[1].split(','))
    try:
        while True:
            time.sleep(1)
    except KeyboardInterrupt:
        print('')  # force new line
    finally:
        ws.quit()
