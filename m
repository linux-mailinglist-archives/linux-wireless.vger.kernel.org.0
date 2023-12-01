Return-Path: <linux-wireless+bounces-270-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C340800519
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 08:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16958281607
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 07:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBF012B78;
	Fri,  1 Dec 2023 07:56:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 23:56:19 PST
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7577310F8
	for <linux-wireless@vger.kernel.org>; Thu, 30 Nov 2023 23:56:19 -0800 (PST)
Received: by wens.tw (Postfix, from userid 1000)
	id C42865FC52; Fri,  1 Dec 2023 15:50:00 +0800 (CST)
Date: Fri, 1 Dec 2023 15:50:00 +0800
From: Chen-Yu Tsai <wens@csie.org>
To: Seth Forshee <sforshee@kernel.org>
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: [PATCH] wireless-regdb: Update keys and maintainer information
Message-ID: <ZWmQKG-KkSG0smGU@wens.tw>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As announced [1], I am taking over maintainership of the wireless
regulatory database.

Make it official by replacing the key and certificate, and updating
maintainership information in various places.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Makefile               |  2 +-
 debian-example/control |  2 +-
 sforshee.key.pub.pem   |  9 ---------
 sforshee.x509.pem      | 17 -----------------
 wens.key.pub.pem       |  9 +++++++++
 wens.x509.pem          | 17 +++++++++++++++++
 wireless-regdb.spec    |  2 +-
 7 files changed, 29 insertions(+), 29 deletions(-)
 delete mode 100644 sforshee.key.pub.pem
 delete mode 100644 sforshee.x509.pem
 create mode 100644 wens.key.pub.pem
 create mode 100644 wens.x509.pem

diff --git a/Makefile b/Makefile
index 02176ec..c99fcb6 100644
--- a/Makefile
+++ b/Makefile
@@ -34,7 +34,7 @@ REGDB_PRIVKEY ?= ~/.wireless-regdb-$(REGDB_AUTHOR).key.priv.pem
 REGDB_PUBKEY ?= $(REGDB_AUTHOR).key.pub.pem
 REGDB_PUBCERT ?= $(REGDB_AUTHOR).x509.pem
 
-REGDB_UPSTREAM_PUBKEY ?= sforshee.key.pub.pem
+REGDB_UPSTREAM_PUBKEY ?= wens.key.pub.pem
 
 REGDB_CHANGED = $(shell $(SHA1SUM) -c --status sha1sum.txt >/dev/null 2>&1; \
         if [ $$? -ne 0 ]; then \
diff --git a/debian-example/control b/debian-example/control
index e6e7161..3d186ee 100644
--- a/debian-example/control
+++ b/debian-example/control
@@ -12,4 +12,4 @@ Suggests: crda
 Description: The Linux wireless regulatory database
  This package contains the wireless regulatory database used by all
  cfg80211 based Linux wireless drivers. The wireless database being
- used is maintained by Seth Forshee.
+ used is maintained by Chen-Yu Tsai.
diff --git a/sforshee.key.pub.pem b/sforshee.key.pub.pem
deleted file mode 100644
index 73d580e..0000000
--- a/sforshee.key.pub.pem
+++ /dev/null
@@ -1,9 +0,0 @@
------BEGIN PUBLIC KEY-----
-MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtUDjnCiEOQPyOddmLEE4
-Fax+pYNxJX6QfGjdbz/Z11k4n3xqUsIDKi1+ZvQesxJwIFvUlzI9cYs7GwgXFGth
-xFeLlhYc/STVCwn5aBGE+8pRDNFFGdoQRIrZ/nap/WAtGAsolbIt6oiYuNFWIfBT
-H/ECb+lGm5NfKJAPrDb6aCNxV1b2zNPffSrZG3NF67onhe96f6XLgMcwNtJT7uys
-Hucx8TainGPGZVt/JXVooerTfgBcml7YIBgydwcpEmYeNnPnlwRBN7Gxciv0oSkg
-fJZ5CyvQ2N7IbD+T+8XueFIRFRt69uJomef7RhaE48eh5uDSRtXhxF+gZvTaxP+V
-HQIDAQAB
------END PUBLIC KEY-----
diff --git a/sforshee.x509.pem b/sforshee.x509.pem
deleted file mode 100644
index ebd0160..0000000
--- a/sforshee.x509.pem
+++ /dev/null
@@ -1,17 +0,0 @@
------BEGIN CERTIFICATE-----
-MIICpDCCAYwCCQCyjd9HrvnOpzANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhz
-Zm9yc2hlZTAgFw0xNzEwMDYxOTQwMzVaGA8yMTE3MDkxMjE5NDAzNVowEzERMA8G
-A1UEAwwIc2ZvcnNoZWUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC1
-QOOcKIQ5A/I512YsQTgVrH6lg3ElfpB8aN1vP9nXWTiffGpSwgMqLX5m9B6zEnAg
-W9SXMj1xizsbCBcUa2HEV4uWFhz9JNULCfloEYT7ylEM0UUZ2hBEitn+dqn9YC0Y
-CyiVsi3qiJi40VYh8FMf8QJv6Uabk18okA+sNvpoI3FXVvbM0999Ktkbc0XruieF
-73p/pcuAxzA20lPu7Kwe5zHxNqKcY8ZlW38ldWih6tN+AFyaXtggGDJ3BykSZh42
-c+eXBEE3sbFyK/ShKSB8lnkLK9DY3shsP5P7xe54UhEVG3r24miZ5/tGFoTjx6Hm
-4NJG1eHEX6Bm9NrE/5UdAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIcD2vKCwt2v
-fEQvhtNfTJNIuf4HF7sh9yUjTqoiDBa5c66dRnx12cNJV0e/M7eX7PVAdcBGIvCg
-XZx5E6H/uKMve44GP8i25Goo8jRcIz8ywOatD6zPVXRHc9MBhbcLIlYkfZ8JqQ6G
-njdbnG0C2YzIUGriWfMWBuqyQrVY/rrRgVca77I4iFj2qsQui1on5KXopMpnXKxy
-Z8NvE8MtNXnXiuf11CEwStX2o9l5VvIPEPd90FGTL0f4fUsKhFUSCn1OOx8rL/wo
-s2k04YCAu+KvudYw8R1UhyOZn1EDTEV9AmVzq/3PlMwNOmD9PBQvFjOpIR/LULGP
-A+6gZqkWeRQ=
------END CERTIFICATE-----
diff --git a/wens.key.pub.pem b/wens.key.pub.pem
new file mode 100644
index 0000000..7239de9
--- /dev/null
+++ b/wens.key.pub.pem
@@ -0,0 +1,9 @@
+-----BEGIN PUBLIC KEY-----
+MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqXoseE2nGS0yUqAubO+I
+fxXFtmlUFkMUeVO3roj+wLddR44a4e+zkIba02SBH85dnktuWAI+sm9eQkdB9Cy4
+qNSqwA7mSPCozssIrjev9kA5y1VvW0+FNOZpEFByXk6dTLo4Ng3OczjXJwIqeQPh
+rM+wJ4WGkxer7EJ3N2WKRMvWQpOSE+M5RcVuAEp/y0IXKyWMuBc7FTZZ3kLOIea2
+x25eJh/3ileepZZytwIy6wcrc+JPZlia6w8HtqtQi8OPF/oKmcIWJb8taxqq5j5f
+622bXU1Cgy05uMms2zqRUN+7sXZtFXP9xuZrcZ5nNiKDebHWuIRSr5Zbw2MCTnhw
+VwIDAQAB
+-----END PUBLIC KEY-----
diff --git a/wens.x509.pem b/wens.x509.pem
new file mode 100644
index 0000000..5fa4e44
--- /dev/null
+++ b/wens.x509.pem
@@ -0,0 +1,17 @@
+-----BEGIN CERTIFICATE-----
+MIICpzCCAY8CFGHAOGUaq9z5S9Csf/BsckjbGMYAMA0GCSqGSIb3DQEBCwUAMA8x
+DTALBgNVBAMMBHdlbnMwIBcNMjMxMjAxMDc0MTE0WhgPMjEyMzExMDcwNzQxMTRa
+MA8xDTALBgNVBAMMBHdlbnMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
+AQCpeix4TacZLTJSoC5s74h/FcW2aVQWQxR5U7euiP7At11Hjhrh77OQhtrTZIEf
+zl2eS25YAj6yb15CR0H0LLio1KrADuZI8KjOywiuN6/2QDnLVW9bT4U05mkQUHJe
+Tp1Mujg2Dc5zONcnAip5A+Gsz7AnhYaTF6vsQnc3ZYpEy9ZCk5IT4zlFxW4ASn/L
+QhcrJYy4FzsVNlneQs4h5rbHbl4mH/eKV56llnK3AjLrBytz4k9mWJrrDwe2q1CL
+w48X+gqZwhYlvy1rGqrmPl/rbZtdTUKDLTm4yazbOpFQ37uxdm0Vc/3G5mtxnmc2
+IoN5sda4hFKvllvDYwJOeHBXAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACQo7iJ0
+f3z6bB+zGNHCPX0pQoitgqWxigXQ7FyRIPaC/dVnYF8x9b2IkXC9uLmMiP5TyVSb
+Q8R6Q3Rr3bCxOzNFRnijHO9UaPeFnORRbwavgdsqe3tvqJxn2MvJkUAArtmhn92m
+Qw4oe6ob6YTbdmRCcMnA666EERZoToSefpI27hw7CGPreYQVCJ2vyJrHNNOUS9Eo
+l77RRXXcNWKsHR+3txWHyJjAJDFWje3bBsZGv0ttptWrzGD85Te2U31YlalWx/fu
+w6B292VNU/r/X3YzWgj6hpJaE/oa/PIbjH9Cbbd+t7Twx4O7ooEDLdQqYz/3MS5A
+M1xGvJvBBaVFTsM=
+-----END CERTIFICATE-----
diff --git a/wireless-regdb.spec b/wireless-regdb.spec
index bb648ca..b92fee4 100644
--- a/wireless-regdb.spec
+++ b/wireless-regdb.spec
@@ -16,7 +16,7 @@ BuildArch: noarch
 %description
 This package contains the wireless regulatory database used by all
 cfg80211 based Linux wireless drivers. The wireless database being
-used is maintained by Seth Forshee.
+used is maintained by Chen-Yu Tsai.
 http://wireless.kernel.org/en/developers/Regulatory/
 
 %prep
-- 
2.39.2


