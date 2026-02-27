Return-Path: <linux-wireless+bounces-32253-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGAcNC4aoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32253-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:14:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433A1B28E6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08C4E3012864
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086253128BE;
	Fri, 27 Feb 2026 04:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="WSk/qget"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FDD346772
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165599; cv=none; b=SV298LFcBvBizTccczPDbyo3gORjur7InTGCogYbid/DeKIiNPTgck114cGxwvb98lz8//a8XE+1OfygOGR6NaGnIzCrNwSZn3osOEXWLqA8u5vOT+Nn04Ai7vSPEUXd6fexFiOQ+sqTCw6dXHXIjJktz+5Oteag3k3+g1WqpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165599; c=relaxed/simple;
	bh=dFiwCD9QiXmWKVdCvZLsm973QmvJ/gkJLnZ4sPov3w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujx0Sh01GTBS/loRsRcLgVUz+yJ8o6baGEOFZxRYV4rKKE5h2CYrogZi7Fa46dd2UZz1wJMnlVVySX65UOK87Fw6zxcNvzQeXRE5gUorjmMqfzA/49oL6gV0hqXPNuQBCF/tTOG0rXpECr1gtVywIUQyyChGYXXts60PmXMNXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=WSk/qget; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ad9f2ee29aso9901295ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165596; x=1772770396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCVHJrN9BZC128tuKF42jUI2VQnvFjcsBF3gcT+c3SI=;
        b=WSk/qgeteBlXigAI3/ncCp6JbDEORSM4VgdPCZe5gZA0ee/6/DNCT6Pp9ohQuGQAJP
         Qfk1OebNXMzGNWxX/lsEtO2lDUgIesdAUwtfn+PcONcdEsbP1u2pbdihpbEd/Y57WLAG
         A374mmpHwLfwnnTA3H0CGTvn2kXbRE74y0/BoTUZz0s2XZSzE5Wb+AsV1Q7G0Q8kcWvd
         UfbsfZfdFHpXnN3E6FXo6qITc4zL5dWkBChtxiUIgNgb1PCKJuRIKOZg+icEqHak5o7+
         Ud5VrBhPsMt+9ugcpQWZhcfnNiWkwVRxdgfaQSrDVgeG7RpuVQxn5xAiPBPQgSnnTXJg
         pbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165596; x=1772770396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BCVHJrN9BZC128tuKF42jUI2VQnvFjcsBF3gcT+c3SI=;
        b=HRt0ErcB8iKxtCD1G86AnnDmJGeA5AkJeVKBzV+sZIjoLapd0TZCgM6LS/b1pNChpH
         8SsjoDT5Vd2Vh+MZJfS053XklCTnaIHFoMvNVYaOJFpPDNn8soDShL0uzNhN3CzWV8IU
         Ad/PK+AfXbeTXot8eK7lWXcjWkIYN5vxQ23Wf0O7j4GtedF/HfIhj7pImiLGHSvoww75
         c2hWxhXex8DEUYY7biqFFJHMti6erxnCqqBL1GEzyc3ROcnukk5+DcqMNl4hUFwpnJ58
         crEAFJTDHU2kNK8S5xf+ykIYcqlGcayenSXetzDEz7s4HY/o9xGxedPz/ymlRMwIwUER
         xTxw==
X-Forwarded-Encrypted: i=1; AJvYcCUGTGlNKU1yuFbIZ8aHPSV5UAd91BEHpn8yeSI3mZfT85sBNrca9Ib/MaVIMOUUjL6W4Xnklw095wfpGdrEGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YykL9wPtd0FY0M9vDH0kTjyy6VZe7CZy2XT6IgITn5ABfR9VUqK
	P/vVHC3keDqEV/zhN88+SMY7HIZEJUr0Y9wNvaILcmDv2OrFPCIaU5PxgAEGcWCs4I4=
X-Gm-Gg: ATEYQzwjFOoRe1TdKDV9JCGxSAR23Rq6FKQjNa7C7qCiDmSxbifwX+vs/mdZSRKD4i+
	8NcN/LeONJMSlz8YreHCWSJNzLWjMjIso+MpKStJoR6PP/AqA/OkiGtT9d3wy1wh7TiSqR554jB
	7jWuG0yFOdLjzcceEUtAEQKQYihHXSA2ExOuDFnczh9DeddeYTXHGQWNUKcW0PBCJGtW9EPGB0S
	JlU6RqRB2e7B1HXyDZjRkr3FVKqJSBpdx0XCnqRBypU3rw7nXTiI0fGXZ8jcj2sK1unE0Rer7rS
	0EOffUJJL7T6/Kbpycz8hKsU3AEwL83WXPigEs0EU4w4uyh4AUIdL1K6uwy0w2CdUIt6mjC5s3b
	s9UJtwszNgjoCGuHLJJclXtagEuH7jX3PtiYA2KniGPEJwlS5aaae3dDiVa3G1KfLYsqgGg4AEr
	Uyennda0YTpXnlDeu7jsn19mzmCqq4hIxiHFnpxulqMNByRSd7oz8w4Z+cn8bE0JHToKrTccqJP
	ojmVT765AD0JW0WNr6eAOVGhxlgxKY=
X-Received: by 2002:a17:902:ec8b:b0:2a7:c2d5:bcd7 with SMTP id d9443c01a7336-2ae2e3f0474mr11367085ad.20.1772165595190;
        Thu, 26 Feb 2026 20:13:15 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:13:14 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH wireless-next 14/35] wifi: mm81x: add mac.c
Date: Fri, 27 Feb 2026 15:10:24 +1100
Message-ID: <20260227041108.66508-15-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32253-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,morsemicro.com,kernel.org,gmail.com,google.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim,timeout.work:url,rate.bw:url,rate.ss:url]
X-Rspamd-Queue-Id: 6433A1B28E6
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/mac.c | 2642 +++++++++++++++++++
 1 file changed, 2642 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/mac.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/mac.c b/drivers/net/wireless/morsemicro/mm81x/mac.c
new file mode 100644
index 000000000000..2465a99c8048
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/mac.c
@@ -0,0 +1,2642 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include "core.h"
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/crc32.h>
+#include <net/mac80211.h>
+#include <asm/div64.h>
+#include <linux/kernel.h>
+#include "hif.h"
+#include "mac.h"
+#include "bus.h"
+#include "ps.h"
+#include "debug.h"
+#include "rc.h"
+
+/*
+ * Arbitrary size limit for the filter command address list, to ensure that
+ * the command does not exceed page/MTU size. This will be far greater than
+ * the number of filters supported by the firmware.
+ */
+#define MCAST_FILTER_COUNT_MAX (1024 / sizeof(filter->addr_list[0]))
+
+/* Calculate average RSSI for Rx status */
+#define CALC_AVG_RSSI(_avg, _sample) ((((_avg) * 9 + (_sample)) / 10))
+
+/*
+ * When automatically trying MCS0 before MCS10, this is how many
+ * MCS0 attempts to make
+ */
+#define MCS0_BEFORE_MCS10_COUNT (1)
+
+/* Maximum TX power (default) */
+#define MAX_TX_POWER_MBM (2200)
+
+/* Default queue count */
+#define MM81X_HW_QUEUE_COUNT (4)
+
+/* Max rates per skb */
+#define MM81X_HW_MAX_RATES (4)
+
+/* Max reported rates */
+#define MM81X_HW_MAX_REPORT_RATES (4)
+
+/* Max rate attempts */
+#define MM81X_HW_MAX_RATE_TRIES (1)
+
+/* Max sk pacing shift */
+#define MM81X_HW_TX_SK_PACING_SHIFT (3)
+
+/* NSS/MCS map values */
+#define MM81X_NSS_MCS_BYTE_0 0xfe /* 1SS */
+#define MM81X_NSS_MCS_BYTE_1 0x00
+#define MM81X_NSS_MCS_BYTE_2 0xfc /* 1SS */
+#define MM81X_NSS_MCS_BYTE_3 0x01
+#define MM81X_NSS_MCS_BYTE_4 0x00
+
+/* HW restart delay time before terminating hardware IF work items */
+#define MM81X_HW_RESTART_DELAY_MS 20
+
+/* clang-format off */
+
+/* mm81x chips do not support 16MHz */
+#define CHANS1G(channel, frequency, offset) \
+{                                                    \
+	.band            = NL80211_BAND_S1GHZ,       \
+	.center_freq     = (frequency),              \
+	.freq_offset     = (offset),                 \
+	.hw_value        = (channel),                \
+	.flags           = IEEE80211_CHAN_NO_16MHZ,  \
+	.max_antenna_gain = 0,                       \
+	.max_power        = 30,                      \
+}
+
+static struct ieee80211_channel mm_s1ghz_channels[] = {
+	CHANS1G(1, 902, 500),
+	CHANS1G(3, 903, 500),
+	CHANS1G(5, 904, 500),
+	CHANS1G(7, 905, 500),
+	CHANS1G(9, 906, 500),
+	CHANS1G(11, 907, 500),
+	CHANS1G(13, 908, 500),
+	CHANS1G(15, 909, 500),
+	CHANS1G(17, 910, 500),
+	CHANS1G(19, 911, 500),
+	CHANS1G(21, 912, 500),
+	CHANS1G(23, 913, 500),
+	CHANS1G(25, 914, 500),
+	CHANS1G(27, 915, 500),
+	CHANS1G(29, 916, 500),
+	CHANS1G(31, 917, 500),
+	CHANS1G(33, 918, 500),
+	CHANS1G(35, 919, 500),
+	CHANS1G(37, 920, 500),
+	CHANS1G(39, 921, 500),
+	CHANS1G(41, 922, 500),
+	CHANS1G(43, 923, 500),
+	CHANS1G(45, 924, 500),
+	CHANS1G(47, 925, 500),
+	CHANS1G(49, 926, 500),
+	CHANS1G(51, 927, 500),
+};
+
+/* clang-format on */
+
+static struct ieee80211_supported_band mm_band_s1ghz = {
+	.band = NL80211_BAND_S1GHZ,
+	.s1g_cap.s1g = true,
+	.channels = mm_s1ghz_channels,
+	.n_channels = ARRAY_SIZE(mm_s1ghz_channels),
+	.bitrates = NULL,
+	.n_bitrates = 0,
+	.s1g_cap.cap[4] = 0x80 /* STA type sensor only for AP & STA */
+};
+
+static struct ieee80211_iface_limit mm_if_limits[] = {
+	{
+		.max = MM81X_MAX_IF,
+		.types = BIT(NL80211_IFTYPE_STATION) | BIT(NL80211_IFTYPE_AP),
+	},
+};
+
+static struct ieee80211_iface_combination mm_if_combs[] = {
+	{
+		.limits = mm_if_limits,
+		.n_limits = ARRAY_SIZE(mm_if_limits),
+		.max_interfaces = MM81X_MAX_IF,
+		.num_different_channels = 1,
+	},
+};
+
+/* Convert from a time in time units (1024us) to us */
+#define MM81X_TU_TO_US(x) ((x) * 1024UL)
+
+/* Convert from a time in time units (1024us) to ms */
+#define MM81X_TU_TO_MS(x) (MM81X_TU_TO_US(x) / 1000UL)
+
+/* Default time to dwell on a scan channel */
+#define MM81X_HWSCAN_DEFAULT_DWELL_TIME_MS (30)
+
+/* Default time to dwell on a scan channel for passive scan */
+#define MM81X_HWSCAN_DEFAULT_PASSIVE_DWELL_TIME_MS (110)
+
+/* Default time to dwell on home channel, in between scan channels */
+#define MM81X_HWSCAN_DEFAULT_DWELL_ON_HOME_MS (200)
+
+/* Typical time it takes to send the probe */
+#define MM81X_HWSCAN_PROBE_DELAY_MS (30)
+
+/* A margin to account for event/command processing */
+#define MM81X_HWSCAN_TIMEOUT_OVERHEAD_MS (2000)
+
+/* Scan channel frequency mask */
+#define HW_SCAN_CH_LIST_FREQ_KHZ GENMASK(19, 0)
+
+/*
+ * Scan channel bandwidth mask.
+ * Encoded as: 0 = 1MHz, 1 = 2MHz, 2 = 4MHz, 3 = 8MHz
+ */
+#define HW_SCAN_CH_LIST_OP_BW GENMASK(21, 20)
+
+/*
+ * Scan channel primary channel width.
+ * Encoded as: 0 = 1MHz, 1 = 2MHz
+ */
+#define HW_SCAN_CH_LIST_PRIM_CH_WIDTH BIT(22)
+
+/* Index into power_list for tx power of channel */
+#define HW_SCAN_CH_LIST_PWR_LIST_IDX GENMASK(31, 26)
+
+struct hw_scan_tlv_hdr {
+	__le16 tag;
+	__le16 len;
+} __packed;
+
+struct hw_scan_tlv_channel_list {
+	struct hw_scan_tlv_hdr hdr;
+	__le32 channels[];
+} __packed;
+
+struct hw_scan_tlv_power_list {
+	struct hw_scan_tlv_hdr hdr;
+	s32 tx_power_qdbm[];
+} __packed;
+
+struct hw_scan_tlv_probe_req {
+	struct hw_scan_tlv_hdr hdr;
+	/* Probe request frame template (including SSIDs) */
+	u8 buf[];
+} __packed;
+
+struct hw_scan_tlv_dwell_on_home {
+	struct hw_scan_tlv_hdr hdr;
+	/* Time to dwell on home between scan channels */
+	__le32 home_dwell_time_ms;
+} __packed;
+
+#define DOT11AH_BA_MAX_MPDU_PER_AMPDU (32)
+
+/* wiphy scan params */
+#define MM81X_MAX_SCAN_IE_LEN 512
+#define MM81X_MAX_SCAN_SSIDS 1
+#define MM81X_MAX_REMAIN_ON_CHAN_DURATION 10000
+
+static int mm81x_tx_h_get_prim_bw(struct cfg80211_chan_def *chandef)
+{
+	return chandef->s1g_primary_2mhz ? 2 : 1;
+}
+
+static bool mm81x_reg_h_cc_equal(const char *cc1, const char *cc2)
+{
+	return (cc1[0] == cc2[0]) && (cc1[1] == cc2[1]);
+}
+
+static bool mm81x_tx_h_pkt_over_rts_threshold(struct mm81x *mm,
+					      struct ieee80211_tx_info *info,
+					      struct sk_buff *skb)
+{
+	u8 ccmp_len;
+
+	if (!info->control.hw_key)
+		return ((skb->len + FCS_LEN) > mm->rts_threshold);
+
+	if (info->control.hw_key->keylen == 32)
+		ccmp_len =
+			IEEE80211_CCMP_256_HDR_LEN + IEEE80211_CCMP_256_MIC_LEN;
+	else if (info->control.hw_key->keylen == 16)
+		ccmp_len = IEEE80211_CCMP_HDR_LEN + IEEE80211_CCMP_MIC_LEN;
+	else
+		ccmp_len = 0;
+
+	return ((skb->len + FCS_LEN + ccmp_len) > mm->rts_threshold);
+}
+
+static bool mm81x_tx_h_ps_filtered_for_sta(struct mm81x *mm,
+					   struct sk_buff *skb,
+					   struct ieee80211_sta *sta)
+{
+	struct mm81x_sta *mm_sta;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	if (!sta)
+		return false;
+
+	mm_sta = (struct mm81x_sta *)sta->drv_priv;
+
+	if (!mm_sta->tx_ps_filter_en)
+		return false;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "Frame for sta[%pM] PS filtered",
+		  mm_sta->addr);
+
+	info->flags |= IEEE80211_TX_STAT_TX_FILTERED;
+	info->flags &= ~IEEE80211_TX_CTL_AMPDU;
+
+	ieee80211_tx_status_skb(mm->hw, skb);
+	return true;
+}
+
+static void mm81x_mac_check_fw_disabled_chans(struct ieee80211_hw *hw)
+{
+	int ret = 0;
+	u32 i;
+	struct mm81x *mm = hw->priv;
+	struct host_cmd_resp_get_disabled_channels *resp;
+	u32 resp_len = sizeof(struct host_cmd_disabled_channel_entry) *
+			       ARRAY_SIZE(mm_s1ghz_channels) +
+		       sizeof(*resp);
+
+	lockdep_assert_held(&mm->lock);
+
+	resp = kzalloc(resp_len, GFP_KERNEL);
+	if (!resp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = mm81x_cmd_get_disabled_channels(mm, resp, resp_len);
+	if (ret)
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(mm_s1ghz_channels); i++) {
+		struct ieee80211_channel *ch = &mm_s1ghz_channels[i];
+
+		if (ch->flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		ch->flags &= ~IEEE80211_CHAN_S1G_NO_PRIMARY;
+	}
+
+	for (i = 0; i < le32_to_cpu(resp->n_channels); i++) {
+		struct ieee80211_channel *ch;
+		struct host_cmd_disabled_channel_entry *entry =
+			&resp->channels[i];
+
+		if (entry->bw_mhz != 1)
+			continue;
+
+		ch = ieee80211_get_channel_khz(
+			hw->wiphy,
+			KHZ100_TO_KHZ(le16_to_cpu(entry->freq_100khz)));
+		if (!ch)
+			continue;
+
+		ch->flags |= IEEE80211_CHAN_S1G_NO_PRIMARY;
+		mm81x_dbg(mm, MM81X_DBG_MAC, "set NO_PRIMARY on %u KHz",
+			  ieee80211_channel_to_khz(ch));
+	}
+
+out:
+	if (ret)
+		mm81x_err(mm, "failed to set disabled primary channels");
+
+	kfree(resp);
+}
+
+static int mm81x_mac_ops_start(struct ieee80211_hw *hw)
+{
+	struct mm81x *mm = hw->priv;
+
+	mm->started = true;
+	return 0;
+}
+
+static int mm81x_tx_h_get_max_bw(struct mm81x *mm)
+{
+	return MM81X_FW_SUPP(&mm->fw_caps, 8MHZ) ? 8 :
+	       MM81X_FW_SUPP(&mm->fw_caps, 4MHZ) ? 4 :
+	       MM81X_FW_SUPP(&mm->fw_caps, 2MHZ) ? 2 :
+						   1;
+}
+
+static void mm81x_mac_caps_init(struct mm81x *mm)
+{
+	struct mm81x_fw_caps *fw_caps = &mm->fw_caps;
+	struct ieee80211_sta_s1g_cap *s1g = &mm_band_s1ghz.s1g_cap;
+
+#define __FW_CAP_N(_n, _cap, _bit)                \
+	do {                                      \
+		if (MM81X_FW_SUPP(fw_caps, _cap)) \
+			s1g->cap[_n] |= (_bit);   \
+	} while (0)
+
+#define FW_CAP0(_cap, _bit) __FW_CAP_N(0, _cap, _bit)
+#define FW_CAP3(_cap, _bit) __FW_CAP_N(3, _cap, _bit)
+#define FW_CAP5(_cap, _bit) __FW_CAP_N(5, _cap, _bit)
+#define FW_CAP6(_cap, _bit) __FW_CAP_N(6, _cap, _bit)
+#define FW_CAP7(_cap, _bit) __FW_CAP_N(7, _cap, _bit)
+#define FW_CAP8(_cap, _bit) __FW_CAP_N(8, _cap, _bit)
+#define FW_CAP9(_cap, _bit) __FW_CAP_N(9, _cap, _bit)
+
+	FW_CAP0(S1G_LONG, S1G_CAP0_S1G_LONG);
+
+	s1g->cap[0] |= S1G_CAP0_SGI_1MHZ;
+	if (MM81X_FW_SUPP(fw_caps, SGI)) {
+		FW_CAP0(2MHZ, S1G_CAP0_SGI_2MHZ);
+		FW_CAP0(4MHZ, S1G_CAP0_SGI_4MHZ);
+		FW_CAP0(8MHZ, S1G_CAP0_SGI_8MHZ);
+	}
+
+	if (MM81X_FW_SUPP(fw_caps, 8MHZ))
+		s1g->cap[0] |= S1G_SUPP_CH_WIDTH_8;
+	else if (MM81X_FW_SUPP(fw_caps, 4MHZ))
+		s1g->cap[0] |= S1G_SUPP_CH_WIDTH_4;
+	else if (MM81X_FW_SUPP(fw_caps, 2MHZ))
+		s1g->cap[0] |= S1G_SUPP_CH_WIDTH_2;
+
+	FW_CAP3(RD_RESPONDER, S1G_CAP3_RD_RESPONDER);
+	FW_CAP3(LONG_MPDU, S1G_CAP3_MAX_MPDU_LEN);
+
+	FW_CAP5(AMSDU, S1G_CAP5_AMSDU);
+	FW_CAP5(AMPDU, S1G_CAP5_AMPDU);
+	FW_CAP5(ASYMMETRIC_BA_SUPPORT, S1G_CAP5_ASYMMETRIC_BA);
+	FW_CAP5(FLOW_CONTROL, S1G_CAP5_FLOW_CONTROL);
+
+	FW_CAP6(OBSS_MITIGATION, S1G_CAP6_OBSS_MITIGATION);
+	FW_CAP6(FRAGMENT_BA, S1G_CAP6_FRAGMENT_BA);
+	FW_CAP6(NDP_PSPOLL, S1G_CAP6_NDP_PS_POLL);
+	FW_CAP6(TXOP_SHARING_IMPLICIT_ACK, S1G_CAP6_TXOP_SHARING_IMP_ACK);
+	FW_CAP6(HTC_VHT_MFB, S1G_CAP6_VHT_LINK_ADAPT);
+
+	FW_CAP7(TACK_AS_PSPOLL, S1G_CAP7_TACK_AS_PS_POLL);
+	FW_CAP7(DUPLICATE_1MHZ, S1G_CAP7_DUP_1MHZ);
+	FW_CAP7(MCS_NEGOTIATION, S1G_CAP7_MCS_NEGOTIATION);
+	FW_CAP7(1MHZ_CONTROL_RESPONSE_PREAMBLE,
+		S1G_CAP7_1MHZ_CTL_RESPONSE_PREAMBLE);
+	FW_CAP7(SECTOR_TRAINING, S1G_CAP7_SECTOR_TRAINING_OPERATION);
+	FW_CAP7(TMP_PS_MODE_SWITCH, S1G_CAP7_TEMP_PS_MODE_SWITCH);
+
+	FW_CAP8(BDT, S1G_CAP8_BDT);
+
+	FW_CAP9(LINK_ADAPTATION_WO_NDP_CMAC,
+		S1G_CAP9_LINK_ADAPT_PER_CONTROL_RESPONSE);
+
+	/* 1SS MCS 9 for Rx / Tx map */
+	s1g->nss_mcs[0] = MM81X_NSS_MCS_BYTE_0;
+	s1g->nss_mcs[1] = MM81X_NSS_MCS_BYTE_1;
+	s1g->nss_mcs[2] = MM81X_NSS_MCS_BYTE_2;
+	s1g->nss_mcs[3] = MM81X_NSS_MCS_BYTE_3;
+	s1g->nss_mcs[4] = MM81X_NSS_MCS_BYTE_4;
+
+#undef FW_CAP0
+#undef FW_CAP3
+#undef FW_CAP5
+#undef FW_CAP6
+#undef FW_CAP7
+#undef FW_CAP8
+#undef FW_CAP9
+#undef __FW_CAP_N
+}
+
+static void mm81x_mac_beacon_irq_enable(struct mm81x_vif *mm_vif, bool enable)
+{
+	struct mm81x *mm = mm81x_vif_to_mm(mm_vif);
+	u8 beacon_irq_num = MM81X_INT_BEACON_BASE_NUM + mm_vif->id;
+
+	enable ? set_bit(beacon_irq_num, &mm->beacon_irqs_enabled) :
+		 clear_bit(beacon_irq_num, &mm->beacon_irqs_enabled);
+
+	mm81x_hw_irq_enable(mm, beacon_irq_num, enable);
+}
+
+static void mm81x_beacon_h_fill_tx_info(struct mm81x *mm,
+					struct mm81x_skb_tx_info *tx_info,
+					struct mm81x_vif *mm_vif, int tx_bw_mhz)
+{
+	enum dot11_bandwidth bw_idx =
+		mm81x_ratecode_bw_mhz_to_bw_index(tx_bw_mhz);
+	enum mm81x_rate_preamble pream = MM81X_RATE_PREAMBLE_S1G_SHORT;
+
+	tx_info->flags |=
+		cpu_to_le32(MM81X_TX_CONF_FLAGS_VIF_ID_SET(mm_vif->id));
+
+	if (bw_idx == DOT11_BANDWIDTH_1MHZ)
+		pream = MM81X_RATE_PREAMBLE_S1G_1M;
+
+	tx_info->rates[0].count = 1;
+	tx_info->rates[1].count = 0;
+	tx_info->rates[0].mm81x_ratecode =
+		mm81x_ratecode_init(bw_idx, 0, 0, pream);
+
+	if (mm->firmware_flags & MM81X_FW_FLAGS_REPORTS_TX_BEACON_COMPLETION)
+		tx_info->flags |=
+			cpu_to_le32(MM81X_TX_CONF_FLAGS_IMMEDIATE_REPORT);
+}
+
+static void mm81x_mac_beacon_tasklet(unsigned long data)
+{
+	struct mm81x_vif *mm_vif = (struct mm81x_vif *)data;
+	struct mm81x *mm = mm81x_vif_to_mm(mm_vif);
+	struct mm81x_skbq *mq;
+	struct sk_buff *beacon;
+	struct ieee80211_vif *vif = mm81x_vif_to_ieee80211_vif(mm_vif);
+	struct mm81x_skb_tx_info tx_info = { 0 };
+	int num_bcn_vifs = atomic_read(&mm->num_bcn_vifs);
+
+	mq = mm81x_hif_get_tx_beacon_queue(mm);
+	if (!mq) {
+		mm81x_err(mm, "no matching beacon Q found");
+		return;
+	}
+
+	if (mm81x_skbq_count(mq) >= num_bcn_vifs) {
+		mm81x_err(mm,
+			  "previous beacon not consumed, dropping req [id:%d]",
+			  mm_vif->id);
+		return;
+	}
+
+	beacon = ieee80211_beacon_get(mm->hw, vif, false);
+	if (!beacon) {
+		mm81x_err(mm, "failed to retrieve beacon");
+		return;
+	}
+
+	mm81x_beacon_h_fill_tx_info(mm, &tx_info, mm_vif,
+				    mm81x_tx_h_get_prim_bw(&mm->chandef));
+	mm81x_skbq_skb_tx(mq, &beacon, &tx_info, MM81X_SKB_CHAN_BEACON);
+}
+
+void mm81x_mac_beacon_irq_handle(struct mm81x *mm, u32 status)
+{
+	int vif_id;
+	unsigned long masked_status = (status & mm->beacon_irqs_enabled) >>
+				      MM81X_INT_BEACON_BASE_NUM;
+
+	guard(rcu)();
+	for_each_set_bit(vif_id, &masked_status, MM81X_MAX_IF) {
+		struct mm81x_vif *mm_vif;
+		struct ieee80211_vif *vif;
+
+		vif = mm81x_rcu_dereference_vif_id(mm, vif_id, true);
+		if (!vif)
+			continue;
+
+		mm_vif = ieee80211_vif_to_mm_vif(vif);
+		tasklet_schedule(&mm_vif->u.ap.beacon_tasklet);
+	}
+}
+
+static void mm81x_mac_beacon_init(struct mm81x_vif *mm_vif)
+{
+	struct mm81x *mm = mm81x_vif_to_mm(mm_vif);
+
+	tasklet_init(&mm_vif->u.ap.beacon_tasklet, mm81x_mac_beacon_tasklet,
+		     (unsigned long)mm_vif);
+
+	mm81x_mac_beacon_irq_enable(mm_vif, true);
+	atomic_inc(&mm->num_bcn_vifs);
+}
+
+static struct hw_scan_tlv_hdr mm81x_hw_scan_h_pack_tlv_hdr(u16 tag, u16 len)
+{
+	struct hw_scan_tlv_hdr hdr = { .tag = cpu_to_le16(tag),
+				       .len = cpu_to_le16(len) };
+	return hdr;
+}
+
+static __le32 mm81x_hw_scan_h_pack_channel(struct ieee80211_channel *chan,
+					   u8 pwr_idx)
+{
+	__le32 packed = 0;
+	u32 freq_khz = ieee80211_channel_to_khz(chan);
+
+	packed |= le32_encode_bits(freq_khz, HW_SCAN_CH_LIST_FREQ_KHZ);
+	packed |= le32_encode_bits(mm81x_ratecode_bw_mhz_to_bw_index(1),
+				   HW_SCAN_CH_LIST_OP_BW);
+	packed |= le32_encode_bits(mm81x_ratecode_bw_mhz_to_bw_index(1),
+				   HW_SCAN_CH_LIST_PRIM_CH_WIDTH);
+	packed |= le32_encode_bits(pwr_idx, HW_SCAN_CH_LIST_PWR_LIST_IDX);
+
+	return packed;
+}
+
+static u8 *
+mm81x_hw_scan_h_add_channel_list_tlv(u8 *buf,
+				     struct mm81x_hw_scan_params *params)
+{
+	int i;
+	struct hw_scan_tlv_channel_list *ch_list =
+		(struct hw_scan_tlv_channel_list *)buf;
+
+	ch_list->hdr = mm81x_hw_scan_h_pack_tlv_hdr(
+		HOST_CMD_HW_SCAN_TLV_TAG_CHAN_LIST,
+		params->num_chans * sizeof(ch_list->channels[0]));
+
+	for (i = 0; i < params->num_chans; i++) {
+		struct ieee80211_channel *chan = params->channels[i].channel;
+
+		ch_list->channels[i] = mm81x_hw_scan_h_pack_channel(
+			chan, params->channels[i].power_idx);
+	}
+
+	return (u8 *)&ch_list->channels[i];
+}
+
+static u8 *
+mm81x_hw_scan_h_add_power_list_tlv(u8 *buf, struct mm81x_hw_scan_params *params)
+{
+	int i;
+	struct hw_scan_tlv_power_list *pwr_list =
+		(struct hw_scan_tlv_power_list *)buf;
+	size_t size = sizeof(pwr_list->tx_power_qdbm[0]) * params->n_powers;
+
+	pwr_list->hdr = mm81x_hw_scan_h_pack_tlv_hdr(
+		HOST_CMD_HW_SCAN_TLV_TAG_POWER_LIST, size);
+
+	for (i = 0; i < params->n_powers; i++)
+		pwr_list->tx_power_qdbm[i] = params->powers_qdbm[i];
+
+	return (u8 *)&pwr_list->tx_power_qdbm[i];
+}
+
+static u8 *
+mm81x_hw_scan_h_add_probe_req_tlv(u8 *buf, struct mm81x_hw_scan_params *params)
+{
+	struct sk_buff *skb = params->probe_req;
+	struct hw_scan_tlv_probe_req *probe_req =
+		(struct hw_scan_tlv_probe_req *)buf;
+
+	probe_req->hdr = mm81x_hw_scan_h_pack_tlv_hdr(
+		HOST_CMD_HW_SCAN_TLV_TAG_PROBE_REQ, skb->len);
+	memcpy(probe_req->buf, skb->data, skb->len);
+
+	return buf + sizeof(*probe_req) + skb->len;
+}
+
+static u8 *
+mm81x_hw_scan_h_insert_dwell_time_tlv(u8 *buf,
+				      struct mm81x_hw_scan_params *params)
+{
+	struct hw_scan_tlv_dwell_on_home *dwell =
+		(struct hw_scan_tlv_dwell_on_home *)buf;
+
+	dwell->hdr = mm81x_hw_scan_h_pack_tlv_hdr(
+		HOST_CMD_HW_SCAN_TLV_TAG_DWELL_ON_HOME,
+		sizeof(*dwell) - sizeof(dwell->hdr));
+	dwell->home_dwell_time_ms = cpu_to_le32(params->dwell_on_home_ms);
+
+	return buf + sizeof(*dwell);
+}
+
+static int __mm81x_hw_scan_h_init_probe_req(struct mm81x_hw_scan_params *params,
+					    u8 *ssid, u8 ssid_len,
+					    struct ieee80211_scan_ies *ies)
+{
+	u8 *pos;
+	struct sk_buff *probe_req;
+	struct ieee80211_tx_info *info;
+	u16 ies_len = ies->len[NL80211_BAND_S1GHZ] + ies->common_ie_len;
+
+	probe_req = ieee80211_probereq_get(params->hw, params->vif->addr, ssid,
+					   ssid_len, ies_len);
+	if (!probe_req)
+		return -ENOMEM;
+
+	pos = skb_put(probe_req, ies_len);
+	memcpy(pos, ies->common_ies, ies->common_ie_len);
+	pos += ies->common_ie_len;
+	memcpy(pos, ies->ies[NL80211_BAND_S1GHZ], ies->len[NL80211_BAND_S1GHZ]);
+
+	info = IEEE80211_SKB_CB(probe_req);
+	info->control.vif = params->vif;
+	params->probe_req = probe_req;
+
+	return 0;
+}
+
+static void mm81x_hw_scan_h_init_ssid(struct mm81x *mm,
+				      struct cfg80211_ssid *ssids, int n_ssids,
+				      u8 **out_ssid, u8 *out_ssid_len)
+{
+	*out_ssid = NULL;
+	*out_ssid_len = 0;
+
+	if (n_ssids > 0) {
+		if (n_ssids > 1) {
+			mm81x_warn(
+				mm,
+				"Multiple SSIDs found when only one supported. Using the first only.");
+		}
+		*out_ssid_len = ssids[0].ssid_len;
+		*out_ssid = ssids[0].ssid;
+	}
+}
+
+static int
+mm81x_hw_scan_h_init_probe_req(struct mm81x_hw_scan_params *params,
+			       struct ieee80211_scan_request *scan_req)
+{
+	struct mm81x *mm = params->hw->priv;
+	struct cfg80211_scan_request *req = &scan_req->req;
+	struct ieee80211_scan_ies *ies = &scan_req->ies;
+	u8 ssid_len = 0;
+	u8 *ssid = NULL;
+
+	mm81x_hw_scan_h_init_ssid(mm, req->ssids, req->n_ssids, &ssid,
+				  &ssid_len);
+
+	return __mm81x_hw_scan_h_init_probe_req(params, ssid, ssid_len, ies);
+}
+
+static bool
+mm81x_hw_scan_h_is_chan_present(const struct mm81x_hw_scan_params *params,
+				const struct ieee80211_channel *chan)
+{
+	int channel;
+
+	for (channel = 0; channel < params->num_chans; channel++) {
+		if (params->channels[channel].channel == chan)
+			return true;
+	}
+
+	return false;
+}
+
+static int mm81x_hw_scan_h_insert_chan(struct mm81x_hw_scan_params *params,
+				       struct ieee80211_channel *chan)
+{
+	if (!params->channels)
+		return -EFAULT;
+
+	if (!chan)
+		return -EFAULT;
+
+	if (params->num_chans >= params->allocated_chans)
+		return -ENOMEM;
+
+	if (mm81x_hw_scan_h_is_chan_present(params, chan))
+		return 0;
+
+	params->channels[params->num_chans].channel = chan;
+	params->num_chans++;
+	return 0;
+}
+
+static int mm81x_hw_scan_h_init_chan_list(struct mm81x_hw_scan_params *params,
+					  struct ieee80211_channel **chans,
+					  u32 n_channels)
+{
+	int i, j;
+	int num_pwrs_coarse = 0;
+	int last_pwr = INT_MIN;
+	int chans_to_allocate = 0;
+
+	for (i = 0; i < n_channels; i++)
+		if (chans[i])
+			chans_to_allocate++;
+
+	params->num_chans = 0;
+	params->allocated_chans = 0;
+	params->channels = kcalloc(chans_to_allocate, sizeof(*params->channels),
+				   GFP_KERNEL);
+	if (!params->channels)
+		return -ENOMEM;
+
+	params->allocated_chans = chans_to_allocate;
+
+	for (i = 0; i < n_channels; i++)
+		if (chans[i])
+			mm81x_hw_scan_h_insert_chan(params, chans[i]);
+
+	/*
+	 * Calculate a rough estimate of number of different channel
+	 * powers required
+	 */
+	for (i = 0; i < params->num_chans; i++) {
+		if (chans[i]->max_reg_power != last_pwr) {
+			last_pwr = chans[i]->max_reg_power;
+			num_pwrs_coarse++;
+		}
+	}
+
+	params->powers_qdbm = kmalloc_array(
+		num_pwrs_coarse, sizeof(*params->powers_qdbm), GFP_KERNEL);
+	if (!params->powers_qdbm)
+		return -ENOMEM;
+
+	params->n_powers = 0;
+
+	for (i = 0; i < params->num_chans; i++) {
+		s32 power_qdbm =
+			MBM_TO_QDBM(DBM_TO_MBM(chans[i]->max_reg_power));
+
+		/* Try and find the power in the list */
+		for (j = 0; j < params->n_powers; j++)
+			if (params->powers_qdbm[j] == power_qdbm)
+				break;
+
+		/* Reached the end of the list - add the new power option */
+		if (j == params->n_powers) {
+			params->powers_qdbm[j] = power_qdbm;
+			params->n_powers++;
+			if (params->n_powers > num_pwrs_coarse) {
+				WARN_ON(1);
+				return -EFAULT;
+			}
+		}
+
+		/* Give the index of the power level to the channel */
+		params->channels[i].power_idx = j;
+	}
+	return 0;
+}
+
+static void mm81x_hw_scan_h_clean_params(struct mm81x_hw_scan_params *params)
+{
+	if (params->probe_req)
+		dev_kfree_skb_any(params->probe_req);
+	kfree(params->channels);
+	kfree(params->powers_qdbm);
+
+	params->num_chans = 0;
+	params->allocated_chans = 0;
+}
+
+size_t mm81x_hw_scan_h_get_cmd_size(struct mm81x_hw_scan_params *params)
+{
+	struct hw_scan_tlv_channel_list *ch_list;
+	struct hw_scan_tlv_power_list *pwr_list;
+	struct hw_scan_tlv_probe_req *probe_req;
+	struct hw_scan_tlv_dwell_on_home *dwell;
+	struct host_cmd_req_hw_scan *req;
+	size_t cmd_size = sizeof(*req);
+
+	/* No TLVs if simple abort command */
+	if (params->operation != MM81X_HW_SCAN_OP_START)
+		return cmd_size;
+
+	cmd_size += struct_size(ch_list, channels, params->num_chans);
+	cmd_size += struct_size(pwr_list, tx_power_qdbm, params->n_powers);
+
+	if (params->probe_req)
+		cmd_size += struct_size(probe_req, buf, params->probe_req->len);
+	if (params->dwell_on_home_ms)
+		cmd_size += sizeof(*dwell);
+
+	return cmd_size;
+}
+
+u8 *mm81x_hw_scan_h_insert_tlvs(struct mm81x_hw_scan_params *params, u8 *buf)
+{
+	buf = mm81x_hw_scan_h_add_channel_list_tlv(buf, params);
+	buf = mm81x_hw_scan_h_add_power_list_tlv(buf, params);
+
+	if (params->dwell_on_home_ms)
+		buf = mm81x_hw_scan_h_insert_dwell_time_tlv(buf, params);
+	if (params->probe_req)
+		buf = mm81x_hw_scan_h_add_probe_req_tlv(buf, params);
+
+	return buf;
+}
+
+static u32 mm81x_hw_scan_h_get_dwell_on_home(struct mm81x *mm,
+					     struct ieee80211_vif *vif)
+{
+	if (vif->type == NL80211_IFTYPE_STATION &&
+	    mm81x_mac_is_sta_vif_associated(vif))
+		return mm->hw_scan.home_dwell_ms;
+	return 0;
+}
+
+static struct mm81x_hw_scan_params *
+__mm81x_hw_scan_h_init_params(struct mm81x *mm)
+{
+	struct mm81x_hw_scan_params *params = mm->hw_scan.params;
+
+	if (!params) {
+		params = kzalloc_obj(*params, GFP_KERNEL);
+		if (params)
+			mm->hw_scan.params = params;
+	} else {
+		mm81x_hw_scan_h_clean_params(params);
+		memset(params, 0, sizeof(*params));
+	}
+
+	return params;
+}
+
+static int mm81x_hw_scan_h_init_params(struct mm81x *mm,
+				       struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct cfg80211_scan_request *req)
+{
+	struct mm81x_hw_scan_params *params = mm->hw_scan.params;
+
+	lockdep_assert_held(&mm->lock);
+
+	params = __mm81x_hw_scan_h_init_params(mm);
+	if (!params) {
+		mm->hw_scan.state = HW_SCAN_STATE_IDLE;
+		return -ENOMEM;
+	}
+
+	params->hw = hw;
+	params->vif = vif;
+	params->has_directed_ssid = (req->ssids && req->ssids[0].ssid_len > 0);
+	params->operation = MM81X_HW_SCAN_OP_START;
+	params->dwell_on_home_ms = mm81x_hw_scan_h_get_dwell_on_home(mm, vif);
+	params->use_1mhz_probes = true;
+
+	if (req->duration)
+		params->dwell_time_ms = MM81X_TU_TO_MS(req->duration);
+	else if (req->n_ssids == 0)
+		params->dwell_time_ms =
+			MM81X_HWSCAN_DEFAULT_PASSIVE_DWELL_TIME_MS;
+	else
+		params->dwell_time_ms = MM81X_HWSCAN_DEFAULT_DWELL_TIME_MS;
+
+	return 0;
+}
+
+static u32 mm81x_hw_scan_h_calc_timeout(struct mm81x_hw_scan_params *params)
+{
+	u32 ret = 0;
+
+	ret = params->dwell_time_ms + params->dwell_on_home_ms;
+	if (params->probe_req)
+		ret += MM81X_HWSCAN_PROBE_DELAY_MS;
+
+	ret *= params->num_chans;
+	ret += MM81X_HWSCAN_TIMEOUT_OVERHEAD_MS;
+
+	return ret;
+}
+
+static int mm81x_mac_ops_hw_scan(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_scan_request *hw_req)
+{
+	int ret = 0;
+	struct mm81x *mm = hw->priv;
+	struct cfg80211_scan_request *req = &hw_req->req;
+	struct mm81x_hw_scan_params *params;
+	struct ieee80211_channel **chans = hw_req->req.channels;
+
+	mutex_lock(&mm->lock);
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "state %d", mm->hw_scan.state);
+
+	if (!mm->started) {
+		mm81x_warn(mm, "device not ready");
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	switch (mm->hw_scan.state) {
+	case HW_SCAN_STATE_IDLE:
+		mm->hw_scan.state = HW_SCAN_STATE_RUNNING;
+		reinit_completion(&mm->hw_scan.scan_done);
+		break;
+	case HW_SCAN_STATE_RUNNING:
+	case HW_SCAN_STATE_ABORTING:
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	ret = mm81x_hw_scan_h_init_params(mm, hw, vif, req);
+	if (ret)
+		goto exit;
+
+	params = mm->hw_scan.params;
+
+	ret = mm81x_hw_scan_h_init_chan_list(params, chans,
+					     hw_req->req.n_channels);
+	if (ret)
+		goto exit;
+
+	/* Only init the probe request template if this is an active scan */
+	if (req->n_ssids > 0) {
+		ret = mm81x_hw_scan_h_init_probe_req(params, hw_req);
+		if (ret) {
+			mm81x_err(mm, "Failed to init probe req %d", ret);
+			goto exit;
+		}
+	}
+
+	ret = mm81x_cmd_hw_scan(mm, params, false);
+	if (ret) {
+		mm->hw_scan.state = HW_SCAN_STATE_IDLE;
+		goto exit;
+	}
+
+	ieee80211_queue_delayed_work(
+		mm->hw, &mm->hw_scan.timeout,
+		msecs_to_jiffies(mm81x_hw_scan_h_calc_timeout(params)));
+exit:
+	mutex_unlock(&mm->lock);
+	return ret;
+}
+
+static void mm81x_hw_scan_h_cancel(struct mm81x *mm)
+{
+	int ret;
+	struct mm81x_hw_scan_params params = { 0 };
+
+	mutex_lock(&mm->lock);
+	cancel_delayed_work_sync(&mm->hw_scan.timeout);
+
+	switch (mm->hw_scan.state) {
+	case HW_SCAN_STATE_IDLE:
+	case HW_SCAN_STATE_ABORTING:
+		/* scan not running */
+		mutex_unlock(&mm->lock);
+		return;
+	case HW_SCAN_STATE_RUNNING:
+		mm->hw_scan.state = HW_SCAN_STATE_ABORTING;
+		break;
+	}
+
+	params.operation = MM81X_HW_SCAN_OP_STOP;
+
+	ret = mm81x_cmd_hw_scan(mm, &params, false);
+
+	mutex_unlock(&mm->lock);
+
+	if (ret || !mm->started ||
+	    !wait_for_completion_timeout(&mm->hw_scan.scan_done, 1 * HZ)) {
+		/*
+		 * We may have lost the event on the bus, the chip could be
+		 * wedged, or the cmd failed for another reason. Nevertheless,
+		 * we should call the done event so mac80211 knows to unblock
+		 * itself.
+		 */
+		struct cfg80211_scan_info info = { .aborted = true };
+
+		mutex_lock(&mm->lock);
+		ieee80211_scan_completed(mm->hw, &info);
+		mm->hw_scan.state = HW_SCAN_STATE_IDLE;
+
+		mutex_unlock(&mm->lock);
+	}
+}
+
+static void mm81x_mac_ops_cancel_hw_scan(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif)
+{
+	struct mm81x *mm = hw->priv;
+
+	cancel_delayed_work_sync(&mm->hw_scan.timeout);
+	mm81x_hw_scan_h_cancel(mm);
+}
+
+static void mm81x_mac_hw_scan_done_event(struct ieee80211_hw *hw)
+{
+	struct mm81x *mm = hw->priv;
+	struct cfg80211_scan_info info = { 0 };
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "completing hw scan");
+
+	mutex_lock(&mm->lock);
+
+	switch (mm->hw_scan.state) {
+	case HW_SCAN_STATE_IDLE:
+		/* Scan has already been stopped. Just continue */
+		goto exit;
+	case HW_SCAN_STATE_RUNNING:
+	case HW_SCAN_STATE_ABORTING:
+		mm->hw_scan.state = HW_SCAN_STATE_IDLE;
+		info.aborted = (mm->hw_scan.state == HW_SCAN_STATE_ABORTING);
+	}
+
+	ieee80211_scan_completed(mm->hw, &info);
+exit:
+	complete(&mm->hw_scan.scan_done);
+	mutex_unlock(&mm->lock);
+	cancel_delayed_work_sync(&mm->hw_scan.timeout);
+}
+
+static void mm81x_mac_hw_scan_timeout_work(struct work_struct *work)
+{
+	struct mm81x *mm =
+		container_of(work, struct mm81x, hw_scan.timeout.work);
+
+	mm81x_err(mm, "hw scan timed out, aborting");
+	mm81x_hw_scan_h_cancel(mm);
+}
+
+static void mm81x_mac_hw_scan_init(struct mm81x *mm)
+{
+	mm->hw_scan.state = HW_SCAN_STATE_IDLE;
+	mm->hw_scan.params = NULL;
+	mm->hw_scan.home_dwell_ms = MM81X_HWSCAN_DEFAULT_DWELL_ON_HOME_MS;
+
+	init_completion(&mm->hw_scan.scan_done);
+	INIT_DELAYED_WORK(&mm->hw_scan.timeout, mm81x_mac_hw_scan_timeout_work);
+}
+
+static void mm81x_mac_hw_scan_destroy(struct mm81x *mm)
+{
+	cancel_delayed_work_sync(&mm->hw_scan.timeout);
+	if (mm->hw_scan.params)
+		mm81x_hw_scan_h_clean_params(mm->hw_scan.params);
+	kfree(mm->hw_scan.params);
+	mm->hw_scan.params = NULL;
+}
+
+static void mm81x_mac_hw_scan_finish(struct mm81x *mm)
+{
+	struct cfg80211_scan_info info = {
+		.aborted = true,
+	};
+	lockdep_assert_held(&mm->lock);
+
+	if (mm->hw_scan.state == HW_SCAN_STATE_IDLE)
+		return;
+
+	ieee80211_scan_completed(mm->hw, &info);
+	complete(&mm->hw_scan.scan_done);
+	mm->hw_scan.state = HW_SCAN_STATE_IDLE;
+	cancel_delayed_work_sync(&mm->hw_scan.timeout);
+}
+
+int mm81x_mac_event_recv(struct mm81x *mm, struct sk_buff *skb)
+{
+	int ret;
+	struct host_cmd_event *event = (struct host_cmd_event *)(skb->data);
+	u16 event_id = le16_to_cpu(event->hdr.message_id);
+	u16 event_iid = le16_to_cpu(event->hdr.host_id);
+
+	if (!HOST_CMD_IS_EVT(event) || event_iid != 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	switch (event_id) {
+	case HOST_CMD_ID_EVT_HW_SCAN_DONE: {
+		mm81x_dbg(mm, MM81X_DBG_ANY,
+			  "Event: HOST_CMD_ID_EVT_HW_SCAN_DONE Received.");
+		mm81x_mac_hw_scan_done_event(mm->hw);
+		ret = 0;
+		break;
+	}
+	default:
+		ret = 0;
+		break;
+	}
+
+exit:
+	return ret;
+}
+
+static void mm81x_tx_h_apply_mcs10(struct mm81x *mm,
+				   struct mm81x_skb_tx_info *tx_info)
+{
+	u8 i;
+	u8 j;
+	int mcs0_first_idx = -1;
+	int mcs0_last_idx = -1;
+
+	/* Find out where our first and last MCS0 entries are. */
+	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
+		enum dot11_bandwidth bw_idx = mm81x_ratecode_bw_index_get(
+			tx_info->rates[i].mm81x_ratecode);
+
+		if (bw_idx == DOT11_BANDWIDTH_1MHZ) {
+			mcs0_last_idx = i;
+			if (mcs0_first_idx == -1)
+				mcs0_first_idx = i;
+		}
+
+		/*
+		 * If the count is 0 then we are at the end of the table.
+		 * Break to allow us to reuse i indicating the end of the
+		 * table.
+		 */
+		if (tx_info->rates[i].count == 0)
+			break;
+	}
+
+	/* If there aren't any MCS0 (at 1MHz) entries we are done. */
+	if (mcs0_first_idx < 0)
+		return;
+
+	/*
+	 * If we are in MCS10_MODE_AUTO add MCS10 counts to the table if they
+	 * will fit. There should be three cases:
+	 *
+	 * - There is one MSC0 entry and the table is full -> do nothing
+	 * - There is one MSC0 entry and the table has space -> adjust MSC0
+	 *   down and add MCS 10
+	 * - There are multiple MCS0 entries -> replace entries after the first
+	 *   with MCS 10
+	 */
+	/* Case 3 - replace additional entries. */
+	if (mcs0_last_idx > mcs0_first_idx) {
+		for (j = mcs0_first_idx + 1; j < i; j++) {
+			enum dot11_bandwidth bw_idx =
+				mm81x_ratecode_bw_index_get(
+					tx_info->rates[j].mm81x_ratecode);
+			u8 mcs_index = mm81x_ratecode_mcs_index_get(
+				tx_info->rates[j].mm81x_ratecode);
+			if (mcs_index == 0 && bw_idx == DOT11_BANDWIDTH_1MHZ) {
+				mm81x_ratecode_mcs_index_set(
+					&tx_info->rates[j].mm81x_ratecode, 10);
+			}
+		}
+		/* Case 2 - add additional MCS10 entry. */
+	} else if (mcs0_last_idx == mcs0_first_idx &&
+		   i < (IEEE80211_TX_MAX_RATES)) {
+		int pre_mcs10_mcs0_count =
+			min_t(u8, tx_info->rates[mcs0_last_idx].count,
+			      MCS0_BEFORE_MCS10_COUNT);
+		int mcs10_count = tx_info->rates[mcs0_last_idx].count -
+				  pre_mcs10_mcs0_count;
+
+		/*
+		 * If there were less retries than our desired minimum MCS0 we
+		 * don't add MCS10 retries.
+		 */
+		if (mcs10_count > 0) {
+			/* Use the same flags for MCS10 as MCS0. */
+			tx_info->rates[i].mm81x_ratecode =
+				tx_info->rates[mcs0_last_idx].mm81x_ratecode;
+			mm81x_ratecode_mcs_index_set(
+				&tx_info->rates[i].mm81x_ratecode, 10);
+			tx_info->rates[mcs0_last_idx].count =
+				pre_mcs10_mcs0_count;
+			tx_info->rates[i].count = mcs10_count;
+		}
+	}
+}
+
+void mm81x_tx_h_check_aggr(struct ieee80211_sta *pubsta, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct mm81x_sta *mm_sta = (struct mm81x_sta *)pubsta->drv_priv;
+	u8 tid = ieee80211_get_tid(hdr);
+
+	/* we are already aggregating */
+	if (mm_sta->tid_tx[tid] || mm_sta->tid_start_tx[tid])
+		return;
+
+	if (mm_sta->state < IEEE80211_STA_AUTHORIZED)
+		return;
+
+	if (skb_get_queue_mapping(skb) == IEEE80211_AC_VO)
+		return;
+
+	if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
+		return;
+
+	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+		return;
+
+	mm_sta->tid_start_tx[tid] = true;
+	ieee80211_start_tx_ba_session(pubsta, tid, 0);
+}
+
+int mm81x_tx_h_get_attempts(struct mm81x *mm,
+			    struct mm81x_skb_tx_status *tx_sts)
+{
+	int attempts = 0;
+	int i;
+	int count = min_t(int, MM81X_SKB_MAX_RATES, IEEE80211_TX_MAX_RATES);
+
+	for (i = 0; i < count; i++) {
+		if (tx_sts->rates[i].count > 0)
+			attempts += tx_sts->rates[i].count;
+		else
+			break;
+	}
+
+	return attempts;
+}
+
+static void mm81x_tx_h_fill_info(struct mm81x *mm,
+				 struct mm81x_skb_tx_info *tx_info,
+				 struct sk_buff *skb, struct ieee80211_vif *vif,
+				 int tx_bw_mhz, struct ieee80211_sta *sta)
+{
+	int i;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct mm81x_vif *mm_vif = ieee80211_vif_to_mm_vif(vif);
+	struct mm81x_sta *mm_sta = NULL;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	int op_bw_mhz = cfg80211_chandef_get_width(&mm->chandef);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+	bool rts_allowed = op_bw_mhz < 8;
+
+	if (sta)
+		mm_sta = (struct mm81x_sta *)sta->drv_priv;
+
+	rts_allowed &= mm81x_tx_h_pkt_over_rts_threshold(mm, info, skb);
+
+	mm81x_rc_sta_fill_tx_rates(mm, tx_info, skb, sta, tx_bw_mhz,
+				   rts_allowed);
+
+	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
+		if (rts_allowed)
+			mm81x_ratecode_enable_rts(
+				&tx_info->rates[i].mm81x_ratecode);
+
+		if (info->control.rates[i].flags & IEEE80211_TX_RC_SHORT_GI)
+			mm81x_ratecode_enable_sgi(
+				&tx_info->rates[i].mm81x_ratecode);
+	}
+
+	/* Apply change of MCS0 to MCS10 if required. */
+	mm81x_tx_h_apply_mcs10(mm, tx_info);
+
+	tx_info->flags |=
+		cpu_to_le32(MM81X_TX_CONF_FLAGS_VIF_ID_SET(mm_vif->id));
+
+	if (info->flags & IEEE80211_TX_CTL_AMPDU)
+		tx_info->flags |= cpu_to_le32(MM81X_TX_CONF_FLAGS_CTL_AMPDU);
+
+	if (info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM)
+		tx_info->flags |=
+			cpu_to_le32(MM81X_TX_CONF_FLAGS_SEND_AFTER_DTIM);
+
+	if (info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER) {
+		tx_info->flags |= cpu_to_le32(MM81X_TX_CONF_NO_PS_BUFFER);
+
+		if (info->flags & IEEE80211_TX_STATUS_EOSP)
+			tx_info->flags |= cpu_to_le32(
+				MM81X_TX_CONF_FLAGS_IMMEDIATE_REPORT);
+	} else if (ieee80211_is_mgmt(hdr->frame_control) &&
+		   !ieee80211_is_bufferable_mmpdu(skb)) {
+		tx_info->flags |= cpu_to_le32(MM81X_TX_CONF_NO_PS_BUFFER);
+	}
+
+	if (info->control.hw_key) {
+		tx_info->flags |= cpu_to_le32(MM81X_TX_CONF_FLAGS_HW_ENCRYPT);
+		tx_info->flags |= cpu_to_le32(MM81X_TX_CONF_FLAGS_KEY_IDX_SET(
+			info->control.hw_key->hw_key_idx));
+	}
+
+	tx_info->tid = tid;
+	if (mm_sta) {
+		tx_info->tid_params = mm_sta->tid_params[tid];
+
+		if (info->flags & IEEE80211_TX_CTL_CLEAR_PS_FILT) {
+			if (mm_sta->tx_ps_filter_en)
+				mm81x_dbg(mm, MM81X_DBG_ANY,
+					  "TX ps filter cleared sta[%pM]",
+					  mm_sta->addr);
+			mm_sta->tx_ps_filter_en = false;
+		}
+	}
+}
+
+static void mm81x_mac_ops_tx(struct ieee80211_hw *hw,
+			     struct ieee80211_tx_control *control,
+			     struct sk_buff *skb)
+{
+	struct mm81x *mm = hw->priv;
+	struct mm81x_skbq *mq = NULL;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mm81x_skb_tx_info tx_info = { 0 };
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	bool is_mgmt = ieee80211_is_mgmt(hdr->frame_control);
+	int tx_bw_mhz = cfg80211_chandef_get_width(&mm->chandef);
+	struct ieee80211_sta *sta = control->sta;
+	int max_tx_bw = 0, sta_max_bw_mhz = 0;
+
+	if (sta) {
+		struct mm81x_sta *mm_sta = (struct mm81x_sta *)sta->drv_priv;
+
+		sta_max_bw_mhz = mm_sta->max_bw_mhz;
+	}
+
+	max_tx_bw = mm81x_tx_h_get_max_bw(mm);
+	tx_bw_mhz = min(max_tx_bw, tx_bw_mhz);
+
+	if (is_mgmt)
+		tx_bw_mhz = mm81x_tx_h_get_prim_bw(&mm->chandef);
+	if (sta_max_bw_mhz)
+		tx_bw_mhz = min(tx_bw_mhz, sta_max_bw_mhz);
+	if (ieee80211_is_probe_resp(hdr->frame_control))
+		tx_bw_mhz = 1;
+
+	mm81x_tx_h_fill_info(mm, &tx_info, skb, vif, tx_bw_mhz, sta);
+
+	if (mm81x_tx_h_ps_filtered_for_sta(mm, skb, sta))
+		return;
+
+	if (is_mgmt)
+		mq = mm81x_hif_get_tx_mgmt_queue(mm);
+	else
+		mq = mm81x_hif_get_tx_data_queue(mm,
+						 dot11_tid_to_ac(tx_info.tid));
+
+	mm81x_skbq_skb_tx(mq, &skb, &tx_info,
+			  (is_mgmt) ? MM81X_SKB_CHAN_MGMT :
+				      MM81X_SKB_CHAN_DATA);
+}
+
+static void mm81x_mac_ops_stop(struct ieee80211_hw *hw, bool suspend)
+{
+	struct mm81x *mm = hw->priv;
+
+	mutex_lock(&mm->lock);
+	mm->started = false;
+	mutex_unlock(&mm->lock);
+}
+
+static void mm81x_mac_beacon_finish(struct mm81x_vif *mm_vif)
+{
+	struct mm81x *mm = mm81x_vif_to_mm(mm_vif);
+
+	mm81x_mac_beacon_irq_enable(mm_vif, false);
+	tasklet_kill(&mm_vif->u.ap.beacon_tasklet);
+	/*
+	 * Side effect of the restarting required when
+	 * reacting to regdom changes...
+	 */
+	atomic_add_unless(&mm->num_bcn_vifs, -1, 0);
+}
+
+static void mm81x_mac_ops_remove_interface(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	int ret;
+	struct mm81x *mm = hw->priv;
+	struct mm81x_vif *mm_vif = (struct mm81x_vif *)vif->drv_priv;
+
+	mutex_lock(&mm->lock);
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		mm81x_mac_beacon_finish(mm_vif);
+
+	ret = mm81x_cmd_rm_if(mm, mm_vif->id);
+	if (ret)
+		mm81x_err(mm, "mm81x_cmd_rm_if failed %d", ret);
+
+	RCU_INIT_POINTER(mm->vifs[mm_vif->id], NULL);
+	mutex_unlock(&mm->lock);
+}
+
+static s32 mm81x_mac_get_max_txpower(struct mm81x *mm)
+{
+	int ret;
+	s32 power_mbm;
+
+	/* Retrieve maximum TX power the chip can transmit */
+	ret = mm81x_cmd_get_max_txpower(mm, &power_mbm);
+	if (ret) {
+		mm81x_err(mm, "using default tx max power %d mBm",
+			  MAX_TX_POWER_MBM);
+		return MAX_TX_POWER_MBM;
+	}
+
+	mm81x_dbg(mm, MM81X_DBG_MAC, "Max tx power detected %d mBm", power_mbm);
+	return power_mbm;
+}
+
+static s32 mm81x_mac_set_txpower(struct mm81x *mm, s32 power_mbm)
+{
+	int ret;
+	s32 out_power_mbm;
+
+	if (mm->tx_max_power_mbm == INT_MAX)
+		mm->tx_max_power_mbm = mm81x_mac_get_max_txpower(mm);
+
+	power_mbm = min(power_mbm, mm->tx_max_power_mbm);
+	if (power_mbm == mm->tx_power_mbm)
+		return mm->tx_power_mbm;
+
+	ret = mm81x_cmd_set_txpower(mm, &out_power_mbm, power_mbm);
+	if (ret) {
+		mm81x_err(mm, "failed, power %d mBm ret %d", power_mbm, ret);
+		return mm->tx_power_mbm;
+	}
+
+	if (out_power_mbm != mm->tx_power_mbm) {
+		mm81x_dbg(mm, MM81X_DBG_MAC, "%d -> %d mBm", mm->tx_power_mbm,
+			  out_power_mbm);
+		mm->tx_power_mbm = out_power_mbm;
+	}
+
+	return mm->tx_power_mbm;
+}
+
+static int mm81x_mac_set_channel(struct mm81x *mm, u32 op_chan_freq_hz,
+				 u8 pri_1mhz_chan_idx, u8 op_bw_mhz,
+				 u8 pri_bw_mhz)
+{
+	int ret;
+
+	ret = mm81x_cmd_set_channel(mm, op_chan_freq_hz, pri_1mhz_chan_idx,
+				    op_bw_mhz, pri_bw_mhz, &mm->tx_power_mbm);
+	if (ret) {
+		mm81x_err(mm, "mm81x_cmd_set_channel() failed, ret %d", ret);
+		return ret;
+	}
+
+	mm81x_mac_set_txpower(mm, mm->tx_power_mbm);
+	return 0;
+}
+
+static u8 mm81x_mac_pri_chan_to_index(const struct cfg80211_chan_def *chandef)
+{
+	u32 bw_mhz = cfg80211_chandef_get_width(chandef);
+	u32 op_center_khz = ieee80211_chandef_to_khz(chandef);
+	u32 first_1mhz_center_khz = op_center_khz - (bw_mhz * 500) + 500;
+	u32 pri_1mhz_khz = ieee80211_channel_to_khz(chandef->chan);
+
+	return (pri_1mhz_khz - first_1mhz_center_khz) / 1000;
+}
+
+static int mm81x_mac_ops_change_channel(struct ieee80211_hw *hw,
+					struct ieee80211_chanctx_conf *ctx)
+{
+	int ret;
+	struct mm81x *mm = hw->priv;
+	struct cfg80211_chan_def *chandef = &ctx->def;
+	u64 freq_hz = KHZ_TO_HZ(ieee80211_chandef_to_khz(chandef));
+	u8 op_bw_mhz = cfg80211_chandef_get_width(chandef);
+	u8 pri_1mhz_idx = mm81x_mac_pri_chan_to_index(chandef);
+	int pri_chan_width_mhz = mm81x_tx_h_get_prim_bw(chandef);
+
+	mm81x_dbg(mm, MM81X_DBG_MAC,
+		  "ch: freq=%llu Hz bw=%u pri_idx=%d pri_bw=%d", freq_hz,
+		  op_bw_mhz, pri_1mhz_idx, pri_chan_width_mhz);
+
+	ret = mm81x_mac_set_channel(mm, freq_hz, (u8)pri_1mhz_idx, op_bw_mhz,
+				    pri_chan_width_mhz);
+	if (ret)
+		return ret;
+
+	memcpy(&mm->chandef, chandef, sizeof(mm->chandef));
+	return 0;
+}
+
+static int mm81x_mac_ops_add_chanctx(struct ieee80211_hw *hw,
+				     struct ieee80211_chanctx_conf *ctx)
+{
+	int err = 0;
+	struct mm81x *mm = hw->priv;
+
+	mutex_lock(&mm->lock);
+	err = mm81x_mac_ops_change_channel(hw, ctx);
+	mutex_unlock(&mm->lock);
+	return err;
+}
+
+static void mm81x_mac_ops_remove_chanctx(struct ieee80211_hw *hw,
+					 struct ieee80211_chanctx_conf *ctx)
+{
+	/* mm81x only supports a single chanctx */
+	UNUSED(hw);
+	UNUSED(ctx);
+}
+
+static void mm81x_mac_ops_change_chanctx(struct ieee80211_hw *hw,
+					 struct ieee80211_chanctx_conf *ctx,
+					 u32 changed)
+{
+	struct mm81x *mm = hw->priv;
+
+	UNUSED(ctx);
+
+	if (!mm->started)
+		return;
+
+	/*
+	 * mm81x only support changing/setting the channel
+	 * when we create an interface.
+	 */
+	if (WARN_ON(changed & IEEE80211_CHANCTX_CHANGE_CHANNEL))
+		mm81x_err(mm, "Changing channel via chanctx not supported");
+}
+
+static int
+mm81x_mac_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_bss_conf *link_conf,
+				 struct ieee80211_chanctx_conf *ctx)
+{
+	/* mm81x only supports a single chanctx */
+	UNUSED(hw);
+	UNUSED(vif);
+	UNUSED(link_conf);
+	UNUSED(ctx);
+
+	return 0;
+}
+
+static void
+mm81x_mac_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf,
+				   struct ieee80211_chanctx_conf *ctx)
+{
+	/* mm81x only supports a single chanctx */
+	UNUSED(hw);
+	UNUSED(vif);
+	UNUSED(link_conf);
+	UNUSED(ctx);
+}
+
+static int mm81x_mac_ops_config(struct ieee80211_hw *hw, int radio_idx,
+				u32 changed)
+{
+	struct mm81x *mm = hw->priv;
+	struct ieee80211_conf *conf = &hw->conf;
+	struct ieee80211_channel *channel = conf->chandef.chan;
+
+	if (!mm->started)
+		return 0;
+
+	mutex_lock(&mm->lock);
+
+	if ((changed & IEEE80211_CONF_CHANGE_POWER) &&
+	    !(conf->flags & IEEE80211_CONF_MONITOR)) {
+		s32 power_mbm = DBM_TO_MBM(conf->power_level);
+
+		power_mbm = min(channel->max_reg_power, power_mbm);
+		power_mbm = mm81x_mac_set_txpower(mm, power_mbm);
+		conf->power_level = MBM_TO_DBM(power_mbm);
+	}
+
+	mutex_unlock(&mm->lock);
+	return 0;
+}
+
+static int mm81x_mac_ops_get_txpower(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     unsigned int link_id, int *dbm)
+{
+	struct mm81x *mm = hw->priv;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct cfg80211_chan_def *chandef = &vif->bss_conf.chanreq.oper;
+
+	scoped_guard(rcu) {
+		chanctx_conf = rcu_access_pointer(vif->bss_conf.chanctx_conf);
+		if (!chanctx_conf ||
+		    !cfg80211_chandef_identical(chandef, &chanctx_conf->def))
+			return -ENODATA;
+	}
+
+	mutex_lock(&mm->lock);
+	*dbm = MBM_TO_DBM(mm->tx_power_mbm);
+	mutex_unlock(&mm->lock);
+	return 0;
+}
+
+static void mm81x_mac_config_ps(struct mm81x *mm, struct ieee80211_vif *vif)
+{
+	bool en_ps = vif->cfg.ps;
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		return;
+
+	if (mm->config_ps == en_ps)
+		return;
+
+	mm81x_dbg(mm, MM81X_DBG_MAC, "change powersave mode: %d (current %d)",
+		  en_ps, mm->config_ps);
+
+	mm->config_ps = en_ps;
+
+	/*
+	 * If we have GPIO pins wired. Let's control host-to-chip PS
+	 * mechanism. Otherwise, ignore the command altogether.
+	 */
+	if (en_ps) {
+		mm81x_cmd_set_ps(mm, true);
+		mm81x_ps_enable(mm);
+	} else {
+		mm81x_ps_disable(mm);
+		mm81x_cmd_set_ps(mm, false);
+	}
+}
+
+static void mm81x_mac_ops_bss_info_changed(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   struct ieee80211_bss_conf *info,
+					   u64 changed)
+{
+	int ret;
+	struct mm81x *mm = hw->priv;
+	struct mm81x_vif *mm_vif = (struct mm81x_vif *)vif->drv_priv;
+
+	mutex_lock(&mm->lock);
+
+	if (changed & BSS_CHANGED_PS)
+		mm81x_mac_config_ps(mm, vif);
+
+	if (changed & BSS_CHANGED_BEACON_ENABLED) {
+		/* start command is sent, only if it was previously stopped */
+		if ((mm_vif->u.ap.beaconing_enabled && info->enable_beacon) ||
+		    !info->enable_beacon)
+			mm81x_cmd_config_beacon_timer(mm, mm_vif,
+						      info->enable_beacon);
+
+		mm_vif->u.ap.beaconing_enabled = true;
+	}
+
+	if (changed & BSS_CHANGED_BEACON_INT || changed & BSS_CHANGED_SSID) {
+		ret = mm81x_cmd_cfg_bss(mm, mm_vif->id, info->beacon_int,
+					info->dtim_period,
+					mm81x_vif_generate_cssid(vif));
+		if (ret)
+			mm81x_err(mm, "mm81x_cmd_cfg_bss failed %d", ret);
+	}
+
+	mutex_unlock(&mm->lock);
+}
+
+static u64 mm81x_mac_ops_prepare_multicast(struct ieee80211_hw *hw,
+					   struct netdev_hw_addr_list *mc_list)
+{
+	struct mm81x *mm = hw->priv;
+	struct mcast_filter *filter;
+	struct netdev_hw_addr *addr;
+	u16 addr_count = netdev_hw_addr_list_count(mc_list);
+	u16 len = sizeof(*filter) + addr_count * sizeof(filter->addr_list[0]);
+
+	filter = kzalloc(len, GFP_ATOMIC);
+	if (!filter)
+		return 0;
+
+	if (addr_count > MCAST_FILTER_COUNT_MAX) {
+		mm81x_warn(
+			mm,
+			"Multicast filtering disabled - too many groups (%d) > %u",
+			addr_count, (u16)MCAST_FILTER_COUNT_MAX);
+		filter->count = 0;
+	} else {
+		netdev_hw_addr_list_for_each(addr, mc_list) {
+			mm81x_dbg(mm, MM81X_DBG_ANY,
+				  "mcast whitelist (%d): %pM", filter->count,
+				  addr->addr);
+			filter->addr_list[filter->count++] =
+				mac2leuint32(addr->addr);
+		}
+	}
+
+	return (u64)(unsigned long)filter;
+}
+
+static void mm81x_mac_ops_configure_filter(struct ieee80211_hw *hw,
+					   unsigned int changed_flags,
+					   unsigned int *total_flags,
+					   u64 multicast)
+{
+	struct mm81x *mm = hw->priv;
+	struct mcast_filter *cmd = (void *)(unsigned long)multicast;
+	struct mm81x_vif *mm_vif = NULL;
+	struct ieee80211_vif *vif = NULL;
+	int vif_id = 0;
+	int ret = 0;
+
+	if (!cmd)
+		goto out;
+
+	mutex_lock(&mm->lock);
+	kfree(mm->mcast_filter);
+	mm->mcast_filter = cmd;
+
+	for (vif_id = 0; vif_id < ARRAY_SIZE(mm->vifs); vif_id++) {
+		vif = mm81x_rcu_dereference_vif_id(mm, vif_id, false);
+		if (!vif)
+			continue;
+
+		mm_vif = ieee80211_vif_to_mm_vif(vif);
+
+		ret = mm81x_cmd_cfg_multicast_filter(mm, mm_vif);
+		if (!ret)
+			continue;
+
+		mm81x_err(mm, "Multicast filtering failed - rc=%d", ret);
+		mm->mcast_filter = NULL;
+		kfree(cmd);
+		break;
+	}
+
+out:
+	mutex_unlock(&mm->lock);
+	*total_flags &= 0;
+}
+
+static int mm81x_mac_ops_conf_tx(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 unsigned int link_id, u16 ac,
+				 const struct ieee80211_tx_queue_params *params)
+{
+	int ret;
+	struct mm81x *mm = hw->priv;
+	struct mm81x_queue_params mqp;
+
+	mutex_lock(&mm->lock);
+	mqp.aci = map_mac80211q_2_mm81x_aci(ac);
+	mqp.aifs = params->aifs;
+	mqp.cw_max = params->cw_max;
+	mqp.cw_min = params->cw_min;
+	mqp.uapsd = params->uapsd;
+	mqp.txop = params->txop << 5;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY,
+		  "queue:%d txop:%d cw_min:%d cw_max:%d aifs:%d", mqp.aci,
+		  mqp.txop, mqp.cw_min, mqp.cw_max, mqp.aifs);
+
+	ret = mm81x_cmd_cfg_qos(mm, &mqp);
+	if (ret)
+		mm81x_dbg(mm, MM81X_DBG_ANY, "mm81x_cmd_cfg_qos failed %d",
+			  ret);
+
+	mutex_unlock(&mm->lock);
+	return ret;
+}
+
+static int mm81x_mac_ops_sta_state(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   enum ieee80211_sta_state old_state,
+				   enum ieee80211_sta_state new_state)
+{
+	u16 aid;
+	int ret = 0;
+	struct mm81x *mm = hw->priv;
+	struct mm81x_vif *mm_vif = (struct mm81x_vif *)vif->drv_priv;
+	struct mm81x_sta *mm_sta = (struct mm81x_sta *)sta->drv_priv;
+
+	/* Ignore both NOTEXIST to NONE and NONE to NOTEXIST */
+	if ((old_state == IEEE80211_STA_NOTEXIST &&
+	     new_state == IEEE80211_STA_NONE) ||
+	    (old_state == IEEE80211_STA_NONE &&
+	     new_state == IEEE80211_STA_NOTEXIST))
+		return 0;
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		aid = mm81x_mac_sta_aid(vif);
+	else
+		aid = sta->aid;
+
+	mutex_lock(&mm->lock);
+	ret = mm81x_cmd_sta_state(mm, mm_vif, aid, sta, new_state);
+	if (ret < 0)
+		goto exit;
+
+	ether_addr_copy(mm_sta->addr, sta->addr);
+	mm_sta->state = new_state;
+
+	if (new_state > old_state && new_state == IEEE80211_STA_ASSOC) {
+		if (vif->type == NL80211_IFTYPE_AP)
+			mm_vif->u.ap.num_stas++;
+		else if (vif->type == NL80211_IFTYPE_STATION)
+			mm_vif->u.sta.is_assoc = true;
+	}
+
+	if (new_state < old_state && new_state == IEEE80211_STA_NONE) {
+		if (vif->type == NL80211_IFTYPE_AP)
+			mm_vif->u.ap.num_stas--;
+		else if (vif->type == NL80211_IFTYPE_STATION)
+			mm_vif->u.sta.is_assoc = false;
+	}
+
+exit:
+	/*
+	 * Always update our mmrc sta state even on failure to ensure
+	 * we don't hold a dangling sta on error
+	 */
+	mm81x_rc_sta_state_check(mm, vif, sta, old_state, new_state);
+	mutex_unlock(&mm->lock);
+	return new_state < old_state ? 0 : ret;
+}
+
+static int mm81x_mac_ops_ampdu_action(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_ampdu_params *params)
+{
+	u16 tid = params->tid;
+	struct mm81x *mm = hw->priv;
+	struct ieee80211_sta *sta = params->sta;
+	struct mm81x_sta *mm_sta = (struct mm81x_sta *)sta->drv_priv;
+	u16 buf_size =
+		min_t(u16, params->buf_size, DOT11AH_BA_MAX_MPDU_PER_AMPDU);
+
+	mutex_lock(&mm->lock);
+	switch (params->action) {
+	case IEEE80211_AMPDU_TX_START:
+		mm81x_dbg(mm, MM81X_DBG_ANY, "%pM.%d A-MPDU TX start",
+			  mm_sta->addr, tid);
+		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	case IEEE80211_AMPDU_TX_STOP_CONT:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH:
+	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
+		mm81x_dbg(mm, MM81X_DBG_ANY, "%pM.%d A-MPDU TX flush",
+			  mm_sta->addr, tid);
+		mm_sta->tid_start_tx[tid] = false;
+		mm_sta->tid_tx[tid] = false;
+		mm_sta->tid_params[tid] = 0;
+		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
+		break;
+	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		mm81x_dbg(mm, MM81X_DBG_ANY, "%pM.%d A-MPDU TX oper",
+			  mm_sta->addr, tid);
+		mm_sta->tid_tx[tid] = true;
+		if (!buf_size) {
+			mm81x_err(mm, "%pM.%d A-MPDU Invalid buf size",
+				  mm_sta->addr, tid);
+			break;
+		}
+		mm_sta->tid_params[tid] =
+			u8_encode_bits(buf_size - 1,
+				       TX_INFO_TID_PARAMS_MAX_REORDER_BUF) |
+			u8_encode_bits(1, TX_INFO_TID_PARAMS_AMPDU_ENABLED) |
+			u8_encode_bits(params->amsdu,
+				       TX_INFO_TID_PARAMS_AMSDU_SUPPORTED);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&mm->lock);
+	return 0;
+}
+
+static int mm81x_mac_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 struct ieee80211_key_conf *key)
+{
+	u16 aid;
+	int ret = -EOPNOTSUPP;
+	struct mm81x *mm = hw->priv;
+	struct mm81x_vif *mm_vif = (struct mm81x_vif *)vif->drv_priv;
+	enum host_cmd_key_cipher cipher;
+	enum host_cmd_aes_key_len length;
+
+	mutex_lock(&mm->lock);
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		aid = mm81x_mac_sta_aid(vif);
+	} else if (sta) {
+		aid = sta->aid;
+	} else {
+		/* Is a group key - AID is unused */
+		WARN_ON((key->flags & IEEE80211_KEY_FLAG_PAIRWISE));
+		aid = 0;
+	}
+
+	switch (cmd) {
+	case SET_KEY: {
+		switch (key->cipher) {
+		case WLAN_CIPHER_SUITE_CCMP:
+		case WLAN_CIPHER_SUITE_CCMP_256:
+			cipher = HOST_CMD_KEY_CIPHER_AES_CCM;
+			break;
+		case WLAN_CIPHER_SUITE_GCMP:
+		case WLAN_CIPHER_SUITE_GCMP_256:
+			cipher = HOST_CMD_KEY_CIPHER_AES_GCM;
+			break;
+		default:
+			/* Cipher suite currently not supported */
+			ret = -EOPNOTSUPP;
+			goto exit;
+		}
+
+		switch (key->keylen) {
+		case 16:
+			length = HOST_CMD_AES_KEY_LEN_LENGTH_128;
+			break;
+		case 32:
+			length = HOST_CMD_AES_KEY_LEN_LENGTH_256;
+			break;
+		default:
+			/* Key length not supported */
+			ret = -EOPNOTSUPP;
+			goto exit;
+		}
+
+		ret = mm81x_cmd_install_key(mm, mm_vif, aid, key, cipher,
+					    length);
+		break;
+	}
+	case DISABLE_KEY:
+		ret = mm81x_cmd_disable_key(mm, mm_vif, aid, key);
+		if (ret) {
+			/* Must return 0 */
+			mm81x_warn(mm, "Failed to remove key");
+			ret = 0;
+		}
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	if (ret) {
+		mm81x_dbg(mm, MM81X_DBG_ANY, "Falling back to software crypto");
+		ret = 1;
+	}
+
+exit:
+	mutex_unlock(&mm->lock);
+	return ret;
+}
+
+static int mm81x_mac_set_frag_threshold(struct ieee80211_hw *hw, int radio_idx,
+					u32 value)
+{
+	int ret = -EINVAL;
+	struct mm81x *mm = hw->priv;
+
+	mutex_lock(&mm->lock);
+	ret = mm81x_cmd_set_frag_threshold(mm, value);
+	mutex_unlock(&mm->lock);
+	return ret;
+}
+
+static void mm81x_rx_h_fill_status(struct mm81x *mm,
+				   struct mm81x_skb_rx_status *hdr_rx_status,
+				   struct ieee80211_rx_status *rx_status,
+				   struct sk_buff *skb)
+{
+	u8 mcs_index;
+	u32 flags = le32_to_cpu(hdr_rx_status->flags);
+	u16 freq_100khz = le16_to_cpu(hdr_rx_status->freq_100khz);
+	__le32 ratecode = hdr_rx_status->mm81x_ratecode;
+
+	rx_status->signal = le16_to_cpu(hdr_rx_status->rssi);
+	rx_status->encoding = RX_ENC_VHT;
+	rx_status->band = NL80211_BAND_S1GHZ;
+	rx_status->freq = KHZ100_TO_MHZ(freq_100khz);
+	rx_status->freq_offset = (freq_100khz % 10) ? 1 : 0;
+	rx_status->nss = NSS_IDX_TO_NSS(mm81x_ratecode_nss_index_get(ratecode));
+
+	if (flags & MM81X_RX_STATUS_FLAGS_DECRYPTED)
+		rx_status->flag |= RX_FLAG_DECRYPTED;
+
+	mcs_index = mm81x_ratecode_mcs_index_get(ratecode);
+	rx_status->rate_idx = (mcs_index == 10) ? 0 : mcs_index;
+
+	if (mm81x_ratecode_sgi_get(ratecode))
+		rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+}
+
+/*
+ * The firmware passes up NULL vifs for broadcast management frames. Find
+ * the first interface that best fits the frame we are rx'ing. This
+ * has the clear downside if we have two vifs with the same interface type
+ * the 2nd vif will never be targeted. For now, this will have to do.
+ */
+static struct ieee80211_vif *mm81x_rx_h_find_bcast_vif(struct mm81x *mm,
+						       struct sk_buff *skb)
+{
+	int vif_id;
+	struct ieee80211_vif *vif;
+	const struct ieee80211_hdr *hdr = (void *)skb->data;
+
+	lockdep_assert_in_rcu_read_lock();
+
+	for (vif_id = 0; vif_id < ARRAY_SIZE(mm->vifs); vif_id++) {
+		vif = mm81x_rcu_dereference_vif_id(mm, vif_id, true);
+		if (!vif)
+			continue;
+
+		if (!ieee80211_is_mgmt(hdr->frame_control))
+			return vif;
+
+		switch (le16_to_cpu(hdr->frame_control) &
+			IEEE80211_FCTL_STYPE) {
+		case IEEE80211_STYPE_BEACON:
+			if (vif->type == NL80211_IFTYPE_STATION)
+				return vif;
+			break;
+		case IEEE80211_STYPE_PROBE_RESP:
+			if (vif->type == NL80211_IFTYPE_STATION)
+				return vif;
+			break;
+		case IEEE80211_STYPE_PROBE_REQ:
+			if (vif->type == NL80211_IFTYPE_AP)
+				return vif;
+			break;
+		default:
+			return vif;
+		}
+	}
+
+	return NULL;
+}
+
+static void mm81x_rx_h_update_sta(struct ieee80211_vif *vif,
+				  struct ieee80211_hdr *hdr,
+				  struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_sta *sta;
+	struct mm81x_sta *msta;
+	u8 *lookup = ieee80211_is_s1g_beacon(hdr->frame_control) ? hdr->addr1 :
+								   hdr->addr2;
+
+	lockdep_assert_in_rcu_read_lock();
+
+	sta = ieee80211_find_sta(vif, lookup);
+	if (!sta)
+		return;
+
+	msta = (void *)sta->drv_priv;
+	if (msta->avg_rssi) {
+		msta->avg_rssi =
+			CALC_AVG_RSSI(msta->avg_rssi, rx_status->signal);
+	} else {
+		msta->avg_rssi = rx_status->signal;
+	}
+}
+
+static struct ieee80211_vif *
+mm81x_rx_h_skb_get_vif(struct mm81x *mm, struct sk_buff *skb,
+		       struct mm81x_skb_rx_status *hdr_rx_status)
+{
+	u8 vif_id = u32_get_bits(le32_to_cpu(hdr_rx_status->flags),
+				 MM81X_RX_STATUS_FLAGS_VIF_ID);
+
+	lockdep_assert_in_rcu_read_lock();
+
+	/*
+	 * The firmware passes up broadcast mgmt frames such as beacons with a
+	 * NULL VIF. Assign the correct VIF. If no matching VIF was found, the
+	 * VIF is not yet up.
+	 */
+	if (vif_id == INVALID_VIF_INDEX)
+		return mm81x_rx_h_find_bcast_vif(mm, skb);
+
+	return mm81x_rcu_dereference_vif_id(mm, vif_id, true);
+}
+
+void mm81x_mac_rx_skb(struct mm81x *mm, struct sk_buff *skb,
+		      struct mm81x_skb_rx_status *hdr_rx_status)
+{
+	struct ieee80211_vif *vif;
+	struct ieee80211_hw *hw = mm->hw;
+	struct ieee80211_rx_status rx_status;
+	struct ieee80211_hdr *hdr = (void *)skb->data;
+
+	memset(&rx_status, 0, sizeof(rx_status));
+
+	if (!mm->started || !skb->data || !skb->len) {
+		dev_kfree_skb_any(skb);
+		return;
+	}
+
+	mm81x_rx_h_fill_status(mm, hdr_rx_status, &rx_status, skb);
+
+	scoped_guard(rcu) {
+		vif = mm81x_rx_h_skb_get_vif(mm, skb, hdr_rx_status);
+		if (!vif) {
+			dev_kfree_skb_any(skb);
+			return;
+		}
+
+		mm81x_rx_h_update_sta(vif, hdr, &rx_status);
+	}
+
+	memcpy(IEEE80211_SKB_RXCB(skb), &rx_status, sizeof(rx_status));
+
+	ieee80211_rx_irqsafe(hw, skb);
+}
+
+static void mm81x_mac_ops_flush(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif, u32 queues,
+				bool drop)
+{
+	struct mm81x *mm = hw->priv;
+
+	/* We don't support IEEE80211_HW_QUEUE_CONTROL so flush all queues */
+	if (drop) {
+		/*
+		 * No need to call mm81x_skbq_stop_tx_queues as mac80211
+		 * has already cancelled each queue prior to calling .flush()
+		 */
+		mm81x_skbq_data_traffic_pause(mm);
+
+		flush_work(&mm->hif_work);
+		flush_work(&mm->tx_stale_work);
+
+		mm81x_hif_clear_events(mm);
+		mm81x_hif_flush_tx_data(mm);
+		mm81x_hif_flush_cmds(mm);
+
+		/* Reenable data, not that there will be any */
+		mm81x_skbq_data_traffic_resume(mm);
+	}
+}
+
+static int mm81x_mac_ops_set_rts_threshold(struct ieee80211_hw *hw,
+					   int radio_idx, u32 value)
+{
+	struct mm81x *mm = hw->priv;
+
+	mm->rts_threshold = value;
+	return 0;
+}
+
+static void mm81x_mac_ops_sta_rc_update(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_link_sta *link_sta,
+					u32 changed)
+{
+	struct mm81x *mm = hw->priv;
+	struct ieee80211_sta *sta = link_sta->sta;
+	enum ieee80211_sta_state old_state;
+	enum ieee80211_sta_state new_state;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY,
+		  "Rate control config updated (changed %u, peer address %pM)",
+		  changed, sta->addr);
+
+	if (!(changed & IEEE80211_RC_BW_CHANGED))
+		return;
+
+	/*
+	 * Simulate the disconnection and connection to reinitialize the sta
+	 * in mmrc with new BW
+	 */
+	old_state = IEEE80211_STA_ASSOC;
+	new_state = IEEE80211_STA_NOTEXIST;
+
+	mm81x_dbg(
+		mm, MM81X_DBG_ANY,
+		"Remove sta, old_state=%d, new_state=%d, changed=0x%x, bw_changed=%d",
+		old_state, new_state, changed,
+		(changed & IEEE80211_RC_BW_CHANGED));
+	mutex_lock(&mm->lock);
+
+	mm81x_rc_sta_state_check(mm, vif, sta, old_state, new_state);
+
+	old_state = IEEE80211_STA_NOTEXIST;
+	new_state = IEEE80211_STA_ASSOC;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "Add sta, old_state=%d, new_state=%d",
+		  old_state, new_state);
+
+	mm81x_rc_sta_state_check(mm, vif, sta, old_state, new_state);
+
+	mutex_unlock(&mm->lock);
+}
+
+static void mm81x_mac_ops_sta_statistics(struct ieee80211_hw *hw,
+					 struct ieee80211_vif *vif,
+					 struct ieee80211_sta *sta,
+					 struct station_info *sinfo)
+{
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+	struct mm81x *mm = hw->priv;
+	const struct mmrc_table *tb = msta->rc.tb;
+	struct mmrc_rate rate;
+
+	if (!tb || tb->best_tp.rate == MMRC_MCS_UNUSED) {
+		sinfo->filled &= ~BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+		return;
+	}
+
+	rate = tb->best_tp;
+	sinfo->txrate.mcs = rate.rate;
+	sinfo->txrate.nss = NSS_IDX_TO_NSS(rate.ss);
+	sinfo->txrate.flags = RATE_INFO_FLAGS_S1G_MCS;
+	switch (rate.bw) {
+	case MMRC_BW_1MHZ:
+		sinfo->txrate.bw = RATE_INFO_BW_1;
+		break;
+	case MMRC_BW_2MHZ:
+		sinfo->txrate.bw = RATE_INFO_BW_2;
+		break;
+	case MMRC_BW_4MHZ:
+		sinfo->txrate.bw = RATE_INFO_BW_4;
+		break;
+	case MMRC_BW_8MHZ:
+		sinfo->txrate.bw = RATE_INFO_BW_8;
+		break;
+	default:
+		break;
+	}
+
+	if (rate.guard == MMRC_GUARD_SHORT)
+		sinfo->txrate.flags |= (RATE_INFO_FLAGS_SHORT_GI);
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "mcs: %d, bw: %d, flag: 0x%x", rate.rate,
+		  rate.bw, sinfo->txrate.flags);
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+}
+
+static u32 mm81x_get_expected_throughput(struct ieee80211_hw *hw,
+					 struct ieee80211_sta *sta)
+{
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+	struct mm81x *mm = hw->priv;
+	const struct mmrc_table *tb = msta->rc.tb;
+	struct mmrc_rate rate;
+	u32 tput;
+
+	if (!tb || tb->best_tp.rate == MMRC_MCS_UNUSED)
+		return 0;
+
+	rate = tb->best_tp;
+	tput = BPS_TO_KBPS(mmrc_calculate_theoretical_throughput(rate));
+	mm81x_dbg(mm, MM81X_DBG_ANY,
+		  "Throughput: MCS: %d, BW: %d, GI: %d -> %u", rate.rate,
+		  1 << rate.bw, rate.guard, tput);
+
+	return tput;
+}
+
+static void mm81x_mac_restart_cleanup_iter(void *data, u8 *mac,
+					   struct ieee80211_vif *vif)
+{
+	if (vif->type == NL80211_IFTYPE_AP)
+		mm81x_mac_beacon_finish((struct mm81x_vif *)vif->drv_priv);
+}
+
+static void mm81x_mac_restart_cleanup(struct mm81x *mm)
+{
+	ieee80211_iterate_active_interfaces(mm->hw, IEEE80211_IFACE_ITER_NORMAL,
+					    mm81x_mac_restart_cleanup_iter,
+					    NULL);
+	mm81x_mac_hw_scan_finish(mm);
+}
+
+static int mm81x_mac_restart(struct mm81x *mm)
+{
+	int ret;
+	u32 chip_id;
+
+	lockdep_assert_held(&mm->lock);
+
+	mm->started = false;
+	mm81x_ps_disable(mm);
+	mm81x_bus_set_irq(mm, false);
+	mm81x_hw_irq_clear(mm);
+	ieee80211_stop_queues(mm->hw);
+
+	set_bit(MM81X_STATE_DATA_TX_STOPPED, &mm->state_flags);
+	set_bit(MM81X_STATE_DATA_QS_STOPPED, &mm->state_flags);
+
+	/* Allow time for in-transit tx/rx packets to settle */
+	mdelay(MM81X_HW_RESTART_DELAY_MS);
+	flush_work(&mm->hif_work);
+	flush_work(&mm->tx_stale_work);
+	mm81x_hif_clear_events(mm);
+	mm81x_hif_flush_tx_data(mm);
+	mm81x_hif_flush_cmds(mm);
+
+	mm81x_claim_bus(mm);
+	ret = mm81x_reg32_read(mm, MM81X_REG_CHIP_ID(mm), &chip_id);
+	mm81x_release_bus(mm);
+
+	if (ret < 0) {
+		mm81x_err(mm, "Failed to access HW: %d", ret);
+		goto exit;
+	}
+
+	mm81x_mac_restart_cleanup(mm);
+
+	ret = mm81x_fw_init(mm, true);
+	if (ret < 0) {
+		mm81x_err(mm, "Failed to init firmware: %d", ret);
+		goto exit;
+	}
+
+	mm81x_hw_irq_enable(mm, MM81X_INT_HW_STOP_NOTIFICATION_NUM, true);
+
+	ret = mm81x_fw_parse_ext_host_tbl(mm);
+	if (ret) {
+		mm81x_err(mm, "failed to parse extended host table: %d", ret);
+		goto exit;
+	}
+
+	mm81x_mac_caps_init(mm);
+
+	mm81x_bus_set_irq(mm, true);
+	clear_bit(MM81X_STATE_DATA_TX_STOPPED, &mm->state_flags);
+	clear_bit(MM81X_STATE_DATA_QS_STOPPED, &mm->state_flags);
+	clear_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mm->state_flags);
+	clear_bit(MM81X_STATE_RELOAD_FW_AFTER_START, &mm->state_flags);
+	mm81x_mac_check_fw_disabled_chans(mm->hw);
+	ieee80211_restart_hw(mm->hw);
+
+exit:
+	mm81x_ps_enable(mm);
+	return ret;
+}
+
+static int mm81x_mac_ops_add_interface(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif)
+{
+	int ret = 0;
+	struct mm81x *mm = hw->priv;
+	struct mm81x_vif *mm_vif = (struct mm81x_vif *)vif->drv_priv;
+
+	if (test_bit(MM81X_STATE_RELOAD_FW_AFTER_START, &mm->state_flags)) {
+		mm81x_info(mm, "Restarting chip with regdom: %s", mm->country);
+		mutex_lock(&mm->lock);
+
+		ret = mm81x_mac_restart(mm);
+		if (ret) {
+			mm81x_err(mm, "Failed to restart chip");
+			goto exit;
+		}
+
+		mutex_unlock(&mm->lock);
+
+		/*
+		 * mac_restart will trigger ieee80211_hw_restart and
+		 * add_interface will re-enter. just exit here instead.
+		 */
+		return 0;
+	}
+
+	mutex_lock(&mm->lock);
+	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+	mm_vif->u.ap.beaconing_enabled = false;
+	mm_vif->mm = mm;
+
+	ret = mm81x_cmd_add_if(mm, &mm_vif->id, vif->addr, vif->type);
+	if (ret) {
+		mm81x_err(mm, "mm81x_cmd_add_if failed %d", ret);
+		goto exit;
+	}
+
+	if (mm_vif->id >= ARRAY_SIZE(mm->vifs)) {
+		mm81x_err(mm, "vif_id is too large %u", mm_vif->id);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	if (mm_vif->id != (mm_vif->id & MM81X_TX_CONF_FLAGS_VIF_ID_MASK)) {
+		mm81x_err(mm, "invalid vif_id %u", mm_vif->id);
+		ret = -EOPNOTSUPP;
+		goto exit;
+	}
+
+	rcu_assign_pointer(mm->vifs[mm_vif->id], vif);
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		mm81x_mac_beacon_init(mm_vif);
+
+	ret = mm81x_cmd_get_capabilities(mm, mm_vif->id, &mm->fw_caps);
+	if (ret) {
+		mm81x_err(mm, "mm81x_cmd_get_capabilities failed for vif %d",
+			  mm_vif->id);
+		goto exit;
+	}
+
+	ieee80211_wake_queues(mm->hw);
+exit:
+	mutex_unlock(&mm->lock);
+	return ret;
+}
+
+static const struct ieee80211_ops mm81x_ops = {
+	.start = mm81x_mac_ops_start,
+	.stop = mm81x_mac_ops_stop,
+	.config = mm81x_mac_ops_config,
+	.wake_tx_queue = ieee80211_handle_wake_tx_queue,
+	.tx = mm81x_mac_ops_tx,
+	.add_interface = mm81x_mac_ops_add_interface,
+	.remove_interface = mm81x_mac_ops_remove_interface,
+	.configure_filter = mm81x_mac_ops_configure_filter,
+	.sta_state = mm81x_mac_ops_sta_state,
+	.flush = mm81x_mac_ops_flush,
+	.set_frag_threshold = mm81x_mac_set_frag_threshold,
+	.set_rts_threshold = mm81x_mac_ops_set_rts_threshold,
+	.link_sta_rc_update = mm81x_mac_ops_sta_rc_update,
+	.sta_statistics = mm81x_mac_ops_sta_statistics,
+	.get_expected_throughput = mm81x_get_expected_throughput,
+	.hw_scan = mm81x_mac_ops_hw_scan,
+	.cancel_hw_scan = mm81x_mac_ops_cancel_hw_scan,
+	.get_txpower = mm81x_mac_ops_get_txpower,
+	.bss_info_changed = mm81x_mac_ops_bss_info_changed,
+	.prepare_multicast = mm81x_mac_ops_prepare_multicast,
+	.conf_tx = mm81x_mac_ops_conf_tx,
+	.ampdu_action = mm81x_mac_ops_ampdu_action,
+	.set_key = mm81x_mac_ops_set_key,
+	.add_chanctx = mm81x_mac_ops_add_chanctx,
+	.remove_chanctx = mm81x_mac_ops_remove_chanctx,
+	.change_chanctx = mm81x_mac_ops_change_chanctx,
+	.assign_vif_chanctx = mm81x_mac_ops_assign_vif_chanctx,
+	.unassign_vif_chanctx = mm81x_mac_ops_unassign_vif_chanctx,
+};
+
+struct mm81x *mm81x_mac_create(size_t priv_size, struct device *dev)
+{
+	struct ieee80211_hw *hw;
+	struct mm81x *mm;
+
+	hw = ieee80211_alloc_hw(sizeof(*mm) + priv_size, &mm81x_ops);
+	if (!hw) {
+		dev_err(dev, "ieee80211_alloc_hw failed\r\n");
+		return NULL;
+	}
+
+	SET_IEEE80211_DEV(hw, dev);
+	memset(hw->priv, 0, sizeof(*mm));
+
+	mm = hw->priv;
+	mm->hw = hw;
+	mm->dev = dev;
+	mutex_init(&mm->lock);
+	mutex_init(&mm->cmd_lock);
+	mutex_init(&mm->cmd_wait);
+
+	return mm;
+}
+
+static void mm81x_reg_notifier(struct wiphy *wiphy,
+			       struct regulatory_request *request)
+{
+	int ret;
+	struct mm81x *mm = wiphy_to_ieee80211_hw(wiphy)->priv;
+
+	if (mm81x_reg_h_cc_equal(request->alpha2, mm->country))
+		return;
+
+	memcpy(mm->country, request->alpha2, sizeof(mm->country));
+
+	mutex_lock(&mm->lock);
+
+	ret = mm81x_mac_restart(mm);
+	if (ret) {
+		mm81x_err(mm, "Failed to restart chip: %d", ret);
+		dump_stack();
+	}
+
+	mutex_unlock(&mm->lock);
+}
+
+static void mm81x_mac_config_hw(struct mm81x *mm)
+{
+	int i;
+	struct ieee80211_hw *hw = mm->hw;
+	struct wiphy *wiphy;
+
+	for (i = 0; i < NUM_NL80211_BANDS; i++)
+		hw->wiphy->bands[i] = NULL;
+
+	hw->wiphy->bands[NL80211_BAND_S1GHZ] = &mm_band_s1ghz;
+	hw->wiphy->interface_modes = BIT(NL80211_IFTYPE_AP) |
+				     BIT(NL80211_IFTYPE_STATION);
+	hw->wiphy->reg_notifier = mm81x_reg_notifier;
+	hw->queues = MM81X_HW_QUEUE_COUNT;
+	hw->max_rates = MM81X_HW_MAX_RATES;
+	hw->max_report_rates = MM81X_HW_MAX_REPORT_RATES;
+	hw->max_rate_tries = MM81X_HW_MAX_RATE_TRIES;
+	hw->tx_sk_pacing_shift = MM81X_HW_TX_SK_PACING_SHIFT;
+	hw->vif_data_size = sizeof(struct mm81x_vif);
+	hw->sta_data_size = sizeof(struct mm81x_sta);
+	hw->extra_tx_headroom =
+		sizeof(struct mm81x_skb_hdr) + mm81x_bus_get_alignment(mm);
+
+	mm->wiphy = hw->wiphy;
+
+	ieee80211_hw_set(hw, SIGNAL_DBM);
+	ieee80211_hw_set(hw, MFP_CAPABLE);
+	ieee80211_hw_set(hw, REPORTS_TX_ACK_STATUS);
+	ieee80211_hw_set(hw, AMPDU_AGGREGATION);
+	ieee80211_hw_set(hw, HOST_BROADCAST_PS_BUFFERING);
+	ieee80211_hw_set(hw, HAS_RATE_CONTROL);
+	ieee80211_hw_set(hw, SUPPORTS_PS);
+	ieee80211_hw_set(hw, NEED_DTIM_BEFORE_ASSOC);
+	ieee80211_hw_set(hw, PS_NULLFUNC_STACK);
+	ieee80211_hw_set(hw, SUPPORTS_TX_FRAG);
+
+	SET_IEEE80211_PERM_ADDR(hw, mm->macaddr);
+
+	wiphy = mm->wiphy;
+
+	wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
+	wiphy->flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
+
+	if (!mm->ps.enable)
+		wiphy->flags &= ~WIPHY_FLAG_PS_ON_BY_DEFAULT;
+
+	wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
+			   NL80211_FEATURE_TX_POWER_INSERTION;
+
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_AIRTIME_FAIRNESS);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_SET_SCAN_DWELL);
+
+	wiphy->iface_combinations = mm_if_combs;
+	wiphy->n_iface_combinations = ARRAY_SIZE(mm_if_combs);
+	wiphy->max_scan_ie_len = MM81X_MAX_SCAN_IE_LEN;
+	wiphy->max_scan_ssids = MM81X_MAX_SCAN_SSIDS;
+	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
+	wiphy->max_remain_on_channel_duration =
+		MM81X_MAX_REMAIN_ON_CHAN_DURATION;
+}
+
+static void mm81x_stale_tx_status_timer(struct timer_list *t)
+{
+	struct mm81x *mm = timer_container_of(mm, t, stale_status.timer);
+
+	spin_lock_bh(&mm->stale_status.lock);
+	if (mm81x_hif_get_tx_status_pending_count(mm))
+		queue_work(mm->net_wq, &mm->tx_stale_work);
+	spin_unlock_bh(&mm->stale_status.lock);
+}
+
+static void mm81x_stale_tx_status_timer_finish(struct mm81x *mm)
+{
+	timer_delete_sync_try(&mm->stale_status.timer);
+}
+
+static void mm81x_mac_stale_tx_status_timer_init(struct mm81x *mm)
+{
+	spin_lock_init(&mm->stale_status.lock);
+	timer_setup(&mm->stale_status.timer, mm81x_stale_tx_status_timer, 0);
+}
+
+static int mm81x_mac_init(struct mm81x *mm)
+{
+	int ret;
+
+	mm->tx_power_mbm = INT_MAX;
+	mm->tx_max_power_mbm = INT_MAX;
+	mm->rts_threshold = IEEE80211_MAX_RTS_THRESHOLD;
+
+	ret = mm81x_ps_init(mm);
+	if (ret < 0)
+		return ret;
+
+	mm81x_mac_config_hw(mm);
+	mm81x_mac_hw_scan_init(mm);
+	mm81x_mac_stale_tx_status_timer_init(mm);
+
+	return 0;
+}
+
+int mm81x_mac_register(struct mm81x *mm)
+{
+	int ret;
+	struct ieee80211_hw *hw = mm->hw;
+
+	ret = mm81x_mac_init(mm);
+	if (ret) {
+		mm81x_err(mm, "mm81x_mac_init failed %d", ret);
+		return ret;
+	}
+
+	ret = ieee80211_register_hw(hw);
+	if (ret) {
+		mm81x_err(mm, "ieee80211_register_hw failed %d", ret);
+		mm81x_mac_unregister(mm);
+		return ret;
+	}
+
+	mm81x_rc_init(mm);
+
+	/*
+	 * At this stage, we know bus and pager system interrupts are enabled.
+	 * Trigger the receive workqueue to drain any incoming chip-to-host
+	 * pending packets been pushed in the period between the firmware
+	 * initialization and interrupts being enabled.
+	 */
+	set_bit(MM81X_HIF_EVT_RX_PEND, &mm->hif.event_flags);
+	queue_work(mm->chip_wq, &mm->hif_work);
+
+	return ret;
+}
+
+static void mm81x_ieee80211_deinit(struct mm81x *mm)
+{
+	ieee80211_stop_queues(mm->hw);
+	ieee80211_unregister_hw(mm->hw);
+}
+
+static void mm81x_mac_deinit(struct mm81x *mm)
+{
+	mm81x_ieee80211_deinit(mm);
+	mm81x_hif_flush_tx_data(mm);
+	mm81x_hif_flush_cmds(mm);
+}
+
+void mm81x_mac_unregister(struct mm81x *mm)
+{
+	mm81x_ps_disable(mm);
+	mm81x_rc_deinit(mm);
+	mm81x_mac_hw_scan_destroy(mm);
+	mm81x_mac_deinit(mm);
+	mm81x_stale_tx_status_timer_finish(mm);
+	mm81x_ps_finish(mm);
+}
+
+void mm81x_mac_destroy(struct mm81x *mm)
+{
+	ieee80211_free_hw(mm->hw);
+}
-- 
2.43.0


