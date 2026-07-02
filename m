Return-Path: <linux-wireless+bounces-38484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IWbfApDgRWohGQsAu9opvQ
	(envelope-from <linux-wireless+bounces-38484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 05:52:48 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 313436F34EB
	for <lists+linux-wireless@lfdr.de>; Thu, 02 Jul 2026 05:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=r5nXFPWm;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38484-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38484-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8492302AD3E
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jul 2026 03:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F5634B1B0;
	Thu,  2 Jul 2026 03:52:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B053F346A0A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jul 2026 03:52:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782964365; cv=none; b=UFnx/D99WV1vf0uH0/u41CQ8c5qeOpp7Mnc+zUn7p/ziMg0jvaY3/52i6GuzvbNqu083DSXaHcEsTb4BgIfmJZGaf954lL39avj8Ctyc4QLOMqI3NtwY+TxVNAn0Gxdw6G8BefNuKAQ2v5KJ76PbozHTBwmbHDgDLiXUqzq4eLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782964365; c=relaxed/simple;
	bh=7ZcPijjc1RgbgAx4Q7izzYD4hi46U+2wPXK+U0WesyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iC/7nDZCc4J/xLyc2o+q9eixdRuEk9KPQYWbpRYwXdxr4Ch+wWZ2K32sJCp6l8VbIloM9OxocwQeV+MNsXc7A3+Qs6AxBAMk4F/tk0OEgQoK6dnSfk9V5gQNGs/AWp1iirYK7Z81nOVXYnlfgpMQxS44NvATVEPBrmXF/5ZXeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r5nXFPWm; arc=none smtp.client-ip=209.85.210.175
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-847a483e344so149537b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 20:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782964363; x=1783569163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTxIoT2T4MF8kQ0IhrOvAz2CYquvztawWB3Fq2L/RIo=;
        b=r5nXFPWmwBUBhb/SlXqZRAiAiFUOhYUC4m4Y0XTfonHmeAN5vX5vsCO9zcNbe4Y07u
         BGfzFDAkoAeIbHMUBXS8YR6U0ySTXMA+w1blOwHGhVP4D/EgWAKJWR3OUmve/hLIEn3l
         OFLn6D/l2RLr+ADtfjRZvXbQJdoO4r4YhD3PqJylZdkgFfcHIQjVvRGXFVs1ZLinUIFk
         SG/8kzaRxsLUoyIfWmD8+jMzhGEYZa/XSTlPt7WpY6aZ2UcjIEEa/AdDID1KpciPwyCh
         /tmU+FuZR1vkIAMCQtDruVeJ52KahC6uHcDglTBgFhoPTQBhmXbcj1RY04LiQt0AiqM5
         Jo7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782964363; x=1783569163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTxIoT2T4MF8kQ0IhrOvAz2CYquvztawWB3Fq2L/RIo=;
        b=ARTp9Ox6CI4ElaHi+3rG3U2fvjWCYLZKfTnjBrVGMvs4NotvTQlZXI+fORc5ucdQgg
         grceZyPMEsq0XMDx0BvVryCqtFj6Qnb0wdvb/izQMH5+0B5WXmpT+bKXK+8E+2BvQ36h
         YX5SbE0flb/AlrG8i3O353va7tU3r+axWan1V0Ta8OF12pBLZHcnJgZ0/5otX+rnclAT
         9n7rV4V7DBCVDdAVoz4wVOGmYCyfPTIVwUU1/qa8cn6ukzytn/oKLMqfEK+oLVObgUYT
         74RW+CZ7lrn10cboWKgn/GUNRN9VfOGqWBAwjy1u182DZMKGz1zV5IHILcExEoHhjDge
         uXGA==
X-Gm-Message-State: AOJu0YygeKoIBHZEqNDcn2lzZfxvuX7XGk97WHpl+LBtpyEe6UChXAoC
	23nRtzHXACwMECmx9RQYFAbmAKhWJklLemm7QzPv819j9VcljtQij0ac
X-Gm-Gg: AfdE7ck4Ds4u9fqaEr9T5RjVv3r1csz4Rh9JJrEFsW1Qm4DkG48ZbKb0kbcWwU9KbNA
	2lmmRAXqjM7ALWcAicbUrbjCtmEv86PzNm16yD1j0fxj72zP3hPmRO9Xqu3Y65kgxl/HVAsJ9Uq
	I9QZo97exVpvfPhNDxBmeL7wVxmQzW7t1HlRO9uDj29tDeWCv5zIUh9JSA7762VmUxMpq51KT+g
	HfNMxkbHfiS3LTnp1cu0BKNZlQTw1fPuKcAnKe1IoLP+1WTVYdZKHgHqaOaMWi2/uzRyTf/OXc8
	UtWfqNsyyhzuQynxaWcA+Be6Uj1e+fQk2zJb41LssWbTBxqVAParqY+YX1mn6WJ84b+2WLM1YSq
	VitZhCzokGbzPTIvLyHppkXScNwzOlmk39r/tNSEaOJOvPhRpajmoqYKinj2OeHLLRMadJjGorw
	tWmyAIfUTOgIaYRN9CBzYx2fE3eczMZF9B9xyEy2ZxoMN0O+pQkgjfe+iutDivXoc=
X-Received: by 2002:a05:6a00:f8c:b0:847:7cf2:a8ff with SMTP id d2e1a72fcca58-847a83566aamr7305698b3a.30.1782964362566;
        Wed, 01 Jul 2026 20:52:42 -0700 (PDT)
Received: from frank0988server (36-236-219-120.dynamic-ip.hinet.net. [36.236.219.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94bd7esm650121b3a.38.2026.07.01.20.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 20:52:42 -0700 (PDT)
From: Chun-Cheng Chang <frank0988855428@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chun-Cheng Chang <frank0988855428@gmail.com>
Subject: [PATCH v2] wifi: ath: avoid repeated divisions in DFS PRI detector
Date: Thu,  2 Jul 2026 03:52:36 +0000
Message-ID: <20260702035236.392328-1-frank0988855428@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701170424.380202-1-frank0988855428@gmail.com>
References: <20260701170424.380202-1-frank0988855428@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-38484-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[frank0988855428@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:frank0988855428@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frank0988855428@gmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 313436F34EB

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

Signed-off-by: Chun-Cheng Chang <frank0988855428@gmail.com>
---
Changes in v2:
- Use a known identity for the author and Signed-off-by tags.

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


