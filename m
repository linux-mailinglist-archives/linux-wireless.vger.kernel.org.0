Return-Path: <linux-wireless+bounces-30786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 932F2D1B421
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2B4C3017123
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6F32F0673;
	Tue, 13 Jan 2026 20:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="aOj/pSJW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F00C276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336894; cv=none; b=Iuv9iIWSg8tGdQ+BBYeIHR7mBJcxRfD+fDjsOAlcZDLZiOWhcxiDrjiB69f7bGk+oc/cZHd89zpBAlQNos7H+BcVYOb4lnvxmS3wjJQIG8mL/BEOmZ5VTmDrno3Ms0Ep/BzZE5LgNXPy6Sbm/FiFlEvW/sGo1+XNRXfs/PVYuHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336894; c=relaxed/simple;
	bh=W/30Ii2oyAvpn/L/oUjgQ+WG3Fk8Pvt3AIhUgJQv6lg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxrEm4Dinh+JU2JTYond2lur70XApWGsU7KloGzLuFIfoiYU+XSzgj2QPKJ4b9GtSizZaHn5R8wllB0LxNnF9M4QODvYgjNx20wvFrCGIzbS8DGT5YRYSIFBlyXMzl699Uz7KBVixaQlHv38vnSH7TfRREbvtS1rb9DxRTt7t6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=aOj/pSJW; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336892; x=1799872892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W/30Ii2oyAvpn/L/oUjgQ+WG3Fk8Pvt3AIhUgJQv6lg=;
  b=aOj/pSJWab7bX2lZ3KmcUVFp1JUJtunDjw1WDFvhBtpeQPIeDE8De+yS
   LIHsgpcFQ63LiXKdDIuf+/830IvG6q8kYupFRjg30XGnJYFi68s8apWz9
   5jMIlw1Hnx8DD3QHCe70N1BfVxaxXdZ6eKyyKQ5IMdD2SZOv55ox7WMEe
   g=;
X-CSE-ConnectionGUID: GdpuyuknTjClIuHCn0K4JA==
X-CSE-MsgGUID: mDq5KNQETLuptP8uosZ/4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="113628531"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="113628531"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:41:29 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:41:29 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:41:27 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 31/34] wifi: inffmac: add chan.c/h
Date: Wed, 14 Jan 2026 02:03:44 +0530
Message-ID: <20260113203350.16734-32-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

Common definitions of the wifi channel and chanspec specific structures,
MACROs and helper functions.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/chan.c | 982 +++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/chan.h | 356 +++++++
 2 files changed, 1338 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chan.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chan.h

diff --git a/drivers/net/wireless/infineon/inffmac/chan.c b/drivers/net/wireless/infineon/inffmac/chan.c
new file mode 100644
index 000000000000..9b367931d59f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chan.c
@@ -0,0 +1,982 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2013 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/module.h>
+#include <net/cfg80211.h>
+
+#include "cfg80211.h"
+#include "interface.h"
+#include "chan.h"
+#include "utils.h"
+#include "debug.h"
+#include "dev_cmd.h"
+#include "feature.h"
+
+#define INFF_MAX_CHANSPEC_LIST \
+	(INFF_DCMD_MEDLEN / sizeof(__le32) - 1)
+
+#define RATE_TO_BASE100KBPS(rate)   (((rate) * 10) / 2)
+#define RATETAB_ENT(_bitrate, _rateid, _flags) \
+	{                                                               \
+		.bitrate        = (_bitrate),     \
+		.hw_value       = (_rateid),                            \
+		.flags          = (_flags),                             \
+	}
+
+static struct ieee80211_rate __wl_rates[] = {
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_1M), INF_RATE_1M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_2M), INF_RATE_2M, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_5M5), INF_RATE_5M5, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_11M), INF_RATE_11M, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_6M), INF_RATE_6M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_9M), INF_RATE_9M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_12M), INF_RATE_12M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_18M), INF_RATE_18M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_24M), INF_RATE_24M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_36M), INF_RATE_36M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_48M), INF_RATE_48M, 0),
+	RATETAB_ENT(RATE_TO_BASE100KBPS(INF_RATE_54M), INF_RATE_54M, 0),
+};
+
+#define wl_g_rates		(__wl_rates + 0)
+#define wl_g_rates_size		ARRAY_SIZE(__wl_rates)
+#define wl_a_rates		(__wl_rates + 4)
+#define wl_a_rates_size		(wl_g_rates_size - 4)
+
+#define CHAN2G(_channel, _freq) {				\
+	.band			= NL80211_BAND_2GHZ,		\
+	.center_freq		= (_freq),			\
+	.hw_value		= (_channel),			\
+	.max_antenna_gain	= 0,				\
+	.max_power		= 30,				\
+}
+
+#define CH5G_FREQ(_channel)	(5000 + (5 * (_channel)))
+#define CHAN5G(_channel, _freq) {					\
+	.band			= NL80211_BAND_5GHZ,		\
+	.center_freq		= (_freq),	\
+	.hw_value		= (_channel),			\
+	.max_antenna_gain	= 0,				\
+	.max_power		= 30,				\
+}
+
+#define CH6G_FREQ(_channel)	(5950 + (5 * (_channel)))
+#define CHAN6G(_channel, _freq) {				\
+	.band			= NL80211_BAND_6GHZ,		\
+	.center_freq		= (_freq),	\
+	.hw_value		= (_channel),			\
+	.max_antenna_gain	= 0,				\
+	.max_power		= 30,				\
+}
+
+static struct ieee80211_channel __wl_2ghz_channels[] = {
+	CHAN2G(1, 2412), CHAN2G(2, 2417), CHAN2G(3, 2422), CHAN2G(4, 2427),
+	CHAN2G(5, 2432), CHAN2G(6, 2437), CHAN2G(7, 2442), CHAN2G(8, 2447),
+	CHAN2G(9, 2452), CHAN2G(10, 2457), CHAN2G(11, 2462), CHAN2G(12, 2467),
+	CHAN2G(13, 2472), CHAN2G(14, 2484)
+};
+
+static struct ieee80211_channel __wl_5ghz_channels[] = {
+	CHAN5G(34, CH5G_FREQ(34)), CHAN5G(36, CH5G_FREQ(36)), CHAN5G(38, CH5G_FREQ(38)),
+	CHAN5G(40, CH5G_FREQ(40)), CHAN5G(42, CH5G_FREQ(42)), CHAN5G(44, CH5G_FREQ(44)),
+	CHAN5G(46, CH5G_FREQ(46)), CHAN5G(48, CH5G_FREQ(48)), CHAN5G(52, CH5G_FREQ(52)),
+	CHAN5G(56, CH5G_FREQ(56)), CHAN5G(60, CH5G_FREQ(60)), CHAN5G(64, CH5G_FREQ(64)),
+	CHAN5G(100, CH5G_FREQ(100)), CHAN5G(104, CH5G_FREQ(104)), CHAN5G(108, CH5G_FREQ(108)),
+	CHAN5G(112, CH5G_FREQ(112)), CHAN5G(116, CH5G_FREQ(116)), CHAN5G(120, CH5G_FREQ(120)),
+	CHAN5G(124, CH5G_FREQ(124)), CHAN5G(128, CH5G_FREQ(128)), CHAN5G(132, CH5G_FREQ(132)),
+	CHAN5G(136, CH5G_FREQ(136)), CHAN5G(140, CH5G_FREQ(140)), CHAN5G(144, CH5G_FREQ(144)),
+	CHAN5G(149, CH5G_FREQ(149)), CHAN5G(153, CH5G_FREQ(153)), CHAN5G(157, CH5G_FREQ(157)),
+	CHAN5G(161, CH5G_FREQ(161)), CHAN5G(165, CH5G_FREQ(165))
+};
+
+static struct ieee80211_channel __wl_6ghz_channels[] = {
+	CHAN6G(1, CH6G_FREQ(1)), CHAN6G(5, CH6G_FREQ(5)), CHAN6G(9, CH6G_FREQ(9)),
+	CHAN6G(13, CH6G_FREQ(13)), CHAN6G(17, CH6G_FREQ(17)),
+	CHAN6G(21, CH6G_FREQ(21)), CHAN6G(25, CH6G_FREQ(25)), CHAN6G(29, CH6G_FREQ(29)),
+	CHAN6G(33, CH6G_FREQ(33)), CHAN6G(37, CH6G_FREQ(37)),
+	CHAN6G(41, CH6G_FREQ(41)), CHAN6G(45, CH6G_FREQ(45)), CHAN6G(49, CH6G_FREQ(49)),
+	CHAN6G(53, CH6G_FREQ(53)), CHAN6G(57, CH6G_FREQ(57)),
+	CHAN6G(61, CH6G_FREQ(61)), CHAN6G(65, CH6G_FREQ(65)), CHAN6G(69, CH6G_FREQ(69)),
+	CHAN6G(73, CH6G_FREQ(73)), CHAN6G(77, CH6G_FREQ(77)),
+	CHAN6G(81, CH6G_FREQ(81)), CHAN6G(85, CH6G_FREQ(85)), CHAN6G(89, CH6G_FREQ(89)),
+	CHAN6G(93, CH6G_FREQ(93)), CHAN6G(97, CH6G_FREQ(97)),
+	CHAN6G(101, CH6G_FREQ(101)), CHAN6G(105, CH6G_FREQ(105)), CHAN6G(109, CH6G_FREQ(109)),
+	CHAN6G(113, CH6G_FREQ(113)), CHAN6G(117, CH6G_FREQ(117)),
+	CHAN6G(121, CH6G_FREQ(121)), CHAN6G(125, CH6G_FREQ(125)), CHAN6G(129, CH6G_FREQ(129)),
+	CHAN6G(133, CH6G_FREQ(133)), CHAN6G(137, CH6G_FREQ(137)),
+	CHAN6G(141, CH6G_FREQ(141)), CHAN6G(145, CH6G_FREQ(145)), CHAN6G(149, CH6G_FREQ(149)),
+	CHAN6G(153, CH6G_FREQ(153)), CHAN6G(157, CH6G_FREQ(157)),
+	CHAN6G(161, CH6G_FREQ(161)), CHAN6G(165, CH6G_FREQ(165)), CHAN6G(169, CH6G_FREQ(169)),
+	CHAN6G(173, CH6G_FREQ(173)), CHAN6G(177, CH6G_FREQ(177)),
+	CHAN6G(181, CH6G_FREQ(181)), CHAN6G(185, CH6G_FREQ(185)), CHAN6G(189, CH6G_FREQ(189)),
+	CHAN6G(193, CH6G_FREQ(193)), CHAN6G(197, CH6G_FREQ(197)),
+	CHAN6G(201, CH6G_FREQ(201)), CHAN6G(205, CH6G_FREQ(205)), CHAN6G(209, CH6G_FREQ(209)),
+	CHAN6G(213, CH6G_FREQ(213)), CHAN6G(217, CH6G_FREQ(217)),
+	CHAN6G(221, CH6G_FREQ(221)), CHAN6G(225, CH6G_FREQ(225)), CHAN6G(229, CH6G_FREQ(229)),
+	CHAN6G(233, CH6G_FREQ(233))
+};
+
+/* Band templates duplicated per wiphy. The channel info
+ * above is added to the band during setup.
+ */
+static const struct ieee80211_supported_band __wl_band_2ghz = {
+	.band = NL80211_BAND_2GHZ,
+	.bitrates = wl_g_rates,
+	.n_bitrates = wl_g_rates_size,
+};
+
+static const struct ieee80211_supported_band __wl_band_5ghz = {
+	.band = NL80211_BAND_5GHZ,
+	.bitrates = wl_a_rates,
+	.n_bitrates = wl_a_rates_size,
+};
+
+static struct ieee80211_supported_band __wl_band_6ghz = {
+	.band = NL80211_BAND_6GHZ,
+	.bitrates = wl_a_rates,
+	.n_bitrates = wl_a_rates_size,
+};
+
+enum nl80211_band
+inff_chan_band_to_nl80211(u8 band)
+{
+	if (band == INFF_CHAN_BAND_2G)
+		return NL80211_BAND_2GHZ;
+	else if (band == INFF_CHAN_BAND_5G)
+		return NL80211_BAND_5GHZ;
+	else
+		return NL80211_BAND_6GHZ;
+}
+
+u8
+inff_nl80211_band_to_fwil(enum nl80211_band band)
+{
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		return WLC_BAND_2G;
+	case NL80211_BAND_5GHZ:
+		return WLC_BAND_5G;
+	case NL80211_BAND_6GHZ:
+		return WLC_BAND_6G;
+	default:
+		WARN_ON(1);
+		break;
+	}
+	return 0;
+}
+
+static u16
+inff_chan_bw_to_chspec_bw(enum inff_chan_bw bw)
+{
+	switch (bw) {
+	case INFF_CHAN_BW_20:
+		return INFF_CHSPEC_BW_20;
+	case INFF_CHAN_BW_40:
+		return INFF_CHSPEC_BW_40;
+	case INFF_CHAN_BW_80:
+		return INFF_CHSPEC_BW_80;
+	case INFF_CHAN_BW_160:
+		return INFF_CHSPEC_BW_160;
+	default:
+		WARN_ON(1);
+	}
+	return 0;
+}
+
+/*
+ * inff_chan_encchspec: encodes channel info into a chanspec, requires center channel
+ *	number, ignores control one
+ */
+void
+inff_chan_encchspec(struct inff_chan *ch)
+{
+	if (ch->bw == INFF_CHAN_BW_20 || ch->sb == INFF_CHAN_SB_NONE)
+		ch->sb = INFF_CHAN_SB_L;
+
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_CH_MASK,
+		       INFF_CHSPEC_CH_SHIFT, ch->chnum);
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_SB_MASK,
+		       INFF_CHSPEC_SB_SHIFT, ch->sb);
+	inff_maskset16(&ch->chspec, INFF_CHSPEC_BW_MASK,
+		       0, inff_chan_bw_to_chspec_bw(ch->bw));
+
+	ch->chspec &= ~INFF_CHSPEC_BND_MASK;
+	switch (ch->band) {
+	case INFF_CHAN_BAND_6G:
+		ch->chspec |= INFF_CHSPEC_BND_6G;
+		break;
+	case INFF_CHAN_BAND_5G:
+		ch->chspec |= INFF_CHSPEC_BND_5G;
+		break;
+	case INFF_CHAN_BAND_2G:
+		ch->chspec |= INFF_CHSPEC_BND_2G;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid band 0x%04x\n", ch->band);
+		break;
+	}
+}
+
+/*
+ * inff_chan_decchspec: decodes chanspec into generic info
+ */
+void
+inff_chan_decchspec(struct inff_chan *ch)
+{
+	u16 val;
+
+	ch->chnum = (u8)(ch->chspec & INFF_CHSPEC_CH_MASK);
+	ch->control_ch_num = ch->chnum;
+
+	switch (ch->chspec & INFF_CHSPEC_BW_MASK) {
+	case INFF_CHSPEC_BW_20:
+		ch->bw = INFF_CHAN_BW_20;
+		ch->sb = INFF_CHAN_SB_NONE;
+		break;
+	case INFF_CHSPEC_BW_40:
+		ch->bw = INFF_CHAN_BW_40;
+		val = ch->chspec & INFF_CHSPEC_SB_MASK;
+		if (val == INFF_CHSPEC_SB_L) {
+			ch->sb = INFF_CHAN_SB_L;
+			ch->control_ch_num -= CH_10MHZ_APART;
+		} else if (val == INFF_CHSPEC_SB_U) {
+			ch->sb = INFF_CHAN_SB_U;
+			ch->control_ch_num += CH_10MHZ_APART;
+		} else {
+			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		}
+		break;
+	case INFF_CHSPEC_BW_80:
+		ch->bw = INFF_CHAN_BW_80;
+		ch->sb = inff_maskget16(ch->chspec, INFF_CHSPEC_SB_MASK,
+					INFF_CHSPEC_SB_SHIFT);
+		switch (ch->sb) {
+		case INFF_CHAN_SB_LL:
+			ch->control_ch_num -= CH_30MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LU:
+			ch->control_ch_num -= CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UL:
+			ch->control_ch_num += CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UU:
+			ch->control_ch_num += CH_30MHZ_APART;
+			break;
+		default:
+			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+			break;
+		}
+		break;
+	case INFF_CHSPEC_BW_160:
+		ch->bw = INFF_CHAN_BW_160;
+		ch->sb = inff_maskget16(ch->chspec, INFF_CHSPEC_SB_MASK,
+					INFF_CHSPEC_SB_SHIFT);
+		switch (ch->sb) {
+		case INFF_CHAN_SB_LLL:
+			ch->control_ch_num -= CH_70MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LLU:
+			ch->control_ch_num -= CH_50MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LUL:
+			ch->control_ch_num -= CH_30MHZ_APART;
+			break;
+		case INFF_CHAN_SB_LUU:
+			ch->control_ch_num -= CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_ULL:
+			ch->control_ch_num += CH_10MHZ_APART;
+			break;
+		case INFF_CHAN_SB_ULU:
+			ch->control_ch_num += CH_30MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UUL:
+			ch->control_ch_num += CH_50MHZ_APART;
+			break;
+		case INFF_CHAN_SB_UUU:
+			ch->control_ch_num += CH_70MHZ_APART;
+			break;
+		default:
+			WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+			break;
+		}
+		break;
+	case INFF_CHSPEC_BW_8080:
+	default:
+		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		break;
+	}
+
+	switch (ch->chspec & INFF_CHSPEC_BND_MASK) {
+	case INFF_CHSPEC_BND_6G:
+		ch->band = INFF_CHAN_BAND_6G;
+		break;
+	case INFF_CHSPEC_BND_5G:
+		ch->band = INFF_CHAN_BAND_5G;
+		break;
+	case INFF_CHSPEC_BND_2G:
+		ch->band = INFF_CHAN_BAND_2G;
+		break;
+	default:
+		WARN_ONCE(1, "Invalid chanspec 0x%04x\n", ch->chspec);
+		break;
+	}
+}
+
+void
+inff_chan_update_bw40_channel_flag(struct ieee80211_channel *channel,
+				   struct inff_chan *ch)
+{
+	u32 ht40_flag;
+
+	ht40_flag = channel->flags & IEEE80211_CHAN_NO_HT40;
+	if (ch->sb == INFF_CHAN_SB_U) {
+		if (ht40_flag == IEEE80211_CHAN_NO_HT40)
+			channel->flags &= ~IEEE80211_CHAN_NO_HT40;
+		channel->flags |= IEEE80211_CHAN_NO_HT40PLUS;
+	} else {
+		/* It should be one of
+		 * IEEE80211_CHAN_NO_HT40 or
+		 * IEEE80211_CHAN_NO_HT40PLUS
+		 */
+		channel->flags &= ~IEEE80211_CHAN_NO_HT40;
+		if (ht40_flag == IEEE80211_CHAN_NO_HT40)
+			channel->flags |= IEEE80211_CHAN_NO_HT40MINUS;
+	}
+}
+
+int
+inff_chan_enable_bw40_2g(struct inff_cfg80211_info *cfg)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	struct ieee80211_supported_band *band;
+	struct inff_fwcmd_bwcap_le band_bwcap;
+	struct inff_chanspec_list *list;
+	u8 *pbuf;
+	u32 val;
+	int err;
+	struct inff_chan ch;
+	u32 num_chan;
+	int i, j;
+
+	/* verify support for bw_cap command */
+	val = WLC_BAND_5G;
+	err = inff_fwcmd_iovar_int_get(ifp, "bw_cap", &val);
+
+	if (!err) {
+		/* only set 2G bandwidth using bw_cap command */
+		band_bwcap.band = cpu_to_le32(WLC_BAND_2G);
+		band_bwcap.bw_cap = cpu_to_le32(WLC_BW_CAP_40MHZ);
+		err = inff_fwcmd_iovar_data_set(ifp, "bw_cap", &band_bwcap,
+						sizeof(band_bwcap));
+	} else {
+		inff_dbg(INFO, "fallback to mimo_bw_cap\n");
+		val = WLC_N_BW_40ALL;
+		err = inff_fwcmd_iovar_int_set(ifp, "mimo_bw_cap", val);
+	}
+
+	if (!err) {
+		/* update channel info in 2G band */
+		pbuf = kzalloc(INFF_DCMD_MEDLEN, GFP_KERNEL);
+
+		if (!pbuf)
+			return -ENOMEM;
+
+		ch.band = INFF_CHAN_BAND_2G;
+		ch.bw = INFF_CHAN_BW_40;
+		ch.sb = INFF_CHAN_SB_NONE;
+		ch.chnum = 0;
+		inff_chan_encchspec(&ch);
+
+		/* pass encoded chanspec in query */
+		*(__le16 *)pbuf = cpu_to_le16(ch.chspec);
+
+		err = inff_fwcmd_iovar_data_get(ifp, "chanspecs", pbuf,
+						INFF_DCMD_MEDLEN);
+		if (err) {
+			iphy_err(drvr, "get chanspecs error (%d)\n", err);
+			kfree(pbuf);
+			return err;
+		}
+
+		band = cfg->wiphy->bands[NL80211_BAND_2GHZ];
+		list = (struct inff_chanspec_list *)pbuf;
+		num_chan = le32_to_cpu(list->count);
+		if (num_chan > INFF_MAX_CHANSPEC_LIST) {
+			iphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
+				 num_chan);
+			kfree(pbuf);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < num_chan; i++) {
+			ch.chspec = (u16)le32_to_cpu(list->element[i]);
+			inff_chan_decchspec(&ch);
+			if (WARN_ON(ch.band != INFF_CHAN_BAND_2G))
+				continue;
+			if (WARN_ON(ch.bw != INFF_CHAN_BW_40))
+				continue;
+			for (j = 0; j < band->n_channels; j++) {
+				if (band->channels[j].hw_value == ch.control_ch_num)
+					break;
+			}
+			if (WARN_ON(j == band->n_channels))
+				continue;
+
+			inff_chan_update_bw40_channel_flag(&band->channels[j], &ch);
+		}
+		kfree(pbuf);
+	}
+	return err;
+}
+
+s32
+inff_chan_set(struct inff_cfg80211_info *cfg, struct ieee80211_channel *chan)
+{
+	u16 chspec = 0;
+	int err = 0;
+	struct inff_if *ifp = netdev_priv(cfg_to_ndev(cfg));
+
+	if (chan->flags & IEEE80211_CHAN_DISABLED)
+		return -EINVAL;
+
+	/* set_channel */
+	chspec = inff_nl80211_chan_to_chanspec(chan);
+	if (chspec != INVCHANSPEC) {
+		err = inff_fwcmd_iovar_int_set(ifp, "chanspec", chspec);
+		if (err) {
+			inff_err("set chanspec 0x%04x fail, reason %d\n", chspec, err);
+			err = -EINVAL;
+		}
+	} else {
+		inff_err("failed to convert host chanspec to fw chanspec\n");
+		err = -EINVAL;
+	}
+
+	return err;
+}
+
+s32
+inff_chan_set_mchan_config(struct inff_cfg80211_info *cfg)
+{
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp;
+	int ifidx = 0;
+	s32 err = 0;
+	struct inff_assoclist_le assoclist = {0};
+	u8 mac_addr[ETH_ALEN] = {0}, mac_null[ETH_ALEN] = {0};
+	u32 mchan_arg = 0;
+	bool staif_connected = false, apif_connected = false;
+
+	if (!inff_feat_is_enabled(drvr->iflist[0], INFF_FEAT_MCHAN_CONFIG))
+		return 0;
+
+	for (ifidx = 0; ifidx < INFF_MAX_IFS; ifidx++) {
+		ifp = drvr->iflist[ifidx];
+		if (ifp && ifp->vif) {
+			if (ifp->vif->wdev.iftype == NL80211_IFTYPE_STATION) {
+				err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_BSSID, &mac_addr,
+							      sizeof(mac_addr));
+				if (err)
+					iphy_err(drvr, "INFF_C_GET_BSSID fail (%d)\n", err);
+				else if (memcmp(mac_null, mac_addr, ETH_ALEN))
+					staif_connected = true;
+			} else if (ifp->vif->wdev.iftype == NL80211_IFTYPE_AP) {
+				memset(&assoclist, 0, sizeof(assoclist));
+				assoclist.count = cpu_to_le32(INFF_MAX_ASSOCLIST);
+				err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_ASSOCLIST,
+							      &assoclist,
+							      sizeof(assoclist));
+				if (err)
+					iphy_err(drvr, "INFF_C_GET_ASSOCLIST fail (%d)\n", err);
+				else if (le32_to_cpu(assoclist.count) > 0)
+					apif_connected = true;
+			}
+		}
+	}
+
+	if (staif_connected && apif_connected) {
+		inff_dbg(TRACE, "apsta case, set mchan config %d\n", cfg->mchan_conf);
+		switch (cfg->mchan_conf) {
+		case INFF_MCHAN_CONF_DEFAULT:
+			mchan_arg = INFF_MCHAN_SI_ALGO;
+			err = inff_fwcmd_iovar_data_set(drvr->iflist[0], "mchan_algo",
+							&mchan_arg, sizeof(mchan_arg));
+			break;
+		case INFF_MCHAN_CONF_VEDIO:
+			mchan_arg = INFF_MCHAN_ASYMMETRIC_SI_ALGO;
+			err = inff_fwcmd_iovar_data_set(drvr->iflist[0], "mchan_algo",
+							&mchan_arg, sizeof(mchan_arg));
+			break;
+		case INFF_MCHAN_CONF_AUDIO:
+			mchan_arg = INFF_MCHAN_BANDWIDTH_ALGO;
+			err = inff_fwcmd_iovar_data_set(drvr->iflist[0], "mchan_algo",
+							&mchan_arg, sizeof(mchan_arg));
+			if (err)
+				goto cmd_fail;
+			mchan_arg = INFF_MCHAN_BANDWIDTH_VAL;
+			err = inff_fwcmd_iovar_data_set(drvr->iflist[0], "mchan_bw",
+							&mchan_arg, sizeof(mchan_arg));
+			break;
+		default:
+			inff_dbg(TRACE, "unexpected mchan conf %d\n", cfg->mchan_conf);
+			break;
+		}
+cmd_fail:
+		if (err)
+			iphy_err(drvr, "cmd fail while set mchan config (%d)\n", err);
+	}
+
+	return 0;
+}
+
+u16
+inff_nl80211_chandef_to_chanspec(struct cfg80211_chan_def *ch)
+{
+	struct inff_chan ch_inf = {0};
+	s32 primary_offset;
+
+	inff_dbg(TRACE, "chandef: control %d center %d width %d\n",
+		 ch->chan->center_freq, ch->center_freq1, ch->width);
+	ch_inf.chnum = ieee80211_frequency_to_channel(ch->center_freq1);
+	primary_offset = ch->chan->center_freq - ch->center_freq1;
+	switch (ch->width) {
+	case NL80211_CHAN_WIDTH_20:
+	case NL80211_CHAN_WIDTH_20_NOHT:
+		ch_inf.bw = INFF_CHAN_BW_20;
+		WARN_ON(primary_offset != 0);
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		ch_inf.bw = INFF_CHAN_BW_40;
+		if (primary_offset > 0)
+			ch_inf.sb = INFF_CHAN_SB_U;
+		else
+			ch_inf.sb = INFF_CHAN_SB_L;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		ch_inf.bw = INFF_CHAN_BW_80;
+		if (primary_offset == -30)
+			ch_inf.sb = INFF_CHAN_SB_LL;
+		else if (primary_offset == -10)
+			ch_inf.sb = INFF_CHAN_SB_LU;
+		else if (primary_offset == 10)
+			ch_inf.sb = INFF_CHAN_SB_UL;
+		else
+			ch_inf.sb = INFF_CHAN_SB_UU;
+		break;
+	case NL80211_CHAN_WIDTH_160:
+		ch_inf.bw = INFF_CHAN_BW_160;
+		if (primary_offset == -70)
+			ch_inf.sb = INFF_CHAN_SB_LLL;
+		else if (primary_offset == -50)
+			ch_inf.sb = INFF_CHAN_SB_LLU;
+		else if (primary_offset == -30)
+			ch_inf.sb = INFF_CHAN_SB_LUL;
+		else if (primary_offset == -10)
+			ch_inf.sb = INFF_CHAN_SB_LUU;
+		else if (primary_offset == 10)
+			ch_inf.sb = INFF_CHAN_SB_ULL;
+		else if (primary_offset == 30)
+			ch_inf.sb = INFF_CHAN_SB_ULU;
+		else if (primary_offset == 50)
+			ch_inf.sb = INFF_CHAN_SB_UUL;
+		else
+			ch_inf.sb = INFF_CHAN_SB_UUU;
+		break;
+	case NL80211_CHAN_WIDTH_80P80:
+	case NL80211_CHAN_WIDTH_5:
+	case NL80211_CHAN_WIDTH_10:
+	default:
+		WARN_ON_ONCE(1);
+	}
+	switch (ch->chan->band) {
+	case NL80211_BAND_2GHZ:
+		ch_inf.band = INFF_CHAN_BAND_2G;
+		break;
+	case NL80211_BAND_5GHZ:
+		ch_inf.band = INFF_CHAN_BAND_5G;
+		break;
+	case NL80211_BAND_6GHZ:
+		ch_inf.band = INFF_CHAN_BAND_6G;
+		break;
+	case NL80211_BAND_60GHZ:
+	default:
+		WARN_ON_ONCE(1);
+	}
+	inff_chan_encchspec(&ch_inf);
+
+	inff_dbg(TRACE, "chanspec: 0x%x\n", ch_inf.chspec);
+	return ch_inf.chspec;
+}
+
+u16
+inff_nl80211_chan_to_chanspec(struct ieee80211_channel *ch)
+{
+	struct inff_chan ch_inf = {0};
+
+	switch (ch->band) {
+	case NL80211_BAND_2GHZ:
+		ch_inf.band = INFF_CHAN_BAND_2G;
+		break;
+	case NL80211_BAND_5GHZ:
+		ch_inf.band = INFF_CHAN_BAND_5G;
+		break;
+	case NL80211_BAND_6GHZ:
+		ch_inf.band = INFF_CHAN_BAND_6G;
+		break;
+	case NL80211_BAND_60GHZ:
+	default:
+		WARN_ON_ONCE(1);
+	}
+	ch_inf.chnum = ieee80211_frequency_to_channel(ch->center_freq);
+	ch_inf.bw = INFF_CHAN_BW_20;
+	inff_chan_encchspec(&ch_inf);
+
+	return ch_inf.chspec;
+}
+
+void
+inff_nl80211_chan_get_bwcap(struct inff_if *ifp, u32 bw_cap[])
+{
+	struct inff_pub *drvr = ifp->drvr;
+	u32 band, mimo_bwcap;
+	int err;
+
+	band = WLC_BAND_2G;
+	err = inff_fwcmd_iovar_int_get(ifp, "bw_cap", &band);
+	if (!err) {
+		bw_cap[NL80211_BAND_2GHZ] = band;
+		band = WLC_BAND_5G;
+		err = inff_fwcmd_iovar_int_get(ifp, "bw_cap", &band);
+		if (!err) {
+			bw_cap[NL80211_BAND_5GHZ] = band;
+
+			band = WLC_BAND_6G;
+			err = inff_fwcmd_iovar_int_get(ifp, "bw_cap", &band);
+			if (!err) {
+				bw_cap[NL80211_BAND_6GHZ] = band;
+				return;
+			}
+			return;
+		}
+		WARN_ON(1);
+		return;
+	}
+	inff_dbg(INFO, "fallback to mimo_bw_cap info\n");
+	mimo_bwcap = 0;
+	err = inff_fwcmd_iovar_int_get(ifp, "mimo_bw_cap", &mimo_bwcap);
+	if (err)
+		/* assume 20MHz if firmware does not give a clue */
+		mimo_bwcap = WLC_N_BW_20ALL;
+
+	switch (mimo_bwcap) {
+	case WLC_N_BW_40ALL:
+		bw_cap[NL80211_BAND_2GHZ] |= WLC_BW_40MHZ_BIT;
+		fallthrough;
+	case WLC_N_BW_20IN2G_40IN5G:
+		bw_cap[NL80211_BAND_5GHZ] |= WLC_BW_40MHZ_BIT;
+		fallthrough;
+	case WLC_N_BW_20ALL:
+		bw_cap[NL80211_BAND_2GHZ] |= WLC_BW_20MHZ_BIT;
+		bw_cap[NL80211_BAND_5GHZ] |= WLC_BW_20MHZ_BIT;
+		break;
+	default:
+		iphy_err(drvr, "invalid mimo_bw_cap value\n");
+	}
+}
+
+static void
+inff_wiphy_reset_band_and_channel(struct wiphy *wiphy)
+{
+	enum nl80211_band band;
+	struct ieee80211_supported_band *wiphy_band = NULL;
+
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		wiphy_band = wiphy->bands[band];
+		if (!wiphy_band)
+			continue;
+
+		kfree(wiphy_band->channels);
+		wiphy_band->channels = NULL;
+		kfree(wiphy_band);
+		wiphy->bands[band] = NULL;
+	}
+}
+
+int
+inff_fill_band_with_default_chanlist(struct wiphy *wiphy,
+				     struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct ieee80211_supported_band *band;
+	int err, i;
+	__le32 bandlist[4];
+	u32 n_bands;
+
+	err = inff_fwcmd_cmd_data_get(ifp, INFF_C_GET_BANDLIST, &bandlist,
+				      sizeof(bandlist));
+	if (err) {
+		iphy_err(drvr, "could not obtain band info: err=%d\n", err);
+		return err;
+	}
+
+	inff_wiphy_reset_band_and_channel(wiphy);
+
+	n_bands = le32_to_cpu(bandlist[0]);
+	for (i = 1; i <= n_bands && i < ARRAY_SIZE(bandlist); i++) {
+		if (bandlist[i] == cpu_to_le32(WLC_BAND_2G)) {
+			band = kmemdup(&__wl_band_2ghz, sizeof(__wl_band_2ghz),
+				       GFP_KERNEL);
+			if (!band)
+				goto mem_err;
+			band->channels = kmemdup(&__wl_2ghz_channels,
+						 sizeof(__wl_2ghz_channels),
+						 GFP_KERNEL);
+			if (!band->channels)
+				goto mem_err;
+
+			/* restore 2G channels info */
+			band->n_channels = ARRAY_SIZE(__wl_2ghz_channels);
+			wiphy->bands[NL80211_BAND_2GHZ] = band;
+		} else if (bandlist[i] == cpu_to_le32(WLC_BAND_5G)) {
+			band = kmemdup(&__wl_band_5ghz, sizeof(__wl_band_5ghz),
+				       GFP_KERNEL);
+			if (!band)
+				goto mem_err;
+			band->channels = kmemdup(&__wl_5ghz_channels,
+						 sizeof(__wl_5ghz_channels),
+						 GFP_KERNEL);
+			if (!band->channels)
+				goto mem_err;
+
+			/* restore 5G channels info */
+			band->n_channels = ARRAY_SIZE(__wl_5ghz_channels);
+			wiphy->bands[NL80211_BAND_5GHZ] = band;
+		} else if (bandlist[i] == cpu_to_le32(WLC_BAND_6G)) {
+			band = kmemdup(&__wl_band_6ghz, sizeof(__wl_band_6ghz),
+				       GFP_KERNEL);
+			if (!band)
+				goto mem_err;
+			band->channels = kmemdup(&__wl_6ghz_channels,
+						 sizeof(__wl_6ghz_channels),
+						 GFP_KERNEL);
+			if (!band->channels)
+				goto mem_err;
+
+			/* restore 6G channels info */
+			band->n_channels = ARRAY_SIZE(__wl_6ghz_channels);
+			wiphy->bands[NL80211_BAND_6GHZ] = band;
+		}
+	}
+
+	if (wiphy->bands[NL80211_BAND_5GHZ] &&
+	    inff_feat_is_enabled(ifp, INFF_FEAT_DOT11H))
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_DFS_OFFLOAD);
+
+	return 0;
+
+mem_err:
+	inff_wiphy_reset_band_and_channel(wiphy);
+	return -ENOMEM;
+}
+
+static void
+inff_wiphy_rm_disabled_band_and_channel(struct wiphy *wiphy)
+{
+	enum nl80211_band band;
+	struct ieee80211_supported_band *wiphy_band = NULL;
+	struct ieee80211_channel *cur = NULL;
+	struct ieee80211_channel *next = NULL;
+	u32 n_ch = 0;
+	u32 i, j;
+
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		wiphy_band = wiphy->bands[band];
+		if (!wiphy_band)
+			continue;
+
+		n_ch = wiphy_band->n_channels;
+		for (i = 0; i < n_ch;) {
+			cur = &wiphy_band->channels[i];
+			if (cur->flags == IEEE80211_CHAN_DISABLED) {
+				for (j = i; j < n_ch - 1; j++) {
+					cur = &wiphy_band->channels[j];
+					next = &wiphy_band->channels[j + 1];
+					memcpy(cur, next, sizeof(*cur));
+				}
+				n_ch--;
+			} else {
+				i++;
+			}
+		}
+
+		wiphy_band->n_channels = n_ch;
+		if (!n_ch) {
+			kfree(wiphy_band->channels);
+			wiphy_band->channels = NULL;
+			kfree(wiphy_band);
+			wiphy->bands[band] = NULL;
+		}
+	}
+}
+
+int
+inff_nl80211_chan_populate(struct inff_cfg80211_info *cfg,
+			   u32 bw_cap[])
+{
+	struct wiphy *wiphy = cfg->wiphy;
+	struct inff_pub *drvr = cfg->pub;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	struct ieee80211_supported_band *band;
+	struct ieee80211_channel *channel;
+	struct inff_chanspec_list *list;
+	struct inff_chan ch;
+	int err;
+	u8 *pbuf;
+	u32 i, j;
+	u32 total;
+	u32 chaninfo;
+
+	err = inff_fill_band_with_default_chanlist(wiphy, ifp);
+	if (err) {
+		iphy_err(drvr, "could not retrore band and channels: err=%d\n", err);
+		goto fail_pbuf;
+	}
+
+	band = wiphy->bands[NL80211_BAND_2GHZ];
+	if (band) {
+		for (i = 0; i < band->n_channels; i++)
+			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
+	}
+	band = wiphy->bands[NL80211_BAND_5GHZ];
+	if (band) {
+		for (i = 0; i < band->n_channels; i++)
+			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
+	}
+	band = wiphy->bands[NL80211_BAND_6GHZ];
+	if (band) {
+		for (i = 0; i < band->n_channels; i++)
+			band->channels[i].flags = IEEE80211_CHAN_DISABLED;
+	}
+
+	pbuf = kzalloc(INFF_DCMD_MEDLEN, GFP_KERNEL);
+	if (!pbuf)
+		return -ENOMEM;
+
+	err = inff_fwcmd_iovar_data_get(ifp, "chanspecs", pbuf,
+					INFF_DCMD_MEDLEN);
+	if (err) {
+		iphy_err(drvr, "get chanspecs error (%d)\n", err);
+		goto fail_pbuf;
+	}
+
+	list = (struct inff_chanspec_list *)pbuf;
+	total = le32_to_cpu(list->count);
+	if (total > INFF_MAX_CHANSPEC_LIST) {
+		iphy_err(drvr, "Invalid count of channel Spec. (%u)\n",
+			 total);
+		err = -EINVAL;
+		goto fail_pbuf;
+	}
+
+	for (i = 0; i < total; i++) {
+		ch.chspec = (u16)le32_to_cpu(list->element[i]);
+		inff_chan_decchspec(&ch);
+
+		if (ch.band == INFF_CHAN_BAND_2G) {
+			band = wiphy->bands[NL80211_BAND_2GHZ];
+		} else if (ch.band == INFF_CHAN_BAND_5G) {
+			band = wiphy->bands[NL80211_BAND_5GHZ];
+		} else if (ch.band == INFF_CHAN_BAND_6G) {
+			band = wiphy->bands[NL80211_BAND_6GHZ];
+		} else {
+			iphy_err(drvr, "Invalid channel Spec. 0x%x.\n",
+				 ch.chspec);
+			continue;
+		}
+		if (!band)
+			continue;
+		if (!(bw_cap[band->band] & WLC_BW_40MHZ_BIT) &&
+		    ch.bw == INFF_CHAN_BW_40)
+			continue;
+		if (!(bw_cap[band->band] & WLC_BW_80MHZ_BIT) &&
+		    ch.bw == INFF_CHAN_BW_80)
+			continue;
+
+		channel = NULL;
+		for (j = 0; j < band->n_channels; j++) {
+			if (band->channels[j].hw_value == ch.control_ch_num) {
+				channel = &band->channels[j];
+				break;
+			}
+		}
+		if (!channel) {
+			/* It seems firmware supports some channel we never
+			 * considered. Something new in IEEE standard?
+			 */
+			iphy_err(drvr, "Ignoring unexpected firmware channel %d\n",
+				 ch.control_ch_num);
+			continue;
+		}
+
+		if (channel->orig_flags & IEEE80211_CHAN_DISABLED)
+			continue;
+
+		/* assuming the chanspecs order is HT20,
+		 * HT40 upper, HT40 lower, and VHT80.
+		 */
+		switch (ch.bw) {
+		case INFF_CHAN_BW_160:
+			channel->flags &= ~IEEE80211_CHAN_NO_160MHZ;
+			break;
+		case INFF_CHAN_BW_80:
+			channel->flags &= ~IEEE80211_CHAN_NO_80MHZ;
+			break;
+		case INFF_CHAN_BW_40:
+			inff_chan_update_bw40_channel_flag(channel, &ch);
+			break;
+		default:
+			wiphy_warn(wiphy, "Firmware reported unsupported bandwidth %d\n",
+				   ch.bw);
+			fallthrough;
+		case INFF_CHAN_BW_20:
+			/* enable the channel and disable other bandwidths
+			 * for now as mentioned order assure they are enabled
+			 * for subsequent chanspecs.
+			 */
+			channel->flags = IEEE80211_CHAN_NO_HT40 |
+					 IEEE80211_CHAN_NO_80MHZ |
+					 IEEE80211_CHAN_NO_160MHZ;
+			ch.bw = INFF_CHAN_BW_20;
+			inff_chan_encchspec(&ch);
+			chaninfo = ch.chspec;
+			err = inff_fwcmd_bsscfg_int_get(ifp, "per_chan_info",
+							&chaninfo);
+			if (!err) {
+				if (chaninfo & WL_CHAN_RADAR)
+					channel->flags |=
+						(IEEE80211_CHAN_RADAR |
+						 IEEE80211_CHAN_NO_IR);
+				if (chaninfo & WL_CHAN_PASSIVE)
+					channel->flags |=
+						IEEE80211_CHAN_NO_IR;
+			}
+		}
+	}
+
+	/* Remove disabled channels and band to avoid unexpected restore. */
+	inff_wiphy_rm_disabled_band_and_channel(wiphy);
+
+fail_pbuf:
+	kfree(pbuf);
+	return err;
+}
+
diff --git a/drivers/net/wireless/infineon/inffmac/chan.h b/drivers/net/wireless/infineon/inffmac/chan.h
new file mode 100644
index 000000000000..8fd5184527fd
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chan.h
@@ -0,0 +1,356 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_CHAN_H
+#define	INFF_CHAN_H
+
+#include <linux/if_ether.h>
+#include <linux/ieee80211.h>
+#include <linux/nl80211.h>
+
+/*
+ * A chanspec (u16) holds the channel number, band, bandwidth and control
+ * sideband
+ */
+
+/* channel defines */
+#define CH_UPPER_SB			0x01
+#define CH_LOWER_SB			0x02
+#define CH_EWA_VALID			0x04
+#define CH_70MHZ_APART			14
+#define CH_50MHZ_APART			10
+#define CH_30MHZ_APART			6
+#define CH_20MHZ_APART			4
+#define CH_10MHZ_APART			2
+#define CH_5MHZ_APART			1 /* 2G band channels are 5 Mhz apart */
+#define CH_MIN_2G_CHANNEL		1
+#define CH_MAX_2G_CHANNEL		14	/* Max channel in 2G band */
+#define CH_MIN_5G_CHANNEL		34
+
+/* bandstate array indices */
+#define BAND_2G_INDEX		0	/* wlc->bandstate[x] index */
+#define BAND_5G_INDEX		1	/* wlc->bandstate[x] index */
+
+/*
+ * max # supported channels. The max channel no is 216, this is that + 1
+ * rounded up to a multiple of NBBY (8). DO NOT MAKE it > 255: channels are
+ * u8's all over
+ */
+#define	MAXCHANNEL		224
+
+#define WL_CHANSPEC_CHAN_MASK		0x00ff
+#define WL_CHANSPEC_CHAN_SHIFT		0
+
+#define WL_CHANSPEC_CTL_SB_MASK		0x0300
+#define WL_CHANSPEC_CTL_SB_SHIFT	     8
+#define WL_CHANSPEC_CTL_SB_LOWER	0x0100
+#define WL_CHANSPEC_CTL_SB_UPPER	0x0200
+#define WL_CHANSPEC_CTL_SB_NONE		0x0300
+
+#define WL_CHANSPEC_BW_MASK		0x0C00
+#define WL_CHANSPEC_BW_SHIFT		    10
+#define WL_CHANSPEC_BW_10		0x0400
+#define WL_CHANSPEC_BW_20		0x0800
+#define WL_CHANSPEC_BW_40		0x0C00
+#define WL_CHANSPEC_BW_80		0x2000
+
+#define WL_CHANSPEC_BAND_MASK		0xf000
+#define WL_CHANSPEC_BAND_SHIFT		12
+#define WL_CHANSPEC_BAND_5G		0x1000
+#define WL_CHANSPEC_BAND_2G		0x2000
+#define INVCHANSPEC			255
+
+#define WL_CHAN_VALID_HW		BIT(0) /* valid with current HW */
+#define WL_CHAN_VALID_SW		BIT(1) /* valid with country sett. */
+#define WL_CHAN_BAND_5G			BIT(2) /* 5GHz-band channel */
+#define WL_CHAN_RADAR			BIT(3) /* radar sensitive  channel */
+#define WL_CHAN_INACTIVE		BIT(4) /* inactive due to radar */
+#define WL_CHAN_PASSIVE			BIT(5) /* channel in passive mode */
+#define WL_CHAN_RESTRICTED		BIT(6) /* restricted use channel */
+
+/* values for band specific 40MHz capabilities  */
+#define WLC_N_BW_20ALL			0
+#define WLC_N_BW_40ALL			1
+#define WLC_N_BW_20IN2G_40IN5G		2
+
+#define WLC_BW_20MHZ_BIT		BIT(0)
+#define WLC_BW_40MHZ_BIT		BIT(1)
+#define WLC_BW_80MHZ_BIT		BIT(2)
+#define WLC_BW_160MHZ_BIT		BIT(3)
+
+/* Bandwidth capabilities */
+#define WLC_BW_CAP_20MHZ		(WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_40MHZ		(WLC_BW_40MHZ_BIT | WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_80MHZ		(WLC_BW_80MHZ_BIT | WLC_BW_40MHZ_BIT | \
+					 WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_160MHZ		(WLC_BW_160MHZ_BIT | WLC_BW_80MHZ_BIT | \
+					 WLC_BW_40MHZ_BIT | WLC_BW_20MHZ_BIT)
+#define WLC_BW_CAP_UNRESTRICTED		0xFF
+
+/* band types */
+#define	WLC_BAND_AUTO			0	/* auto-select */
+#define	WLC_BAND_5G			1	/* 5 Ghz */
+#define	WLC_BAND_2G			2	/* 2.4 Ghz */
+#define	WLC_BAND_6G			3	/* 6 Ghz */
+#define	WLC_BAND_ALL			4	/* all bands */
+
+#define CHSPEC_CHANNEL(chspec)	((u8)((chspec) & WL_CHANSPEC_CHAN_MASK))
+#define CHSPEC_BAND(chspec)	((chspec) & WL_CHANSPEC_BAND_MASK)
+
+#define CHSPEC_CTL_SB(chspec)	((chspec) & WL_CHANSPEC_CTL_SB_MASK)
+#define CHSPEC_BW(chspec)	((chspec) & WL_CHANSPEC_BW_MASK)
+
+#define CHSPEC_IS10(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_10)
+
+#define CHSPEC_IS20(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_20)
+
+#define CHSPEC_IS40(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_40)
+
+#define CHSPEC_IS80(chspec) \
+	(((chspec) & WL_CHANSPEC_BW_MASK) == WL_CHANSPEC_BW_80)
+
+#define CHSPEC_IS5G(chspec) \
+	(((chspec) & WL_CHANSPEC_BAND_MASK) == WL_CHANSPEC_BAND_5G)
+
+#define CHSPEC_IS2G(chspec) \
+	(((chspec) & WL_CHANSPEC_BAND_MASK) == WL_CHANSPEC_BAND_2G)
+
+#define CHSPEC_SB_NONE(chspec) \
+	(((chspec) & WL_CHANSPEC_CTL_SB_MASK) == WL_CHANSPEC_CTL_SB_NONE)
+
+#define CHSPEC_SB_UPPER(chspec) \
+	(((chspec) & WL_CHANSPEC_CTL_SB_MASK) == WL_CHANSPEC_CTL_SB_UPPER)
+
+#define CHSPEC_SB_LOWER(chspec) \
+	(((chspec) & WL_CHANSPEC_CTL_SB_MASK) == WL_CHANSPEC_CTL_SB_LOWER)
+
+#define CHSPEC_CTL_CHAN(chspec) {\
+	typeof(i) _chspec = (chspec); \
+	((CHSPEC_SB_LOWER(_chspec)) ? \
+	(lower_20_sb((_chspec & WL_CHANSPEC_CHAN_MASK))) : \
+	(upper_20_sb((_chspec & WL_CHANSPEC_CHAN_MASK)))); \
+	}
+
+/* band types */
+#define INF_BAND_AUTO           0       /* auto-select */
+#define INF_BAND_5G             1       /* 5 Ghz */
+#define INF_BAND_2G             2       /* 2.4 Ghz */
+#define INF_BAND_ALL            3       /* all bands */
+
+#define CHSPEC2BAND(chspec) (CHSPEC_IS5G(chspec) ? INF_BAND_5G : INF_BAND_2G)
+
+#define CHANSPEC_STR_LEN    8
+
+/*
+ * Enumeration of 802.11 radio bands
+ */
+enum {
+	INFF_CP_WIFI_BAND_ANY = 0,     /**< Platform will choose an available band.  */
+	INFF_CP_WIFI_BAND_5GHZ,        /**< 5-GHz radio band.                        */
+	INFF_CP_WIFI_BAND_2_4GHZ,      /**< 2.4-GHz radio band.                      */
+	INFF_CP_WIFI_BAND_6GHZ,        /**< 6-GHz radio band.                        */
+};
+
+static inline enum nl80211_band inff_cp_chan_band_to_nl80211(int band)
+{
+	switch (band) {
+	case INFF_CP_WIFI_BAND_2_4GHZ:
+		return NL80211_BAND_2GHZ;
+	case INFF_CP_WIFI_BAND_5GHZ:
+		return NL80211_BAND_5GHZ;
+	default:
+		return NL80211_BAND_6GHZ;
+	}
+}
+
+static inline int lower_20_sb(int channel)
+{
+	return channel > CH_10MHZ_APART ? (channel - CH_10MHZ_APART) : 0;
+}
+
+static inline int upper_20_sb(int channel)
+{
+	return (channel < (MAXCHANNEL - CH_10MHZ_APART)) ?
+	       channel + CH_10MHZ_APART : 0;
+}
+
+static inline int chspec_bandunit(u16 chspec)
+{
+	return CHSPEC_IS5G(chspec) ? BAND_5G_INDEX : BAND_2G_INDEX;
+}
+
+static inline u16 ch20mhz_chspec(int channel)
+{
+	u16 rc = channel <= CH_MAX_2G_CHANNEL ?
+		 WL_CHANSPEC_BAND_2G : WL_CHANSPEC_BAND_5G;
+
+	return	(u16)((u16)channel | WL_CHANSPEC_BW_20 |
+		      WL_CHANSPEC_CTL_SB_NONE | rc);
+}
+
+static inline int next_20mhz_chan(int channel)
+{
+	return channel < (MAXCHANNEL - CH_20MHZ_APART) ?
+	       channel + CH_20MHZ_APART : 0;
+}
+
+/* defined rate in 500kbps */
+#define INF_MAXRATE	108	/* in 500kbps units */
+#define INF_RATE_1M	2	/* in 500kbps units */
+#define INF_RATE_2M	4	/* in 500kbps units */
+#define INF_RATE_5M5	11	/* in 500kbps units */
+#define INF_RATE_11M	22	/* in 500kbps units */
+#define INF_RATE_6M	12	/* in 500kbps units */
+#define INF_RATE_9M	18	/* in 500kbps units */
+#define INF_RATE_12M	24	/* in 500kbps units */
+#define INF_RATE_18M	36	/* in 500kbps units */
+#define INF_RATE_24M	48	/* in 500kbps units */
+#define INF_RATE_36M	72	/* in 500kbps units */
+#define INF_RATE_48M	96	/* in 500kbps units */
+#define INF_RATE_54M	108	/* in 500kbps units */
+
+#define INF_2G_25MHZ_OFFSET		5	/* 2.4GHz band channel offset */
+
+#define MCSSET_LEN	16
+
+static inline bool ac_bitmap_tst(u8 bitmap, int prec)
+{
+	return (bitmap & (1 << (prec))) != 0;
+}
+
+/* A chanspec (channel specification) holds the channel number, band,
+ * bandwidth and control sideband
+ */
+
+/* chanspec binary format */
+
+#define INFF_CHSPEC_INVALID		255
+/* bit 0~7 channel number
+ * for 80+80 channels: bit 0~3 low channel id, bit 4~7 high channel id
+ */
+#define INFF_CHSPEC_CH_MASK		0x00ff
+#define INFF_CHSPEC_CH_SHIFT		0
+#define INFF_CHSPEC_CHL_MASK		0x000f
+#define INFF_CHSPEC_CHL_SHIFT		0
+#define INFF_CHSPEC_CHH_MASK		0x00f0
+#define INFF_CHSPEC_CHH_SHIFT		4
+
+/* bit 8~16 for Chanspec
+ * bit 8~10 sideband
+ * bit 11~13 bandwidth
+ * bit 14~15 spectral band
+ */
+#define INFF_CHSPEC_SB_MASK	0x0700
+#define INFF_CHSPEC_SB_SHIFT	8
+#define  INFF_CHSPEC_SB_LLL	0x0000
+#define  INFF_CHSPEC_SB_LLU	0x0100
+#define  INFF_CHSPEC_SB_LUL	0x0200
+#define  INFF_CHSPEC_SB_LUU	0x0300
+#define  INFF_CHSPEC_SB_ULL	0x0400
+#define  INFF_CHSPEC_SB_ULU	0x0500
+#define  INFF_CHSPEC_SB_UUL	0x0600
+#define  INFF_CHSPEC_SB_UUU	0x0700
+#define  INFF_CHSPEC_SB_LL	INFF_CHSPEC_SB_LLL
+#define  INFF_CHSPEC_SB_LU	INFF_CHSPEC_SB_LLU
+#define  INFF_CHSPEC_SB_UL	INFF_CHSPEC_SB_LUL
+#define  INFF_CHSPEC_SB_UU	INFF_CHSPEC_SB_LUU
+#define  INFF_CHSPEC_SB_L	INFF_CHSPEC_SB_LLL
+#define  INFF_CHSPEC_SB_U	INFF_CHSPEC_SB_LLU
+#define INFF_CHSPEC_BW_MASK	0x3800
+#define INFF_CHSPEC_BW_SHIFT	11
+#define  INFF_CHSPEC_BW_5	0x0000
+#define  INFF_CHSPEC_BW_10	0x0800
+#define  INFF_CHSPEC_BW_20	0x1000
+#define  INFF_CHSPEC_BW_40	0x1800
+#define  INFF_CHSPEC_BW_80	0x2000
+#define  INFF_CHSPEC_BW_160	0x2800
+#define  INFF_CHSPEC_BW_8080	0x3000
+#define INFF_CHSPEC_BND_MASK	0xc000
+#define INFF_CHSPEC_BND_SHIFT	14
+#define  INFF_CHSPEC_BND_2G	0x0000
+#define  INFF_CHSPEC_BND_3G	0x4000
+#define  INFF_CHSPEC_BND_6G	0x8000
+#define  INFF_CHSPEC_BND_5G	0xc000
+#define INFF_CHSPEC_IS5G(chspec) \
+	(((chspec) & INFF_CHSPEC_BND_MASK) == INFF_CHSPEC_BND_5G)
+#define INFF_CHSPEC_IS6G(chspec) \
+	(((chspec) & INFF_CHSPEC_BND_MASK) == INFF_CHSPEC_BND_6G)
+#define INFF_CHAN_BAND_2G		1
+#define INFF_CHAN_BAND_5G		2
+#define INFF_CHAN_BAND_6G		3
+
+enum inff_chan_bw {
+	INFF_CHAN_BW_20,
+	INFF_CHAN_BW_40,
+	INFF_CHAN_BW_80,
+	INFF_CHAN_BW_80P80,
+	INFF_CHAN_BW_160,
+};
+
+enum inff_chan_sb {
+	INFF_CHAN_SB_NONE = -1,
+	INFF_CHAN_SB_LLL,
+	INFF_CHAN_SB_LLU,
+	INFF_CHAN_SB_LUL,
+	INFF_CHAN_SB_LUU,
+	INFF_CHAN_SB_ULL,
+	INFF_CHAN_SB_ULU,
+	INFF_CHAN_SB_UUL,
+	INFF_CHAN_SB_UUU,
+	INFF_CHAN_SB_L = INFF_CHAN_SB_LLL,
+	INFF_CHAN_SB_U = INFF_CHAN_SB_LLU,
+	INFF_CHAN_SB_LL = INFF_CHAN_SB_LLL,
+	INFF_CHAN_SB_LU = INFF_CHAN_SB_LLU,
+	INFF_CHAN_SB_UL = INFF_CHAN_SB_LUL,
+	INFF_CHAN_SB_UU = INFF_CHAN_SB_LUU,
+};
+
+/**
+ * struct inff_chan - stores channel formats
+ *
+ * This structure can be used with functions translating chanspec into generic
+ * channel info and the other way.
+ *
+ * @chspec: firmware specific format
+ * @chnum: center channel number
+ * @control_ch_num: control channel number
+ * @band: frequency band
+ * @bw: channel width
+ * @sb: control sideband (location of control channel against the center one)
+ */
+struct inff_chan {
+	u16 chspec;
+	u8 chnum;
+	u8 control_ch_num;
+	u8 band;
+	enum inff_chan_bw bw;
+	enum inff_chan_sb sb;
+};
+
+enum nl80211_band inff_chan_band_to_nl80211(u8 band);
+u8 inff_nl80211_band_to_fwil(enum nl80211_band band);
+void inff_chan_encchspec(struct inff_chan *ch);
+void inff_chan_decchspec(struct inff_chan *ch);
+void inff_chan_update_bw40_channel_flag(struct ieee80211_channel *channel,
+					struct inff_chan *ch);
+int inff_chan_enable_bw40_2g(struct inff_cfg80211_info *cfg);
+s32 inff_chan_set(struct inff_cfg80211_info *cfg,
+		  struct ieee80211_channel *chan);
+s32 inff_chan_set_mchan_config(struct inff_cfg80211_info *cfg);
+u16 inff_nl80211_chandef_to_chanspec(struct cfg80211_chan_def *ch);
+u16 inff_nl80211_chan_to_chanspec(struct ieee80211_channel *ch);
+void inff_nl80211_chan_get_bwcap(struct inff_if *ifp, u32 bw_cap[]);
+int inff_fill_band_with_default_chanlist(struct wiphy *wiphy,
+					 struct inff_if *ifp);
+int inff_nl80211_chan_populate(struct inff_cfg80211_info *cfg,
+			       u32 bw_cap[]);
+
+#endif /* INFF_CHAN_H */
-- 
2.25.1


