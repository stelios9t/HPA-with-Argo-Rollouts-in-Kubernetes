#!/bin/bash
kubectl run -i --tty load-generator --rm \
  --image=busybox \
  -- /bin/sh -c "while true; do wget -q -O- http://cpu-app.default.svc.cluster.local:80/?cpu=200;done"