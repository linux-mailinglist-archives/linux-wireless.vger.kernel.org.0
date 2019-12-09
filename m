Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B2F117233
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2019 17:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfLIQxS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Dec 2019 11:53:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:43146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIQxS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Dec 2019 11:53:18 -0500
Received: from localhost.localdomain (unknown [151.66.51.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 373342077B;
        Mon,  9 Dec 2019 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575910397;
        bh=mI/rswIVzde0eJMjxxm1JjsOgYU0alnpeXnGv/odcds=;
        h=From:To:Cc:Subject:Date:From;
        b=fxJm03CL25gMm2VLcZH4C5w84lk5cpS5+W6xOjXxpO8qPhJwLe0I5CMX+QSfJGRqq
         yiAmd1G2lnLIn2XMjIOh5yIEMmSDlnJNrHEMlw4s8Xz9PGkmDjDd2asYE2JulU2rvj
         J9oDAB2JlOmP+IPGza5vJqHlnRJJ5awGK0OZzaic=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: rely on mac80211 utility routines to compute airtime
Date:   Mon,  9 Dec 2019 17:53:04 +0100
Message-Id: <4cf6ef6374473df1b79ca8cc4ab8b431e0789c84.1575910106.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mac80211 airitme utility routines and remove mt76 duplicated code
to estimate tx/rx airtime

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/airtime.c  | 326 ------------------
 drivers/net/wireless/mediatek/mt76/mac80211.c |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   4 -
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |   2 +-
 5 files changed, 11 insertions(+), 333 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/airtime.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 99bbc74acda8..d7a1ddc9e407 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
-	tx.o agg-rx.o mcu.o airtime.o
+	tx.o agg-rx.o mcu.o
 
 mt76-$(CONFIG_PCI) += pci.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/net/wireless/mediatek/mt76/airtime.c
deleted file mode 100644
index 55116f395f9a..000000000000
--- a/drivers/net/wireless/mediatek/mt76/airtime.c
+++ /dev/null
@@ -1,326 +0,0 @@
-// SPDX-License-Identifier: ISC
-/*
- * Copyright (C) 2019 Felix Fietkau <nbd@nbd.name>
- */
-
-#include "mt76.h"
-
-#define AVG_PKT_SIZE	1024
-
-/* Number of bits for an average sized packet */
-#define MCS_NBITS (AVG_PKT_SIZE << 3)
-
-/* Number of symbols for a packet with (bps) bits per symbol */
-#define MCS_NSYMS(bps) DIV_ROUND_UP(MCS_NBITS, (bps))
-
-/* Transmission time (1024 usec) for a packet containing (syms) * symbols */
-#define MCS_SYMBOL_TIME(sgi, syms)					\
-	(sgi ?								\
-	  ((syms) * 18 * 1024 + 4 * 1024) / 5 :	/* syms * 3.6 us */	\
-	  ((syms) * 1024) << 2			/* syms * 4 us */	\
-	)
-
-/* Transmit duration for the raw data part of an average sized packet */
-#define MCS_DURATION(streams, sgi, bps) \
-	MCS_SYMBOL_TIME(sgi, MCS_NSYMS((streams) * (bps)))
-
-#define BW_20			0
-#define BW_40			1
-#define BW_80			2
-
-/*
- * Define group sort order: HT40 -> SGI -> #streams
- */
-#define MT_MAX_STREAMS		4
-#define MT_HT_STREAM_GROUPS	4 /* BW(=2) * SGI(=2) */
-#define MT_VHT_STREAM_GROUPS	6 /* BW(=3) * SGI(=2) */
-
-#define MT_HT_GROUPS_NB	(MT_MAX_STREAMS *		\
-				 MT_HT_STREAM_GROUPS)
-#define MT_VHT_GROUPS_NB	(MT_MAX_STREAMS *		\
-				 MT_VHT_STREAM_GROUPS)
-#define MT_GROUPS_NB	(MT_HT_GROUPS_NB +	\
-				 MT_VHT_GROUPS_NB)
-
-#define MT_HT_GROUP_0	0
-#define MT_VHT_GROUP_0	(MT_HT_GROUP_0 + MT_HT_GROUPS_NB)
-
-#define MCS_GROUP_RATES		10
-
-#define HT_GROUP_IDX(_streams, _sgi, _ht40)	\
-	MT_HT_GROUP_0 +			\
-	MT_MAX_STREAMS * 2 * _ht40 +	\
-	MT_MAX_STREAMS * _sgi +	\
-	_streams - 1
-
-#define _MAX(a, b) (((a)>(b))?(a):(b))
-
-#define GROUP_SHIFT(duration)						\
-	_MAX(0, 16 - __builtin_clz(duration))
-
-/* MCS rate information for an MCS group */
-#define __MCS_GROUP(_streams, _sgi, _ht40, _s)				\
-	[HT_GROUP_IDX(_streams, _sgi, _ht40)] = {			\
-	.shift = _s,							\
-	.duration = {							\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26) >> _s,	\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 108 : 52) >> _s,	\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 162 : 78) >> _s,	\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 216 : 104) >> _s,	\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 324 : 156) >> _s,	\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 432 : 208) >> _s,	\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 486 : 234) >> _s,	\
-		MCS_DURATION(_streams, _sgi, _ht40 ? 540 : 260) >> _s	\
-	}								\
-}
-
-#define MCS_GROUP_SHIFT(_streams, _sgi, _ht40)				\
-	GROUP_SHIFT(MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26))
-
-#define MCS_GROUP(_streams, _sgi, _ht40)				\
-	__MCS_GROUP(_streams, _sgi, _ht40,				\
-		    MCS_GROUP_SHIFT(_streams, _sgi, _ht40))
-
-#define VHT_GROUP_IDX(_streams, _sgi, _bw)				\
-	(MT_VHT_GROUP_0 +						\
-	 MT_MAX_STREAMS * 2 * (_bw) +				\
-	 MT_MAX_STREAMS * (_sgi) +				\
-	 (_streams) - 1)
-
-#define BW2VBPS(_bw, r3, r2, r1)					\
-	(_bw == BW_80 ? r3 : _bw == BW_40 ? r2 : r1)
-
-#define __VHT_GROUP(_streams, _sgi, _bw, _s)				\
-	[VHT_GROUP_IDX(_streams, _sgi, _bw)] = {			\
-	.shift = _s,							\
-	.duration = {							\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw,  117,  54,  26)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw,  234, 108,  52)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw,  351, 162,  78)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw,  468, 216, 104)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw,  702, 324, 156)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw,  936, 432, 208)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw, 1053, 486, 234)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw, 1170, 540, 260)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw, 1404, 648, 312)) >> _s,	\
-		MCS_DURATION(_streams, _sgi,				\
-			     BW2VBPS(_bw, 1560, 720, 346)) >> _s	\
-	}								\
-}
-
-#define VHT_GROUP_SHIFT(_streams, _sgi, _bw)				\
-	GROUP_SHIFT(MCS_DURATION(_streams, _sgi,			\
-				 BW2VBPS(_bw,  117,  54,  26)))
-
-#define VHT_GROUP(_streams, _sgi, _bw)					\
-	__VHT_GROUP(_streams, _sgi, _bw,				\
-		    VHT_GROUP_SHIFT(_streams, _sgi, _bw))
-
-struct mcs_group {
-	u8 shift;
-	u16 duration[MCS_GROUP_RATES];
-};
-
-static const struct mcs_group airtime_mcs_groups[] = {
-	MCS_GROUP(1, 0, BW_20),
-	MCS_GROUP(2, 0, BW_20),
-	MCS_GROUP(3, 0, BW_20),
-	MCS_GROUP(4, 0, BW_20),
-
-	MCS_GROUP(1, 1, BW_20),
-	MCS_GROUP(2, 1, BW_20),
-	MCS_GROUP(3, 1, BW_20),
-	MCS_GROUP(4, 1, BW_20),
-
-	MCS_GROUP(1, 0, BW_40),
-	MCS_GROUP(2, 0, BW_40),
-	MCS_GROUP(3, 0, BW_40),
-	MCS_GROUP(4, 0, BW_40),
-
-	MCS_GROUP(1, 1, BW_40),
-	MCS_GROUP(2, 1, BW_40),
-	MCS_GROUP(3, 1, BW_40),
-	MCS_GROUP(4, 1, BW_40),
-
-	VHT_GROUP(1, 0, BW_20),
-	VHT_GROUP(2, 0, BW_20),
-	VHT_GROUP(3, 0, BW_20),
-	VHT_GROUP(4, 0, BW_20),
-
-	VHT_GROUP(1, 1, BW_20),
-	VHT_GROUP(2, 1, BW_20),
-	VHT_GROUP(3, 1, BW_20),
-	VHT_GROUP(4, 1, BW_20),
-
-	VHT_GROUP(1, 0, BW_40),
-	VHT_GROUP(2, 0, BW_40),
-	VHT_GROUP(3, 0, BW_40),
-	VHT_GROUP(4, 0, BW_40),
-
-	VHT_GROUP(1, 1, BW_40),
-	VHT_GROUP(2, 1, BW_40),
-	VHT_GROUP(3, 1, BW_40),
-	VHT_GROUP(4, 1, BW_40),
-
-	VHT_GROUP(1, 0, BW_80),
-	VHT_GROUP(2, 0, BW_80),
-	VHT_GROUP(3, 0, BW_80),
-	VHT_GROUP(4, 0, BW_80),
-
-	VHT_GROUP(1, 1, BW_80),
-	VHT_GROUP(2, 1, BW_80),
-	VHT_GROUP(3, 1, BW_80),
-	VHT_GROUP(4, 1, BW_80),
-};
-
-static u32
-mt76_calc_legacy_rate_duration(const struct ieee80211_rate *rate, bool short_pre,
-			       int len)
-{
-	u32 duration;
-
-	switch (rate->hw_value >> 8) {
-	case MT_PHY_TYPE_CCK:
-		duration = 144 + 48; /* preamble + PLCP */
-		if (short_pre)
-			duration >>= 1;
-
-		duration += 10; /* SIFS */
-		break;
-	case MT_PHY_TYPE_OFDM:
-		duration = 20 + 16; /* premable + SIFS */
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	len <<= 3;
-	duration += (len * 10) / rate->bitrate;
-
-	return duration;
-}
-
-u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *status,
-			 int len)
-{
-	struct ieee80211_supported_band *sband;
-	const struct ieee80211_rate *rate;
-	bool sgi = status->enc_flags & RX_ENC_FLAG_SHORT_GI;
-	bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
-	int bw, streams;
-	u32 duration;
-	int group, idx;
-
-	switch (status->bw) {
-	case RATE_INFO_BW_20:
-		bw = BW_20;
-		break;
-	case RATE_INFO_BW_40:
-		bw = BW_40;
-		break;
-	case RATE_INFO_BW_80:
-		bw = BW_80;
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	switch (status->encoding) {
-	case RX_ENC_LEGACY:
-		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
-			return 0;
-
-		sband = dev->hw->wiphy->bands[status->band];
-		if (!sband || status->rate_idx > sband->n_bitrates)
-			return 0;
-
-		rate = &sband->bitrates[status->rate_idx];
-
-		return mt76_calc_legacy_rate_duration(rate, sp, len);
-	case RX_ENC_VHT:
-		streams = status->nss;
-		idx = status->rate_idx;
-		group = VHT_GROUP_IDX(streams, sgi, bw);
-		break;
-	case RX_ENC_HT:
-		streams = ((status->rate_idx >> 3) & 3) + 1;
-		idx = status->rate_idx & 7;
-		group = HT_GROUP_IDX(streams, sgi, bw);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		return 0;
-	}
-
-	if (WARN_ON_ONCE(streams > 4))
-		return 0;
-
-	duration = airtime_mcs_groups[group].duration[idx];
-	duration <<= airtime_mcs_groups[group].shift;
-	duration *= len;
-	duration /= AVG_PKT_SIZE;
-	duration /= 1024;
-
-	duration += 36 + (streams << 2);
-
-	return duration;
-}
-
-u32 mt76_calc_tx_airtime(struct mt76_dev *dev, struct ieee80211_tx_info *info,
-			 int len)
-{
-	struct mt76_rx_status stat = {
-		.band = info->band,
-	};
-	u32 duration = 0;
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(info->status.rates); i++) {
-		struct ieee80211_tx_rate *rate = &info->status.rates[i];
-		u32 cur_duration;
-
-		if (rate->idx < 0 || !rate->count)
-			break;
-
-		if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-			stat.bw = RATE_INFO_BW_80;
-		else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-			stat.bw = RATE_INFO_BW_40;
-		else
-			stat.bw = RATE_INFO_BW_20;
-
-		stat.enc_flags = 0;
-		if (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
-			stat.enc_flags |= RX_ENC_FLAG_SHORTPRE;
-		if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
-			stat.enc_flags |= RX_ENC_FLAG_SHORT_GI;
-
-		stat.rate_idx = rate->idx;
-		if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
-			stat.encoding = RX_ENC_VHT;
-			stat.rate_idx = ieee80211_rate_get_vht_mcs(rate);
-			stat.nss = ieee80211_rate_get_vht_nss(rate);
-		} else if (rate->flags & IEEE80211_TX_RC_MCS) {
-			stat.encoding = RX_ENC_HT;
-		} else {
-			stat.encoding = RX_ENC_LEGACY;
-		}
-
-		cur_duration = mt76_calc_rx_airtime(dev, &stat, len);
-		duration += cur_duration * rate->count;
-	}
-
-	return duration;
-}
-EXPORT_SYMBOL_GPL(mt76_calc_tx_airtime);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 00c2a875a596..eabe14cbe10d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -738,10 +738,18 @@ mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,
 		    int len)
 {
 	struct mt76_wcid *wcid = status->wcid;
+	struct ieee80211_rx_status info = {
+		.enc_flags = status->enc_flags,
+		.rate_idx = status->rate_idx,
+		.encoding = status->encoding,
+		.band = status->band,
+		.nss = status->nss,
+		.bw = status->bw,
+	};
 	struct ieee80211_sta *sta;
 	u32 airtime;
 
-	airtime = mt76_calc_rx_airtime(dev, status, len);
+	airtime = ieee80211_calc_rx_airtime(dev->hw, &info, len);
 	spin_lock(&dev->cc_lock);
 	dev->cur_cc_bss_rx += airtime;
 	spin_unlock(&dev->cc_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index ca71b78535b2..db0e21770adf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -817,8 +817,6 @@ void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
-u32 mt76_calc_tx_airtime(struct mt76_dev *dev, struct ieee80211_tx_info *info,
-			 int len);
 
 /* internal */
 static inline struct ieee80211_hw *
@@ -843,8 +841,6 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 			   struct napi_struct *napi);
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
-u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *status,
-			 int len);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 5b512e4ce6b8..73ee461cad79 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -630,7 +630,7 @@ void mt76x02_send_tx_status(struct mt76x02_dev *dev,
 	if (!len)
 		goto out;
 
-	duration = mt76_calc_tx_airtime(&dev->mt76, &info, len);
+	duration = ieee80211_calc_tx_airtime(mt76_hw(dev), &info, len);
 
 	spin_lock_bh(&dev->mt76.cc_lock);
 	dev->tx_airtime += duration;
-- 
2.21.0

