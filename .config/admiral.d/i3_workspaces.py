#!/usr/bin/env python
# 
# Print i3 workspaces on a given output on every change.
# 
# Uses i3ipc -> https://github.com/acrisci/i3ipc-python
# Based in wsbar.py en examples dir
#
# 16 feb 2015 - Electro7
# 20 nov 2016 - osense
# 26 may 2019 - osense (migration i3py.py -> i3ipc)


import sys
from functools import partial

import i3ipc


def on_change(output_names, i3, event):
    ws = i3.get_workspaces()
    text = format(output_names, ws)
    display(text)

def format(output_names, workspaces):
    # Formats the text according to the workspace data given.
    out = '' 
    for workspace in workspaces:
        if workspace['output'] in output_names:
            name = workspace['name'].split(':')[1]
            if workspace['focused']:
                out += '%{R}' + name + '%{R}'
            else:
                out += name
    return out

def display(text):
    # Displays the text in stout
    print(text)
    sys.stdout.flush()


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Please specify list of outputs to monitor (e.g. \'HDMI1,HDMI2\').')
        sys.exit(1)
    in_outputs = sys.argv[1].split(',')
    # socket
    i3 = i3ipc.Connection()
    # get our output
    outputs = i3.get_outputs()
    selected_outputs = []
    for output in outputs:
        if output['name'] in in_outputs:
            selected_outputs += [output]
    if selected_outputs == []:
        print('Couldn\'t find any of the desired outputs.')
        sys.exit(1)
    output_names = list(map(lambda x: x['name'], selected_outputs))
    # Initial output to console
    #workspaces = self.socket.get('get_workspaces')
    on_change(output_names, i3, 0)
    # Subscribe to an event
    i3.on('workspace::focus', partial(on_change, output_names))

i3.main()
