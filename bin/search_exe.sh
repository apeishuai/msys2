#!/bin/bash
doc="C:/Users/whens/Nutstore/1/docs"
sed -n "${1}p" "$doc/GTD/search.org" | bash
