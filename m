Return-Path: <linux-wireless+bounces-38128-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IOWFF0EePmoqAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38128-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:37:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C22B66CAB0A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:37:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=vTVXu3JF;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38128-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38128-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A66E3117836
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F833DB630;
	Fri, 26 Jun 2026 06:32:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010773DB623
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:32:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455538; cv=none; b=m41EFthO8WA9hXVy+boyRhYI522ksQbTWkOY7o6uibk6iozTPJfmm5tyFpnZMuNeFHCW6uX6H2toqI6xN14cVg4iRI3TdjWi5SFF91VOvL3QHz7IoO7AqJzdXVC3r5RLwMDUMgOyRFwQbJq/mQjVibobAFehwlXZRgJEVdHEXxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455538; c=relaxed/simple;
	bh=nx8znFHMnN4w6de2ORtL3EGc29IYsmftmtC12W6qYkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iza13pNr36a9bGb+Xz956nggaAw4TMEARNgcVc+sK+dtWYiyiZmNwLfMyprRYSfVNWY5Twteyik5RQke1OyHKAvqkFoRP0En3SnjUjME18IGCQXHwGoOLYFN0howqFPU97aFxMeqPMP0skXJB0bUzK66q4MHo+g72uyZKjF9r2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=vTVXu3JF; arc=none smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137dd4cc208so558282c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455536; x=1783060336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz86oTPiFHAFQUmI4yB6b7p+nYeeXkr4CFNcmx4onbk=;
        b=vTVXu3JFvsNe31GGDT5SUa53Wr198urM1FdA2tlYRonXH0CamRdl7zevJW05fMoMNI
         7aQFRctCMeyjC+iHpQCL04pUgN4ilMlqtPOPX3eek8wghEkCMlWNAvuTpgy7VQWXi9s8
         Cysw3nNxKZ4CqwP0KkYOPiP3HfX66ZF1Id9ncj/6xe7jndZk0qfHp+7SCqrgiT87Ckhs
         p2sbo1tIZ3Bugu3cxPsrmE4doserPBpEm0aD9auh/zuNSW06/izzU5dDDUyYII3IDoa9
         eygBYIodFxhJYZMh2n1wx5ghtx/jPRCRzsL5R8MN/9HmnZc7L+ieyciAgSNNivFrpP26
         4uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455536; x=1783060336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zz86oTPiFHAFQUmI4yB6b7p+nYeeXkr4CFNcmx4onbk=;
        b=iZ81JVZOvw+YX3v9nrDH2ypDettP2sI9+jMCtnsmPzfOJTkXcYyUe4NfLsWqWvUxdE
         yoeqzqR7T3nIBFLrIPI+YSePp6gMJdtl7wzoP+mQN0c0V8yG/9dHDOHA0V7Tg6ksgdaE
         6mQsVuGhJKDE1dnkI0xQRQ3UqhH2QOytrcfpLWzyeDoq2zb99tXfSVtrJuaF3yE//Hqd
         q9NTZBRiElhZUAzRT6KtL8plhxRxg6PFz6rDsPEwRARqi/wREFKIgjzxRvAJrkuvCZRs
         HFgVC60NkifIBk1rioz03PjEn8Llj0rIKBaq7ingcc/jB6WeqCPsp7f1bG/HxDSCFYqJ
         O3+w==
X-Forwarded-Encrypted: i=1; AFNElJ/ev0W9L1fD0QqSLohA1M3xkQ3+iVg31qfYznfvxU6vk8EWj5wyPgRc7Ly1PynXNU2pZo2SOlJBNt/vuc5Fvw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq+5g/21o551ukh35cqjj8ohwhvNk9FcGfXjQ+QOv8LcZfydv/
	jK+77LRLaxU/FVtvhjQXOYC1sRBJ4vheUhsOaHh8Tna98uidw39YaX73FG+tXy2QueY=
X-Gm-Gg: AfdE7cmUdjGh1edaGxFXsy+9e2pCWwGe6cW0uJy5ocpdLJq3vnD3hKcKmXdcG6ZLpOn
	qE6HJReTFglXN5mmHl70KtCqQVQReZRBFx5rTOqEGDHz2Xk/B5zGUZ6yyXZtk8wdcIpoWiLKyXG
	0vme1Qxjf5bPyUPGljYCUHGgtFmKTxlQXGGZ54JZMSrFQIHlbcbx6XgiquPMh4WptwB8GCG6k1Q
	iTU2xv7wU7Qkmrlf+4DxGWoNuJ45E24yYBk0jw6yB1K6mZqRdLHO7bxxflPsktQMMQWWYjzJkHa
	lVVsD8Z+1IhGgWUBQpTNE4Ovc5gBcHdoKiYNrlUTTaIQTBvxJF8bLWLuhTnPChGQgTBlI9061qx
	VjB0ifYa/ChCEowc3n7goCFCuwIaYvR0Sp6NH4fo/qSflbuxh35zD/tmT4BZyVdWrgwUl5SxxUn
	Xd9qC/cWjiJVvvj1nxojEq1bD2TjM6ebGrHZ6+6Egkz50UwW9jhX2cY2NV5rlh4vbVPEXF56/Y1
	EnXpnjvdep/Kydaqqn1
X-Received: by 2002:a05:701b:2314:b0:139:e17f:3bf1 with SMTP id a92af1059eb24-139e17f3f88mr1811326c88.8.1782455536054;
        Thu, 25 Jun 2026 23:32:16 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.32.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:15 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 17/33] wifi: mm81x: add mmrc.h
Date: Fri, 26 Jun 2026 16:29:13 +1000
Message-ID: <20260626063014.1275235-18-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38128-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C22B66CAB0A

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/mmrc.h | 193 +++++++++++++++++++
 1 file changed, 193 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mmrc.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/mmrc.h b/drivers/net/wireless/morsemicro/mm81x/mmrc.h
new file mode 100644
index 000000000000..a4c7d941ad55
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/mmrc.h
@@ -0,0 +1,193 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_MMRC_H_
+#define _MM81X_MMRC_H_
+
+#include <linux/version.h>
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/random.h>
+#include <linux/time.h>
+
+/* The max length of a retry chain for a single packet transmission */
+#define MMRC_MAX_CHAIN_LENGTH 4
+
+/* Rate minimum allowed attempts */
+#define MMRC_MIN_CHAIN_ATTEMPTS 1
+
+/* Rate upper limit for attempts */
+#define MMRC_MAX_CHAIN_ATTEMPTS 2
+
+/* The frequency of MMRC stat table updates */
+#define MMRC_UPDATE_FREQUENCY_MS 100
+
+enum mmrc_flags {
+	MMRC_FLAGS_CTS_RTS,
+};
+
+enum mmrc_mcs_rate {
+	MMRC_MCS0,
+	MMRC_MCS1,
+	MMRC_MCS2,
+	MMRC_MCS3,
+	MMRC_MCS4,
+	MMRC_MCS5,
+	MMRC_MCS6,
+	MMRC_MCS7,
+	MMRC_MCS8,
+	MMRC_MCS9,
+	MMRC_MCS10,
+	MMRC_MCS_UNUSED,
+};
+
+enum mmrc_bw {
+	MMRC_BW_1MHZ = 0,
+	MMRC_BW_2MHZ = 1,
+	MMRC_BW_4MHZ = 2,
+	MMRC_BW_8MHZ = 3,
+	MMRC_BW_16MHZ = 4,
+	MMRC_BW_MAX = 5,
+};
+
+enum mmrc_spatial_stream {
+	MMRC_SPATIAL_STREAM_1 = 0,
+	MMRC_SPATIAL_STREAM_2 = 1,
+	MMRC_SPATIAL_STREAM_3 = 2,
+	MMRC_SPATIAL_STREAM_4 = 3,
+	MMRC_SPATIAL_STREAM_MAX,
+};
+
+enum mmrc_guard {
+	MMRC_GUARD_LONG = 0,
+	MMRC_GUARD_SHORT = 1,
+	MMRC_GUARD_MAX,
+};
+
+#define MMRC_RATE_TO_BITFIELD(x) ((x) & 0xF)
+#define MMRC_ATTEMPTS_TO_BITFIELD(x) ((x) & 0x7)
+#define MMRC_GUARD_TO_BITFIELD(x) ((x) & 0x1)
+#define MMRC_SS_TO_BITFIELD(x) ((x) & 0x3)
+#define MMRC_BW_TO_BITFIELD(x) ((x) & 0x7)
+#define MMRC_FLAGS_TO_BITFIELD(x) ((x) & 0x7)
+
+struct mmrc_rate {
+	u8 rate : 4;
+	u8 attempts : 3;
+	u8 guard : 1;
+	u8 ss : 2;
+	u8 bw : 3;
+	u8 flags : 3;
+	u16 index;
+};
+
+struct mmrc_rate_table {
+	struct mmrc_rate rates[MMRC_MAX_CHAIN_LENGTH];
+};
+
+#define SGI_PER_BW(bw) (1 << (bw))
+
+struct mmrc_sta_capabilities {
+	u8 max_rates : 3;
+	u8 max_retries : 3;
+	u8 bandwidth : 5;
+	u8 spatial_streams : 4;
+	u16 rates : 11;
+	u8 guard : 2;
+	u8 sta_flags : 4;
+	u8 sgi_per_bw : 5;
+};
+
+struct mmrc_stats_table {
+	u32 avg_throughput_counter;
+	u32 sum_throughput;
+	u32 max_throughput;
+	u16 sent;
+	u16 sent_success;
+	u16 back_mpdu_success;
+	u16 back_mpdu_failure;
+	u32 total_sent;
+	u32 total_success;
+	u16 evidence;
+	u8 prob;
+	bool have_sent_ampdus;
+};
+
+struct mmrc_table {
+	struct mmrc_sta_capabilities caps;
+	struct mmrc_rate best_tp;
+	struct mmrc_rate second_tp;
+	struct mmrc_rate baseline;
+	struct mmrc_rate best_prob;
+	struct mmrc_rate fixed_rate;
+	u32 cycle_cnt;
+	u32 last_lookaround_cycle;
+	u8 lookaround_cnt;
+
+	/* The ratio of using normal rate and sampling */
+	u8 lookaround_wrap;
+
+	/*
+	 * A counter that is used to determine when we should force a
+	 * lookaround. Should be a portion of the above lookaround with
+	 * less constraints
+	 */
+	u8 forced_lookaround;
+
+	u8 current_lookaround_rate_attempts;
+	u16 current_lookaround_rate_index;
+	u32 total_lookaround;
+
+	/*
+	 * A counter to detect if the current best rate is optimal
+	 * and may slow down sample frequency.
+	 */
+	u32 stability_cnt;
+
+	u32 stability_cnt_threshold;
+	u8 probability_variation;
+
+	/* The difference in MCS from each of the last 2 rate changes */
+	s8 best_rate_diff[2];
+
+	/* Indication of random versus consistently one-sided variation */
+	s8 probability_variation_direction;
+
+	/* Has rate control detected possible interference */
+	bool interference_likely;
+
+	/* Has rate control detected the best rate is no longer converged */
+	bool unconverged;
+
+	/* Is rate control just entering unconverged state */
+	bool newly_unconverged;
+
+	/*
+	 * Number of rate control cycles the best rate has remained
+	 * unchanged
+	 */
+	s32 best_rate_cycle_count;
+
+	/*
+	 * The probability table for the STA. This MUST always be the last
+	 * element in the struct.
+	 */
+	struct mmrc_stats_table table[];
+};
+
+void mmrc_sta_init(struct mmrc_table *tb, struct mmrc_sta_capabilities *caps,
+		   s8 rssi);
+size_t mmrc_memory_required_for_caps(struct mmrc_sta_capabilities *caps);
+void mmrc_get_rates(struct mmrc_table *tb, struct mmrc_rate_table *out,
+		    size_t size);
+void mmrc_feedback(struct mmrc_table *tb, struct mmrc_rate_table *rates,
+		   s32 retry_count, bool was_aggregated);
+void mmrc_update(struct mmrc_table *tb);
+bool mmrc_set_fixed_rate(struct mmrc_table *tb, struct mmrc_rate fixed_rate);
+u32 mmrc_calculate_theoretical_throughput(struct mmrc_rate rate);
+u32 mmrc_calculate_rate_tx_time(struct mmrc_rate *rate, size_t size);
+
+#endif /* _MMRC_H_ */
-- 
2.43.0


