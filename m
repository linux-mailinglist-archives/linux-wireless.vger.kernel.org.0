Return-Path: <linux-wireless+bounces-32399-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N70Cszwpmk/agAAu9opvQ
	(envelope-from <linux-wireless+bounces-32399-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 893AB1F17F7
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8290630FE609
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9FE3DA5D4;
	Tue,  3 Mar 2026 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="chb+fBJk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DD3822B7
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548009; cv=none; b=Dp//OWa1SCd/p6kqpFo1Y+UIpyYBTNgwGzBHXoRLxsW/EBR2hCoRp1tNPVYVFqQZUyfNqzbLSjNEi1qh3tJwJDwwvfIrczrwj1Z33e/456FNZX84rRSgQfmUPLo+A41/UD1rSixay2G5fRIw+jVcjdi0rjNiwLUQYpO9klDMe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548009; c=relaxed/simple;
	bh=pdA5IHVnxke4tLKlnKhBMieF/9GZEg5hfjxDD91+dpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eK3xyBxJouuaj5wPe4mJbxIUi3AaMxKGp6evGPx4Hh3D93tqSiTGQi9rceXzEmclXVzGlM1tdClfDpIC/mlt/SBqBFGjriWjH0EfqDbPFKS+d7n7dPWaoHqkkernAzLvRE8CYL85JJIu6YYVFnSHnYBnTdakHaAdXgKMPRsCgKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=chb+fBJk; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=K167Yc+DKK3bUIhP/u4EY2yq3NLRkJ+YL+YnaZhwNLE=;
	t=1772548007; x=1773757607; b=chb+fBJkb4naGwb4UtjX0RKm/46RG9Qq2yOBRNk4GYbAVNP
	alIY+6LY+JyU11lGcxS3D97SmNdaQ1zjncz2eupDgXC3RrQ1NOc6xM0wG4X32COuvI/YKpCK+4p1F
	WD5pdbtdWLbtWbBWXjVBQdSRqwiBpTEJ0kL20Dkw+WkSkDvLlLY7ag5gI+x5tlxoJsgqcJXe+u+uH
	zWAam64TMUsXQZMNkodlcsoNMKCwKO9pS2Uu/oTt1WsKSq+8rBKQzTIXsW2LDhFreKvRYpmHpATzh
	sJfYPuXs39xIolmnOst/ZR3CT70LdivvQ0AkEES7hqrUdbty7/DWIbkuXMSwM+1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQhw-000000079iZ-3lWq;
	Tue, 03 Mar 2026 15:26:45 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH wireless-next 1/3] wifi: mac80211: refactor chandef tracing macros
Date: Tue,  3 Mar 2026 15:26:17 +0100
Message-ID: <20260303152641.ca32d70055f8.I8138a31ceb75715d928d807554288baccc33cd8c@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303142641.273071-5-johannes@sipsolutions.net>
References: <20260303142641.273071-5-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 893AB1F17F7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32399-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

We don't need to duplicate the macros, just make a generic
one that gets the name prefix to be used, and use that to
create the others. While at it, add the puncturing bitmap
to the trace and simplify the ternary expressions.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/trace.h | 94 ++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 56 deletions(-)

diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index c04d4547e8f4..1f0c07eaad1b 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2,7 +2,7 @@
 /*
  * Portions of this file
  * Copyright(c) 2016-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018-2024, 2026 Intel Corporation
  */
 
 #if !defined(__MAC80211_DRIVER_TRACE) || defined(TRACE_HEADER_MULTI_READ)
@@ -37,64 +37,46 @@
 #define VIF_PR_FMT	" vif:%s(%d%s)"
 #define VIF_PR_ARG	__get_str(vif_name), __entry->vif_type, __entry->p2p ? "/p2p" : ""
 
-#define CHANDEF_ENTRY	__field(u32, control_freq)					\
-			__field(u32, freq_offset)					\
-			__field(u32, chan_width)					\
-			__field(u32, center_freq1)					\
-			__field(u32, freq1_offset)					\
-			__field(u32, center_freq2)
-#define CHANDEF_ASSIGN(c)							\
-			__entry->control_freq = (c) ? ((c)->chan ? (c)->chan->center_freq : 0) : 0;	\
-			__entry->freq_offset = (c) ? ((c)->chan ? (c)->chan->freq_offset : 0) : 0;	\
-			__entry->chan_width = (c) ? (c)->width : 0;			\
-			__entry->center_freq1 = (c) ? (c)->center_freq1 : 0;		\
-			__entry->freq1_offset = (c) ? (c)->freq1_offset : 0;		\
-			__entry->center_freq2 = (c) ? (c)->center_freq2 : 0;
-#define CHANDEF_PR_FMT	" chandef(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz)"
-#define CHANDEF_PR_ARG	__entry->control_freq, __entry->freq_offset, __entry->chan_width, \
-			__entry->center_freq1, __entry->freq1_offset, __entry->center_freq2
+#define __CHANDEF_ENTRY(n)								\
+			__field(u32, n##control_freq)					\
+			__field(u32, n##freq_offset)					\
+			__field(u32, n##chan_width)					\
+			__field(u32, n##center_freq1)					\
+			__field(u32, n##freq1_offset)					\
+			__field(u32, n##center_freq2)					\
+			__field(u16, n##punctured)
+#define __CHANDEF_ASSIGN(n, c)								\
+			__entry->n##control_freq = (c) && (c)->chan ?			\
+				(c)->chan->center_freq : 0;				\
+			__entry->n##freq_offset = (c) && (c)->chan ?			\
+				(c)->chan->freq_offset : 0;				\
+			__entry->n##chan_width = (c) ? (c)->width : 0;			\
+			__entry->n##center_freq1 = (c) ? (c)->center_freq1 : 0;		\
+			__entry->n##freq1_offset = (c) ? (c)->freq1_offset : 0;		\
+			__entry->n##center_freq2 = (c) ? (c)->center_freq2 : 0;		\
+			__entry->n##punctured = (c) ? (c)->punctured : 0;
+#define __CHANDEF_PR_FMT(n)								\
+	" " #n "(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz, punct:0x%x)"
+#define __CHANDEF_PR_ARG(n)								\
+			__entry->n##control_freq, __entry->n##freq_offset,		\
+			__entry->n##chan_width, __entry->n##center_freq1,		\
+			__entry->n##freq1_offset, __entry->n##center_freq2,		\
+			__entry->n##punctured
 
-#define MIN_CHANDEF_ENTRY								\
-			__field(u32, min_control_freq)					\
-			__field(u32, min_freq_offset)					\
-			__field(u32, min_chan_width)					\
-			__field(u32, min_center_freq1)					\
-			__field(u32, min_freq1_offset)					\
-			__field(u32, min_center_freq2)
+#define CHANDEF_ENTRY		__CHANDEF_ENTRY()
+#define CHANDEF_ASSIGN(c)	__CHANDEF_ASSIGN(, c)
+#define CHANDEF_PR_FMT		__CHANDEF_PR_FMT(chandef)
+#define CHANDEF_PR_ARG		__CHANDEF_PR_ARG()
 
-#define MIN_CHANDEF_ASSIGN(c)								\
-			__entry->min_control_freq = (c)->chan ? (c)->chan->center_freq : 0;	\
-			__entry->min_freq_offset = (c)->chan ? (c)->chan->freq_offset : 0;	\
-			__entry->min_chan_width = (c)->width;				\
-			__entry->min_center_freq1 = (c)->center_freq1;			\
-			__entry->min_freq1_offset = (c)->freq1_offset;			\
-			__entry->min_center_freq2 = (c)->center_freq2;
-#define MIN_CHANDEF_PR_FMT	" mindef(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz)"
-#define MIN_CHANDEF_PR_ARG	__entry->min_control_freq, __entry->min_freq_offset,	\
-			__entry->min_chan_width,					\
-			__entry->min_center_freq1, __entry->min_freq1_offset,		\
-			__entry->min_center_freq2
+#define MIN_CHANDEF_ENTRY	__CHANDEF_ENTRY(min)
+#define MIN_CHANDEF_ASSIGN(c)	__CHANDEF_ASSIGN(min, c)
+#define MIN_CHANDEF_PR_FMT	__CHANDEF_PR_FMT(mindef)
+#define MIN_CHANDEF_PR_ARG	__CHANDEF_PR_ARG(min)
 
-#define AP_CHANDEF_ENTRY								\
-			__field(u32, ap_control_freq)					\
-			__field(u32, ap_freq_offset)					\
-			__field(u32, ap_chan_width)					\
-			__field(u32, ap_center_freq1)					\
-			__field(u32, ap_freq1_offset)					\
-			__field(u32, ap_center_freq2)
-
-#define AP_CHANDEF_ASSIGN(c)								\
-			__entry->ap_control_freq = (c)->chan ? (c)->chan->center_freq : 0;\
-			__entry->ap_freq_offset = (c)->chan ? (c)->chan->freq_offset : 0;\
-			__entry->ap_chan_width = (c)->chan ? (c)->width : 0;		\
-			__entry->ap_center_freq1 = (c)->chan ? (c)->center_freq1 : 0;	\
-			__entry->ap_freq1_offset = (c)->chan ? (c)->freq1_offset : 0;	\
-			__entry->ap_center_freq2 = (c)->chan ? (c)->center_freq2 : 0;
-#define AP_CHANDEF_PR_FMT	" ap(%d.%03d MHz,width:%d,center: %d.%03d/%d MHz)"
-#define AP_CHANDEF_PR_ARG	__entry->ap_control_freq, __entry->ap_freq_offset,	\
-			__entry->ap_chan_width,						\
-			__entry->ap_center_freq1, __entry->ap_freq1_offset,		\
-			__entry->ap_center_freq2
+#define AP_CHANDEF_ENTRY	__CHANDEF_ENTRY(ap)
+#define AP_CHANDEF_ASSIGN(c)	__CHANDEF_ASSIGN(ap, c)
+#define AP_CHANDEF_PR_FMT	__CHANDEF_PR_FMT(ap)
+#define AP_CHANDEF_PR_ARG	__CHANDEF_PR_ARG(ap)
 
 #define CHANCTX_ENTRY	CHANDEF_ENTRY							\
 			MIN_CHANDEF_ENTRY						\
-- 
2.53.0


