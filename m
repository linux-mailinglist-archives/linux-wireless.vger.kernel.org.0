Return-Path: <linux-wireless+bounces-38475-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9YaAE6VIRWow+AoAu9opvQ
	(envelope-from <linux-wireless+bounces-38475-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 19:04:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E09CA6F0222
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 19:04:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VAvdag3Y;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38475-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38475-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60B3730099A8
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 17:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956773859D3;
	Wed,  1 Jul 2026 17:04:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410BD385D85
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 17:04:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925474; cv=none; b=aXNR4ZbCfyMxtSI46L0tXmDuO/smyfVIWg+ClWFF19YRPE74KyXuyt2gdiKsK/fY0gLYI13gknO/6wx5OnzYMG7TS1zNr4Q+oj6c1aFbW0vkmByPrEJQ2ddv6XCothwwazm06SXdXSERadGM/A3lmIt96qm4TH2rX/J8EWtKmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925474; c=relaxed/simple;
	bh=VH/ALyBcsSqygKwEu36XmDFKJRtSPZTy2pSvI4Rqx5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPi/aEURqsvwAyia1DRzfg4Z/5ZFHc4zAl09QYVeiLC1mFba4wmZQKUsnmTvwImfKtmcnrLiuOX2Ew3Kx0NakvGTAOmbMTqfEBAERJJwUkaUG+28pXj9DCuA6WUQknRk1xw1q6V6QEVxbn9Ddg0iR5dffWAlODdLNnNIj7xr5uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAvdag3Y; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c9f44ddf26so4446745ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782925472; x=1783530272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+ZUF4ro0Ta5YnCSQJR+b4nsWho1JoPZ2BFLYN9d98A=;
        b=VAvdag3YSvXUkytdbM0wZWL8f82ynC4gGIUGjY9/cFwINEoPnPNCiRCVxK1ay+8AgN
         Q4TL6EP1uUFc8v0aVUUk7dcl3RAR9Dz9+FuO/nzRETBpgL6TDssyn2TtalSseGUOnx4A
         dH4pR4VtLy0ra1iSo4bko0xjG1fQxsUswm/+Fq5vBkt+IlxEsyXrXEIOFXRzWSG1FZW2
         dPk+6kWNrMzp9NZjXPyqcofNW1sD8rb7DeHdU4ynTL+tD3OQz8vtzmagnQGS+B9h6yKZ
         T7o0lAm/hW8KW4spdadFkQrdTRKPTY/zw3NRTglPvcCqvyT5kg0dDR7Kc638odIyYOlF
         uAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782925472; x=1783530272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+ZUF4ro0Ta5YnCSQJR+b4nsWho1JoPZ2BFLYN9d98A=;
        b=bqYe4MqantAiQwr45Vufdi6stBq/3G2U5t1P41avzSAqoBXD++DYgNoTO9UyXfvpeh
         boWufsZVxEe48nQrq8GaQ10UPyQUCp3wVbNSWHkTkLw1IHnEmgE4HgphtrXg8iGaNAXy
         HCFX9PKB8cPgiiJh24L+KYEDFqRmpScgfXJgSM6at/p6a41dC9dLEej+OenEZExLBIMy
         xymxhk7yf0NaOd4vtxjjGuyno1tUeRRCZUjoJgWBnm+idnWqrFUsLFCWcGYqWKN1QSeL
         Vz16pVvHAH1g7W4y6nUjaAnKHYyhcHvTnLAEmiv1wRsBgD2xrYwxy42pPjrNADkhLbyS
         vTAw==
X-Gm-Message-State: AOJu0YyzPv5BA7Y21yM1mJjxo97d3bR6XdH0Ca8p+iXcyEeBTBuIOt+o
	oi3TiT8f6E07rUHfdsNOwD2fLHleCJAFFiiVAxy8ogekIBrkPtU53J0NmCcoNYR1
X-Gm-Gg: AfdE7clxv8SIQCdH6KCtJIfStdt961RTQbeMRZJxwrrqKlpDDBxhFvMcHbHathzr1Ge
	7Axg1fB6DATUEj/JwJTw+KPYI5nU7UrMombCirQwGZ1BzMfrWVv4/wt5NOEyqpZluj5ccv3O2Ch
	IPzbnu4Ym2Ac8M1qkpUwcM/MIELYEUq7JVzOXXSWx9xC9L92kDkU9CGGiVHtfVDZKifL21vLtG/
	cJqtocSxY7hwcreECMoPvN0DLeTenCpN22uuM/aDgH4Cfug4Hq0nnRsSp8Xn4Iq0o68ktCKn+Iu
	ZBv7Vv0KllUCDk9keGCJ9hrBOszLff6OaYfLK7UbKsuVSvZUl4adREkypbu8CJ6NJevC5NEwtdI
	252+5R09dDnP+NyZfgFbkbOf7JUxhwS07xrQo0Wum3hrCosvLk+7JdGvJ+LCu6uox+5S5hoRts5
	9jgEmywLxNDh9bb/YFeR9YEGp/CUysxRUcpBlsSROx/V8Qf+xogQM5AS5V0w==
X-Received: by 2002:a17:902:f54d:b0:2c7:ef3b:e17f with SMTP id d9443c01a7336-2ca7e90957cmr27024605ad.36.1782925472469;
        Wed, 01 Jul 2026 10:04:32 -0700 (PDT)
Received: from frank0988server (36-236-213-2.dynamic-ip.hinet.net. [36.236.213.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8dae54sm1221315ad.17.2026.07.01.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:04:32 -0700 (PDT)
From: frank0988 <frank0988855428@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	frank0988 <frank0988855428@gmail.com>
Subject: [PATCH] wifi: ath: avoid repeated divisions in DFS PRI detector
Date: Wed,  1 Jul 2026 17:04:23 +0000
Message-ID: <20260701170424.380202-1-frank0988855428@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38475-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[frank0988855428@gmail.com,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:frank0988855428@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank0988855428@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E09CA6F0222

pde_get_multiple() is called repeatedly with the same PRI (Pulse
Repetition Interval) value while validating candidate and existing PRI
sequences.

Cache the reciprocal value for each sequence structure and leverage
reciprocal_divide() in the hot path. This keeps the existing matching
logic and tolerance checks intact while replacing expensive hardware
integer divisions with low-cost multiply-and-shift operations.

Testing with a userspace model of the same detector logic demonstrated
identical detector states and outputs across 100 verification traces.
To eliminate memory allocator noise, an isolated micro-benchmark using
a static object pool showed that the reciprocal variant reduces CPU
cycles by approximately 3.4%.

Signed-off-by: frank0988 <frank0988855428@gmail.com>
---
 drivers/net/wireless/ath/dfs_pri_detector.c | 14 +++++++++++---
 drivers/net/wireless/ath/dfs_pri_detector.h |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/dfs_pri_detector.c b/drivers/net/wireless/ath/dfs_pri_detector.c
index 388f9d1913bd..520fd1567a0b 100644
--- a/drivers/net/wireless/ath/dfs_pri_detector.c
+++ b/drivers/net/wireless/ath/dfs_pri_detector.c
@@ -16,6 +16,7 @@
 
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/reciprocal_div.h>
 
 #include "ath.h"
 #include "dfs_pattern_detector.h"
@@ -41,7 +42,9 @@ struct pulse_elem {
  * pde_get_multiple() - get number of multiples considering a given tolerance
  * Return value: factor if abs(val - factor*fraction) <= tolerance, 0 otherwise
  */
-static u32 pde_get_multiple(u32 val, u32 fraction, u32 tolerance)
+static u32 pde_get_multiple(u32 val, u32 fraction,
+			    struct reciprocal_value fraction_recip,
+			    u32 tolerance)
 {
 	u32 remainder;
 	u32 factor;
@@ -56,8 +59,8 @@ static u32 pde_get_multiple(u32 val, u32 fraction, u32 tolerance)
 		/* val and fraction are within tolerance */
 		return 1;
 
-	factor = val / fraction;
-	remainder = val % fraction;
+	factor = reciprocal_divide(val, fraction_recip);
+	remainder = val - factor * fraction;
 	if (remainder > tolerance) {
 		/* no exact match */
 		if ((fraction - remainder) <= tolerance)
@@ -247,6 +250,9 @@ static bool pseq_handler_create_sequences(struct pri_detector *pde,
 		ps.last_ts = ts;
 		ps.pri = GET_PRI_TO_USE(pde->rs->pri_min,
 			pde->rs->pri_max, ts - p->ts);
+		ps.pri_recip = (struct reciprocal_value){};
+		if (ps.pri)
+			ps.pri_recip = reciprocal_value(ps.pri);
 		ps.dur = ps.pri * (pde->rs->ppb - 1)
 				+ 2 * pde->rs->max_pri_tolerance;
 
@@ -261,6 +267,7 @@ static bool pseq_handler_create_sequences(struct pri_detector *pde,
 				break;
 			/* check if pulse match (multi)PRI */
 			factor = pde_get_multiple(ps.last_ts - p2->ts, ps.pri,
+						  ps.pri_recip,
 						  pde->rs->max_pri_tolerance);
 			if (factor > 0) {
 				ps.count++;
@@ -318,6 +325,7 @@ pseq_handler_add_to_existing_seqs(struct pri_detector *pde, u64 ts)
 
 		delta_ts = ts - ps->last_ts;
 		factor = pde_get_multiple(delta_ts, ps->pri,
+					  ps->pri_recip,
 					  pde->rs->max_pri_tolerance);
 		if (factor > 0) {
 			ps->last_ts = ts;
diff --git a/drivers/net/wireless/ath/dfs_pri_detector.h b/drivers/net/wireless/ath/dfs_pri_detector.h
index 86339f2b4d3a..c519466cff8b 100644
--- a/drivers/net/wireless/ath/dfs_pri_detector.h
+++ b/drivers/net/wireless/ath/dfs_pri_detector.h
@@ -18,6 +18,7 @@
 #define DFS_PRI_DETECTOR_H
 
 #include <linux/list.h>
+#include <linux/reciprocal_div.h>
 
 extern struct ath_dfs_pool_stats global_dfs_pool_stats;
 
@@ -25,6 +26,7 @@ extern struct ath_dfs_pool_stats global_dfs_pool_stats;
  * struct pri_sequence - sequence of pulses matching one PRI
  * @head: list_head
  * @pri: pulse repetition interval (PRI) in usecs
+ * @pri_recip: cached reciprocal value for PRI divisions
  * @dur: duration of sequence in usecs
  * @count: number of pulses in this sequence
  * @count_falses: number of not matching pulses in this sequence
@@ -35,6 +37,7 @@ extern struct ath_dfs_pool_stats global_dfs_pool_stats;
 struct pri_sequence {
 	struct list_head head;
 	u32 pri;
+	struct reciprocal_value pri_recip;
 	u32 dur;
 	u32 count;
 	u32 count_falses;
-- 
2.53.0


