.PHONY: genconfig apply diff encrypt decrypt

genconfig:
	talhelper genconfig -c talconfig.yaml

diff:
	talhelper genconfig -c talconfig.yaml --dry-run

apply:
	talhelper gencommand apply | bash

upgrade:
	talhelper gencommand upgrade | bash
