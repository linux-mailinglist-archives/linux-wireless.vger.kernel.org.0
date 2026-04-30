Return-Path: <linux-wireless+bounces-35662-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKEVEGzh8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35662-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:58:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D580749D6A8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6E9F30089B3
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6FC36C0CA;
	Thu, 30 Apr 2026 04:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="aUPTAsYe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A615F369236
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525077; cv=none; b=qQfFdUtIesoAyHq0hTZl8H+QZvhyGRUqn5U15yUAgYZWUsdVbiYdpk85B8JEl0JEgzCnyaAt4I5tVDYFWir6JCXrKWSmDg1qVhBc00UDCm57TMFxrYluthDiOxvgFZu6zxlKAKu6s09sCURMeYQ/RkqyxhfgQ33LwpR7+zy9obc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525077; c=relaxed/simple;
	bh=nx8znFHMnN4w6de2ORtL3EGc29IYsmftmtC12W6qYkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRUDt5PBTNiMGE7ECt2XBYPO+0B0YWAdiXEMhY8Bals7y75lo9eMno1izE0RBwW5ijKai/gB1ORc+4cqD0N+cnWsXdGkOcC5uR2N9oEK1TwBTT7vlauxTsIQabTCAFQz3jnOWICzOSAucx5SJ+ckndmouRxbuxvVbpHJRIoDITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=aUPTAsYe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82faf871346so358217b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525075; x=1778129875; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zz86oTPiFHAFQUmI4yB6b7p+nYeeXkr4CFNcmx4onbk=;
        b=aUPTAsYeWcmbqn+/NDMrrovqwr41COEz4dKPH6zzy4hBHiavFu4Jd9rjrmpCGghmDa
         neqavbFgORXVw5Q7hStZjk+YlEEyCAvjBSPV+8/P4vD5qfHlrx9IkIAAi1NzFpdWKxYO
         JnHJF9389OFpSEBTObzFk9/90BriIbKRjWiLhvsdas5XpJQkxQ/WfaYRSz7sNu+h6e1b
         lL7X7mSVf4QnLSvQoLOq475sQc88tyj9iiPXBtjTJxFgZxx8IT5J89wf7+BQMiQ/ilK2
         hGqnOVziVJljGaHUho2/52v1RGqDLUcX2xTN3PClyQT3AQtQx9DQr+fZ+r9POz13lQRX
         cvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525075; x=1778129875;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zz86oTPiFHAFQUmI4yB6b7p+nYeeXkr4CFNcmx4onbk=;
        b=Z1FiochsZ0hKGoKXqQVcrLM4dh/gLIsFutXanQC9ARQ7SJ3J6PSU+3NK1oZ1m+mOFc
         sA9ls4kEUMvO22ql01Zuvcu4vbLHuLUEyUfcBZWs5JDJagEnIsQ/0LDsjbpYfenSM7K5
         YiMsh2LvsePT1sJR0biU8dgP4sJWo7oFpFQS2HhvvyxecYqyHq75bNFCad7fW73BqAZi
         bCa+tEGr4zw/TB+AHreGh58eRPPdWqiX1f+HF4mzHmjSj1HLNdDXznolBLfPvtyTiS2Y
         sJP1RLng8wH1E3lt2NGnfRR+hOqeboR7HMXENP/Ey6O8hg92cMsKmKgzlwtrpllWA/Ll
         nm8w==
X-Forwarded-Encrypted: i=1; AFNElJ8QlJh0NJR4cRIdlDc46HuZHxSAbgV9HmY/W57iwtmCG7BxDPN0GCiTVOoJ1xterMaQpPBUBkjm1A3XBcmjCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRz0brgnDsFNmsUglAMBL1NVBo7PRm0pv2twgK1aC9JMl70p8
	qb3T8KwekR3R2/1XBy4IzqkphSHe4Pywlz+W8jjQ/l1i0xsV/tOkgUs4x5SZYN4f07k=
X-Gm-Gg: AeBDies3DYqsivmsoEGCGqIu6chnoKu4t9dkLdUTvPZuTzuI1gjCYeEgfejAyzTkoyY
	sF+Q18UwbWzcnCLOwV8CK/T3VhijSQGn++f/nIU1Gn03H5daUXoY0PVRuEQFRxgD6xuQ+ufSgzl
	Q+sChckgAgdBTYSG+SkU20D/sl8k+jCUpji8a12t6fvyrFaxnUjHociUlkD5G71WYdOM3VfB4Bt
	q33fMwLcsSmThX+StM22aN9sekmUUdPwP8ItdTIVe7syl0wXVA6UqkNctwwnxk0eTz7rRgNgj30
	xcsF68evhQ848JLKU6Og/QEYQahuyMZc/Zfm/hqi54HBIfokmhjnZgWnuFLXj1vxlrxcy7QVvYl
	51jWMQg1Kiu+BeGImIK8NPxXQfGnEuAIZE7enFJqLkBp2IxkjBQU35k8G7xGZL5Wsq91M3FkeE2
	IEKtfSivCg7qBJUhNE3XJtWCsTKnECUO0qRE1x85g78lqawbI49+I72HRgPGR34vy6GpG3cFOXt
	jRqVg+CCNFLbo67/k0AdmFQ3NwLpGU9a6bIE6Qz1w==
X-Received: by 2002:a05:6a00:1c98:b0:82f:288:e572 with SMTP id d2e1a72fcca58-834fdb3556fmr1600951b3a.11.1777525075092;
        Wed, 29 Apr 2026 21:57:55 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:54 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 15/31] wifi: mm81x: add mmrc.h
Date: Thu, 30 Apr 2026 14:55:41 +1000
Message-ID: <20260430045615.334669-16-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D580749D6A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35662-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]

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


