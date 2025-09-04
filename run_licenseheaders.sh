#! /bin/bash
##
## --------------------------------------------------------------------------------
## SPDX-FileCopyrightText: 2024 Martin Jan Köhler and Harald Pretl
## Johannes Kepler University, Institute for Integrated Circuits.
##
## This file is part of KPEX Documentation 
## (see https://github.com/iic-jku/klayout-pex-website).
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
## SPDX-License-Identifier: Apache-2.0
## --------------------------------------------------------------------------------
##

python3 -m licenseheaders \
	--tmpl .copyright.tmpl \
	--years "2024" \
	--owner "Martin Jan Köhler and Harald Pretl" \
	--projname "KPEX Documentation" \
	--projurl "https://github.com/iic-jku/klayout-pex-website" $*
