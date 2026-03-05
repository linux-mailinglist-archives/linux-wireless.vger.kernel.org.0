Return-Path: <linux-wireless+bounces-32574-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOR8M/39qWk1JQEAu9opvQ
	(envelope-from <linux-wireless+bounces-32574-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 23:04:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC33218C16
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 23:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EA49300A587
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772CB30EF92;
	Thu,  5 Mar 2026 22:04:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F663612E8
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 22:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772748280; cv=none; b=F+F+pXNsqDtt4X/sfhVViSkGyABWVJD7co2r04XlsxGENhJS9n1Hggx39kxLVFY8I6iWN2B1EpBw1n2XqKmk3MoFLo5l1YsTz9iIYi3+zk+WaL3WwYyOK5S0xnZuHFSgontAx9QGVGzxEn+T0Q1feFgD9TWdTs5hvsJC/+B1gAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772748280; c=relaxed/simple;
	bh=JrInGjWfOAbn+j0gWU0hP+d+DL2wpu36d28HiREU7z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5ysNigRUTlNydUnJr8h0jms+TQLsigpf9nO+hG3TfLHpxFP5TP4kvWAWX8KAHffo1BFvcROyzE25GCJcXI+HAmyfwp2sGgTU6QJCFfyM2Gsx0RNUFwrKlvhAyS5ypsM9aqZat4De+O/ilnQBMj2n8gUYukpou3wEXKdSsV4uTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Received: from eig-obgw-5005b.ext.cloudfilter.net ([10.0.29.189])
	by cmsmtp with ESMTPS
	id yAMsvgRzVVCBNyGo8v6OWW; Thu, 05 Mar 2026 22:04:37 +0000
Received: from host2044.hostmonster.com ([67.20.76.238])
	by cmsmtp with ESMTPS
	id yGo0vwoGsjAxuyGo0vYvCK; Thu, 05 Mar 2026 22:04:28 +0000
X-Authority-Analysis: v=2.4 cv=EoDSrTcA c=1 sm=1 tr=0 ts=69a9fdf4
 a=O1AQXT3IpLm5MaED65xONQ==:117 a=uc9KWs4yn0V/JYYSH7YHpg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=z6gsHLkEAAAA:8 a=4b9QysbXAAAA:8
 a=stkexhm8AAAA:8 a=EUspDBNiAAAA:8 a=cH6R9-kdAAAA:8 a=P9KAhAPrZ2691IDrLaYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RVmHIydaz68A:10
 a=kpqFwAh5LKmhuRUZV80P:22 a=pIW3pCRaVxJDc-hWtpF8:22 a=iekntanDnrheIxGr1pkv:22
Received: from [66.118.46.62] (port=40748 helo=timdesk..)
	by host2044.hostmonster.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <tim.bird@sony.com>)
	id 1vyGnz-00000003eKc-2yWy;
	Thu, 05 Mar 2026 15:04:27 -0700
From: Tim Bird <tim.bird@sony.com>
To: johannes@sipsolutions.net,
	andy@warmcat.com,
	lrodriquez@atheros.com,
	beni.lev@intel.com
Cc: tim.bird@sony.com,
	linux-wireless@vger.kernel.org,
	linux-spdx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] wifi: radiotap: Add SPDX ids to files in the wireless subsystem
Date: Thu,  5 Mar 2026 15:04:21 -0700
Message-ID: <20260305220422.24161-1-tim.bird@sony.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host2044.hostmonster.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - sony.com
X-BWhitelist: no
X-Source-IP: 66.118.46.62
X-Source-L: No
X-Exim-ID: 1vyGnz-00000003eKc-2yWy
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (timdesk..) [66.118.46.62]:40748
X-Source-Auth: tim@bird.org
X-Email-Count: 3
X-Org: HG=bhshared_hm;ORG=bluehost;
X-Source-Cap: YmlyZG9yZztiaXJkb3JnO2hvc3QyMDQ0Lmhvc3Rtb25zdGVyLmNvbQ==
X-Local-Domain: no
X-CMAE-Envelope: MS4xfJUUAZVX8IpE8on2zf29KIbXNC0HgOM9qiDmlmsHbF2kHkBpvrl6S64X0VECKPkHOzvIFeqAG6M5DP4RB6Vh4kwFdWJCYFHMuvPirQx63Eeau66KDlu2
 A98a9fNiOA6kddyCejF1KK3EFdUXwYJ7ePpN+D4jnh6+Kh0Bp67QttoLE6/0JXOz73Z1fNRK6KVh6R69wORcPSb16TuSFD0L9ms=
X-Rspamd-Queue-Id: CFC33218C16
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[sony.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_X_ANTIABUSE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_X_SOURCE(0.00)[];
	TAGGED_FROM(0.00)[bounces-32574-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tim.bird@sony.com,linux-wireless@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,sipsolutions.net:email,milecki.pl:email]
X-Rspamd-Action: no action

Add SPDX-License-Identifier lines to some files where
they are missing in the net/wireless directory.
Remove licensing text from individual files headers (where
present) to canonicalize the library references.

Use (mostly) either GPL-2.0 or ISC, depending on the
license wording (or not) in the files.

radiotap.c does not mention which BSD variant it intends for the
license.  My selection of 'OR BSD-2-Clause' for radiotap.c was
based on research into this code's history and its licensing
elsewhere.  In OpenBSD, radiotap code (which likely either
derived from this code, or this code was derived from) has the
BSD-2-Clause license.  Very similar code in the radiotap library
user space tool, by the same authors Andy Green and Johannes
Berg, has an ISC license. Also the ISC license is used by
Johannes for other contributions in the Linux wireless system.
Since the radiotap.c license text here mentions BSD, but not a
specific version, I chose the closest BSD variant to ISC, which
is BSD-2-Clause.

Signed-off-by: Tim Bird <tim.bird@sony.com>
---
Note that the ISC license says it must be retained, but we
count the file in LICENSES/deprecated/ISC as retention of
'this permission notice', for Linux source.
---
 net/wireless/of.c        | 13 +------------
 net/wireless/radiotap.c  | 10 +---------
 net/wireless/reg.c       | 13 +------------
 net/wireless/reg.h       | 13 +------------
 net/wireless/trace.c     |  1 +
 net/wireless/wext-core.c |  3 +--
 net/wireless/wext-priv.c |  3 +--
 net/wireless/wext-proc.c |  3 +--
 8 files changed, 8 insertions(+), 51 deletions(-)

diff --git a/net/wireless/of.c b/net/wireless/of.c
index 60a864465331..99acbea3beee 100644
--- a/net/wireless/of.c
+++ b/net/wireless/of.c
@@ -1,17 +1,6 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright (C) 2017 Rafał Miłecki <rafal@milecki.pl>
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 #include <linux/of.h>
diff --git a/net/wireless/radiotap.c b/net/wireless/radiotap.c
index c85eaa583a46..df29048a0449 100644
--- a/net/wireless/radiotap.c
+++ b/net/wireless/radiotap.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
  * Radiotap parser
  *
  * Copyright 2007		Andy Green <andy@warmcat.com>
  * Copyright 2009		Johannes Berg <johannes@sipsolutions.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * Alternatively, this software may be distributed under the terms of BSD
- * license.
- *
- * See COPYING for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 1c5c38d18feb..20bba7e491c5 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: ISC
 /*
  * Copyright 2002-2005, Instant802 Networks, Inc.
  * Copyright 2005-2006, Devicescape Software, Inc.
@@ -6,18 +7,6 @@
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright      2017  Intel Deutschland GmbH
  * Copyright (C) 2018 - 2026 Intel Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 
diff --git a/net/wireless/reg.h b/net/wireless/reg.h
index e1b211c4f75c..fc31c5f9a61a 100644
--- a/net/wireless/reg.h
+++ b/net/wireless/reg.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: ISC */
 #ifndef __NET_WIRELESS_REG_H
 #define __NET_WIRELESS_REG_H
 
@@ -6,18 +7,6 @@
 /*
  * Copyright 2008-2011	Luis R. Rodriguez <mcgrof@qca.qualcomm.com>
  * Copyright (C) 2019, 2023 Intel Corporation
- *
- * Permission to use, copy, modify, and/or distribute this software for any
- * purpose with or without fee is hereby granted, provided that the above
- * copyright notice and this permission notice appear in all copies.
- *
- * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
- * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
- * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
- * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
- * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
- * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
 enum ieee80211_regd_source {
diff --git a/net/wireless/trace.c b/net/wireless/trace.c
index 95f997fad755..7cb93acf1a8f 100644
--- a/net/wireless/trace.c
+++ b/net/wireless/trace.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 
 #ifndef __CHECKER__
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 7b8e94214b07..c19dece2bc6e 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file implement the Wireless Extensions core API.
  *
@@ -5,8 +6,6 @@
  * Copyright (c) 1997-2007 Jean Tourrilhes, All Rights Reserved.
  * Copyright	2009 Johannes Berg <johannes@sipsolutions.net>
  * Copyright (C) 2024 Intel Corporation
- *
- * (As all part of the Linux kernel, this file is GPL)
  */
 #include <linux/kernel.h>
 #include <linux/netdevice.h>
diff --git a/net/wireless/wext-priv.c b/net/wireless/wext-priv.c
index 37d1147019c2..ce9022843dfd 100644
--- a/net/wireless/wext-priv.c
+++ b/net/wireless/wext-priv.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file implement the Wireless Extensions priv API.
  *
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
  * Copyright (c) 1997-2007 Jean Tourrilhes, All Rights Reserved.
  * Copyright	2009 Johannes Berg <johannes@sipsolutions.net>
- *
- * (As all part of the Linux kernel, this file is GPL)
  */
 #include <linux/slab.h>
 #include <linux/wireless.h>
diff --git a/net/wireless/wext-proc.c b/net/wireless/wext-proc.c
index cadcf8613af2..be6b2b695bf9 100644
--- a/net/wireless/wext-proc.c
+++ b/net/wireless/wext-proc.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file implement the Wireless Extensions proc API.
  *
  * Authors :	Jean Tourrilhes - HPL - <jt@hpl.hp.com>
  * Copyright (c) 1997-2007 Jean Tourrilhes, All Rights Reserved.
- *
- * (As all part of the Linux kernel, this file is GPL)
  */
 
 /*
-- 
2.43.0


