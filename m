Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B470CBF7DF
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfIZRro (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:44 -0400
Received: from nbd.name ([46.4.11.11]:55244 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jKmsdtKQFWPFKdWRM1momvtrR56mXG67/oud7zXxXy8=; b=ACa/eMMgTVSaLueDhvggku7uXN
        /onPKCA2v35Dmohd+RkIdOt6gUwi2mnGvoITW6RbnOENrMFbDyipRM/qqnj+cdusNrZrWPXe7brEv
        I3ubNAErmHpxYgUNZ/ncWyG8oHe0cwc6duumJhazXLxfwcWe9we1X/ChrrOLMnOvcHlQ=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000yk-23
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B5A3069B6A86; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/15] mt76: track rx airtime for airtime fairness and survey
Date:   Thu, 26 Sep 2019 19:47:22 +0200
Message-Id: <20190926174732.42375-5-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report total rx airtime for valid stations as BSS rx time in survey

mt7615 is left out for now, it will be supported later by reading
hardware counters instead of calculating airtime in software

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/airtime.c  | 278 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mac80211.c | 109 ++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  64 ++--
 .../net/wireless/mediatek/mt76/mt7603/init.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   |   1 +
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |   1 +
 12 files changed, 433 insertions(+), 37 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/airtime.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 4d03596e891f..181af60e32db 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -6,7 +6,7 @@ obj-$(CONFIG_MT76x02_USB) += mt76x02-usb.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
-	tx.o agg-rx.o mcu.o
+	tx.o agg-rx.o mcu.o airtime.o
 
 mt76-usb-y := usb.o usb_trace.o
 
diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/net/wireless/mediatek/mt76/airtime.c
new file mode 100644
index 000000000000..d5bc4d713a88
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/airtime.c
@@ -0,0 +1,278 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2019 Felix Fietkau <nbd@nbd.name>
+ */
+
+#include "mt76.h"
+
+#define AVG_PKT_SIZE	1024
+
+/* Number of bits for an average sized packet */
+#define MCS_NBITS (AVG_PKT_SIZE << 3)
+
+/* Number of symbols for a packet with (bps) bits per symbol */
+#define MCS_NSYMS(bps) DIV_ROUND_UP(MCS_NBITS, (bps))
+
+/* Transmission time (1024 usec) for a packet containing (syms) * symbols */
+#define MCS_SYMBOL_TIME(sgi, syms)					\
+	(sgi ?								\
+	  ((syms) * 18 * 1024 + 4 * 1024) / 5 :	/* syms * 3.6 us */	\
+	  ((syms) * 1024) << 2			/* syms * 4 us */	\
+	)
+
+/* Transmit duration for the raw data part of an average sized packet */
+#define MCS_DURATION(streams, sgi, bps) \
+	MCS_SYMBOL_TIME(sgi, MCS_NSYMS((streams) * (bps)))
+
+#define BW_20			0
+#define BW_40			1
+#define BW_80			2
+
+/*
+ * Define group sort order: HT40 -> SGI -> #streams
+ */
+#define MT_MAX_STREAMS		4
+#define MT_HT_STREAM_GROUPS	4 /* BW(=2) * SGI(=2) */
+#define MT_VHT_STREAM_GROUPS	6 /* BW(=3) * SGI(=2) */
+
+#define MT_HT_GROUPS_NB	(MT_MAX_STREAMS *		\
+				 MT_HT_STREAM_GROUPS)
+#define MT_VHT_GROUPS_NB	(MT_MAX_STREAMS *		\
+				 MT_VHT_STREAM_GROUPS)
+#define MT_GROUPS_NB	(MT_HT_GROUPS_NB +	\
+				 MT_VHT_GROUPS_NB)
+
+#define MT_HT_GROUP_0	0
+#define MT_VHT_GROUP_0	(MT_HT_GROUP_0 + MT_HT_GROUPS_NB)
+
+#define MCS_GROUP_RATES		10
+
+#define HT_GROUP_IDX(_streams, _sgi, _ht40)	\
+	MT_HT_GROUP_0 +			\
+	MT_MAX_STREAMS * 2 * _ht40 +	\
+	MT_MAX_STREAMS * _sgi +	\
+	_streams - 1
+
+#define _MAX(a, b) (((a)>(b))?(a):(b))
+
+#define GROUP_SHIFT(duration)						\
+	_MAX(0, 16 - __builtin_clz(duration))
+
+/* MCS rate information for an MCS group */
+#define __MCS_GROUP(_streams, _sgi, _ht40, _s)				\
+	[HT_GROUP_IDX(_streams, _sgi, _ht40)] = {			\
+	.shift = _s,							\
+	.duration = {							\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26) >> _s,	\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 108 : 52) >> _s,	\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 162 : 78) >> _s,	\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 216 : 104) >> _s,	\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 324 : 156) >> _s,	\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 432 : 208) >> _s,	\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 486 : 234) >> _s,	\
+		MCS_DURATION(_streams, _sgi, _ht40 ? 540 : 260) >> _s	\
+	}								\
+}
+
+#define MCS_GROUP_SHIFT(_streams, _sgi, _ht40)				\
+	GROUP_SHIFT(MCS_DURATION(_streams, _sgi, _ht40 ? 54 : 26))
+
+#define MCS_GROUP(_streams, _sgi, _ht40)				\
+	__MCS_GROUP(_streams, _sgi, _ht40,				\
+		    MCS_GROUP_SHIFT(_streams, _sgi, _ht40))
+
+#define VHT_GROUP_IDX(_streams, _sgi, _bw)				\
+	(MT_VHT_GROUP_0 +						\
+	 MT_MAX_STREAMS * 2 * (_bw) +				\
+	 MT_MAX_STREAMS * (_sgi) +				\
+	 (_streams) - 1)
+
+#define BW2VBPS(_bw, r3, r2, r1)					\
+	(_bw == BW_80 ? r3 : _bw == BW_40 ? r2 : r1)
+
+#define __VHT_GROUP(_streams, _sgi, _bw, _s)				\
+	[VHT_GROUP_IDX(_streams, _sgi, _bw)] = {			\
+	.shift = _s,							\
+	.duration = {							\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw,  117,  54,  26)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw,  234, 108,  52)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw,  351, 162,  78)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw,  468, 216, 104)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw,  702, 324, 156)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw,  936, 432, 208)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw, 1053, 486, 234)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw, 1170, 540, 260)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw, 1404, 648, 312)) >> _s,	\
+		MCS_DURATION(_streams, _sgi,				\
+			     BW2VBPS(_bw, 1560, 720, 346)) >> _s	\
+	}								\
+}
+
+#define VHT_GROUP_SHIFT(_streams, _sgi, _bw)				\
+	GROUP_SHIFT(MCS_DURATION(_streams, _sgi,			\
+				 BW2VBPS(_bw,  117,  54,  26)))
+
+#define VHT_GROUP(_streams, _sgi, _bw)					\
+	__VHT_GROUP(_streams, _sgi, _bw,				\
+		    VHT_GROUP_SHIFT(_streams, _sgi, _bw))
+
+struct mcs_group {
+	u8 shift;
+	u16 duration[MCS_GROUP_RATES];
+};
+
+static const struct mcs_group airtime_mcs_groups[] = {
+	MCS_GROUP(1, 0, BW_20),
+	MCS_GROUP(2, 0, BW_20),
+	MCS_GROUP(3, 0, BW_20),
+	MCS_GROUP(4, 0, BW_20),
+
+	MCS_GROUP(1, 1, BW_20),
+	MCS_GROUP(2, 1, BW_20),
+	MCS_GROUP(3, 1, BW_20),
+	MCS_GROUP(4, 1, BW_20),
+
+	MCS_GROUP(1, 0, BW_40),
+	MCS_GROUP(2, 0, BW_40),
+	MCS_GROUP(3, 0, BW_40),
+	MCS_GROUP(4, 0, BW_40),
+
+	MCS_GROUP(1, 1, BW_40),
+	MCS_GROUP(2, 1, BW_40),
+	MCS_GROUP(3, 1, BW_40),
+	MCS_GROUP(4, 1, BW_40),
+
+	VHT_GROUP(1, 0, BW_20),
+	VHT_GROUP(2, 0, BW_20),
+	VHT_GROUP(3, 0, BW_20),
+	VHT_GROUP(4, 0, BW_20),
+
+	VHT_GROUP(1, 1, BW_20),
+	VHT_GROUP(2, 1, BW_20),
+	VHT_GROUP(3, 1, BW_20),
+	VHT_GROUP(4, 1, BW_20),
+
+	VHT_GROUP(1, 0, BW_40),
+	VHT_GROUP(2, 0, BW_40),
+	VHT_GROUP(3, 0, BW_40),
+	VHT_GROUP(4, 0, BW_40),
+
+	VHT_GROUP(1, 1, BW_40),
+	VHT_GROUP(2, 1, BW_40),
+	VHT_GROUP(3, 1, BW_40),
+	VHT_GROUP(4, 1, BW_40),
+
+	VHT_GROUP(1, 0, BW_80),
+	VHT_GROUP(2, 0, BW_80),
+	VHT_GROUP(3, 0, BW_80),
+	VHT_GROUP(4, 0, BW_80),
+
+	VHT_GROUP(1, 1, BW_80),
+	VHT_GROUP(2, 1, BW_80),
+	VHT_GROUP(3, 1, BW_80),
+	VHT_GROUP(4, 1, BW_80),
+};
+
+static u32
+mt76_calc_legacy_rate_duration(const struct ieee80211_rate *rate, bool short_pre,
+			       int len)
+{
+	u32 duration;
+
+	switch (rate->hw_value >> 8) {
+	case MT_PHY_TYPE_CCK:
+		duration = 144 + 48; /* preamble + PLCP */
+		if (short_pre)
+			duration >>= 1;
+
+		duration += 10; /* SIFS */
+		break;
+	case MT_PHY_TYPE_OFDM:
+		duration = 20 + 16; /* premable + SIFS */
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	len <<= 3;
+	duration += (len * 10) / rate->bitrate;
+
+	return duration;
+}
+
+u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *status,
+			 int len)
+{
+	struct ieee80211_supported_band *sband;
+	const struct ieee80211_rate *rate;
+	bool sgi = status->enc_flags & RX_ENC_FLAG_SHORT_GI;
+	bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
+	int bw, streams;
+	u32 duration;
+	int group, idx;
+
+	switch (status->bw) {
+	case RATE_INFO_BW_20:
+		bw = BW_20;
+		break;
+	case RATE_INFO_BW_40:
+		bw = BW_40;
+		break;
+	case RATE_INFO_BW_80:
+		bw = BW_80;
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	switch (status->encoding) {
+	case RX_ENC_LEGACY:
+		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
+			return 0;
+
+		sband = dev->hw->wiphy->bands[status->band];
+		if (!sband || status->rate_idx > sband->n_bitrates)
+			return 0;
+
+		rate = &sband->bitrates[status->rate_idx];
+
+		return mt76_calc_legacy_rate_duration(rate, sp, len);
+	case RX_ENC_VHT:
+		streams = status->nss;
+		idx = status->rate_idx;
+		group = VHT_GROUP_IDX(streams, sgi, bw);
+		break;
+	case RX_ENC_HT:
+		streams = ((status->rate_idx >> 3) & 3) + 1;
+		idx = status->rate_idx & 7;
+		group = HT_GROUP_IDX(streams, sgi, bw);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+
+	if (WARN_ON_ONCE(streams > 4))
+		return 0;
+
+	duration = airtime_mcs_groups[group].duration[idx];
+	duration <<= airtime_mcs_groups[group].shift;
+	duration *= len;
+	duration /= AVG_PKT_SIZE;
+	duration /= 1024;
+
+	duration += 36 + (streams << 2);
+
+	return duration;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index aefdd22d74ef..aab181bc6eb2 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -414,6 +414,25 @@ mt76_channel_state(struct mt76_dev *dev, struct ieee80211_channel *c)
 	return &msband->chan[idx];
 }
 
+void mt76_update_survey(struct mt76_dev *dev)
+{
+	struct mt76_channel_state *state;
+
+	if (dev->drv->update_survey)
+		dev->drv->update_survey(dev);
+
+	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
+		state = mt76_channel_state(dev, dev->chandef.chan);
+		spin_lock_bh(&dev->rx_lock);
+		spin_lock(&dev->cc_lock);
+		state->cc_bss_rx += dev->cur_cc_bss_rx;
+		dev->cur_cc_bss_rx = 0;
+		spin_unlock(&dev->cc_lock);
+		spin_unlock_bh(&dev->rx_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(mt76_update_survey);
+
 void mt76_set_channel(struct mt76_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->hw;
@@ -422,9 +441,7 @@ void mt76_set_channel(struct mt76_dev *dev)
 	int timeout = HZ / 5;
 
 	wait_event_timeout(dev->tx_wait, !mt76_has_tx_pending(dev), timeout);
-
-	if (dev->drv->update_survey)
-		dev->drv->update_survey(dev);
+	mt76_update_survey(dev);
 
 	dev->chandef = *chandef;
 	dev->chan_state = mt76_channel_state(dev, chandef->chan);
@@ -447,7 +464,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	int ret = 0;
 
 	if (idx == 0 && dev->drv->update_survey)
-		dev->drv->update_survey(dev);
+		mt76_update_survey(dev);
 
 	sband = &dev->sband_2g;
 	if (idx >= sband->sband.n_channels) {
@@ -464,12 +481,17 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	memset(survey, 0, sizeof(*survey));
 	survey->channel = chan;
 	survey->filled = SURVEY_INFO_TIME | SURVEY_INFO_TIME_BUSY;
-	if (chan == dev->main_chan)
+	if (chan == dev->main_chan) {
 		survey->filled |= SURVEY_INFO_IN_USE;
 
+		if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME)
+			survey->filled |= SURVEY_INFO_TIME_BSS_RX;
+	}
+
 	spin_lock_bh(&dev->cc_lock);
 	survey->time = div_u64(state->cc_active, 1000);
 	survey->time_busy = div_u64(state->cc_busy, 1000);
+	survey->time_bss_rx = div_u64(state->cc_bss_rx, 1000);
 	spin_unlock_bh(&dev->cc_lock);
 
 	return ret;
@@ -566,6 +588,81 @@ mt76_check_ccmp_pn(struct sk_buff *skb)
 	return 0;
 }
 
+static void
+mt76_airtime_report(struct mt76_dev *dev, struct mt76_rx_status *status,
+		    int len)
+{
+	struct mt76_wcid *wcid = status->wcid;
+	struct ieee80211_sta *sta;
+	u32 airtime;
+
+	airtime = mt76_calc_rx_airtime(dev, status, len);
+	dev->cur_cc_bss_rx += airtime;
+
+	if (!wcid || !wcid->sta)
+		return;
+
+	sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+	ieee80211_sta_register_airtime(sta, status->tid, 0, airtime);
+}
+
+static void
+mt76_airtime_flush_ampdu(struct mt76_dev *dev)
+{
+	struct mt76_wcid *wcid;
+	int wcid_idx;
+
+	if (!dev->rx_ampdu_len)
+		return;
+
+	wcid_idx = dev->rx_ampdu_status.wcid_idx;
+	if (dev->rx_ampdu_status.wcid_idx != 0xff)
+		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+	else
+		wcid = NULL;
+	dev->rx_ampdu_status.wcid = wcid;
+
+	mt76_airtime_report(dev, &dev->rx_ampdu_status, dev->rx_ampdu_len);
+
+	dev->rx_ampdu_len = 0;
+	dev->rx_ampdu_ref = 0;
+}
+
+static void
+mt76_airtime_check(struct mt76_dev *dev, struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_wcid *wcid = status->wcid;
+
+	if (!(dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME))
+		return;
+
+	if (!wcid || !wcid->sta) {
+		if (!ether_addr_equal(hdr->addr1, dev->macaddr))
+			return;
+
+		wcid = NULL;
+	}
+
+	if (!(status->flag & RX_FLAG_AMPDU_DETAILS) ||
+	    status->ampdu_ref != dev->rx_ampdu_ref)
+		mt76_airtime_flush_ampdu(dev);
+
+	if (status->flag & RX_FLAG_AMPDU_DETAILS) {
+		if (status->ampdu_ref != dev->rx_ampdu_ref) {
+			dev->rx_ampdu_status = *status;
+			dev->rx_ampdu_status.wcid_idx = wcid ? wcid->idx : 0xff;
+			dev->rx_ampdu_ref = status->ampdu_ref;
+		}
+
+		dev->rx_ampdu_len += skb->len;
+		return;
+	}
+
+	mt76_airtime_report(dev, status, skb->len);
+}
+
 static void
 mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 {
@@ -582,6 +679,8 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 			wcid = status->wcid = (struct mt76_wcid *)sta->drv_priv;
 	}
 
+	mt76_airtime_check(dev, skb);
+
 	if (!wcid || !wcid->sta)
 		return;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3e4ababcae9b..911347bd272c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -281,6 +281,7 @@ struct mt76_hw_cap {
 
 #define MT_DRV_TXWI_NO_FREE		BIT(0)
 #define MT_DRV_TX_ALIGNED4_SKBS		BIT(1)
+#define MT_DRV_SW_RX_AIRTIME		BIT(2)
 
 struct mt76_driver_ops {
 	u32 drv_flags;
@@ -319,6 +320,7 @@ struct mt76_driver_ops {
 struct mt76_channel_state {
 	u64 cc_active;
 	u64 cc_busy;
+	u64 cc_bss_rx;
 };
 
 struct mt76_sband {
@@ -418,6 +420,34 @@ struct mt76_mmio {
 	u32 irqmask;
 };
 
+struct mt76_rx_status {
+	union {
+		struct mt76_wcid *wcid;
+		u8 wcid_idx;
+	};
+
+	unsigned long reorder_time;
+
+	u32 ampdu_ref;
+
+	u8 iv[6];
+
+	u8 aggr:1;
+	u8 tid;
+	u16 seqno;
+
+	u16 freq;
+	u32 flag;
+	u8 enc_flags;
+	u8 encoding:2, bw:3;
+	u8 rate_idx;
+	u8 nss;
+	u8 band;
+	s8 signal;
+	u8 chains;
+	s8 chain_signal[IEEE80211_MAX_CHAINS];
+};
+
 struct mt76_dev {
 	struct ieee80211_hw *hw;
 	struct cfg80211_chan_def chandef;
@@ -427,6 +457,12 @@ struct mt76_dev {
 	spinlock_t lock;
 	spinlock_t cc_lock;
 
+	u32 cur_cc_bss_rx;
+
+	struct mt76_rx_status rx_ampdu_status;
+	u32 rx_ampdu_len;
+	u32 rx_ampdu_ref;
+
 	struct mutex mutex;
 
 	const struct mt76_bus_ops *bus;
@@ -510,31 +546,6 @@ enum mt76_phy_type {
 	MT_PHY_TYPE_VHT,
 };
 
-struct mt76_rx_status {
-	struct mt76_wcid *wcid;
-
-	unsigned long reorder_time;
-
-	u32 ampdu_ref;
-
-	u8 iv[6];
-
-	u8 aggr:1;
-	u8 tid;
-	u16 seqno;
-
-	u16 freq;
-	u32 flag;
-	u8 enc_flags;
-	u8 encoding:2, bw:3;
-	u8 rate_idx;
-	u8 nss;
-	u8 band;
-	s8 signal;
-	u8 chains;
-	s8 chain_signal[IEEE80211_MAX_CHAINS];
-};
-
 #define __mt76_rr(dev, ...)	(dev)->bus->rr((dev), __VA_ARGS__)
 #define __mt76_wr(dev, ...)	(dev)->bus->wr((dev), __VA_ARGS__)
 #define __mt76_rmw(dev, ...)	(dev)->bus->rmw((dev), __VA_ARGS__)
@@ -706,6 +717,7 @@ void mt76_release_buffered_frames(struct ieee80211_hw *hw,
 				  bool more_data);
 bool mt76_has_tx_pending(struct mt76_dev *dev);
 void mt76_set_channel(struct mt76_dev *dev);
+void mt76_update_survey(struct mt76_dev *dev);
 int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 		    struct survey_info *survey);
 void mt76_set_stream_caps(struct mt76_dev *dev, bool vht);
@@ -766,6 +778,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 void mt76_rx_poll_complete(struct mt76_dev *dev, enum mt76_rxq_id q,
 			   struct napi_struct *napi);
 void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
+u32 mt76_calc_rx_airtime(struct mt76_dev *dev, struct mt76_rx_status *status,
+			 int len);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index ad2ccdbe7258..a68533684b18 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -7,6 +7,7 @@
 
 const struct mt76_driver_ops mt7603_drv_ops = {
 	.txwi_size = MT_TXD_SIZE,
+	.drv_flags = MT_DRV_SW_RX_AIRTIME,
 	.tx_prepare_skb = mt7603_tx_prepare_skb,
 	.tx_complete_skb = mt7603_tx_complete_skb,
 	.rx_skb = mt7603_queue_rx_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 3d160230d929..0212384d0d56 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1708,7 +1708,7 @@ void mt7603_mac_work(struct work_struct *work)
 	mutex_lock(&dev->mt76.mutex);
 
 	dev->mac_work_count++;
-	mt7603_update_channel(&dev->mt76);
+	mt76_update_survey(&dev->mt76);
 	mt7603_edcca_check(dev);
 
 	for (i = 0, idx = 0; i < 2; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 9189a86d7825..81f45c4ccc26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1291,7 +1291,7 @@ void mt7615_mac_work(struct work_struct *work)
 						mac_work.work);
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7615_update_channel(&dev->mt76);
+	mt76_update_survey(&dev->mt76);
 	if (++dev->mac_work_count == 5) {
 		mt7615_mac_scs_check(dev);
 		dev->mac_work_count = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index d20fd40418a7..f42450b4319c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -155,7 +155,8 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = sizeof(struct mt76x02_txwi),
-		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS,
+		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS |
+			     MT_DRV_SW_RX_AIRTIME,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 4c2b66b53533..54f9c0cc881f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -211,6 +211,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 			 const struct usb_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
+		.drv_flags = MT_DRV_SW_RX_AIRTIME,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index f73ec17e5f47..c987e57db0b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -798,7 +798,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 		 * we can assume that more subframes belonging to the same A-MPDU
 		 * are coming. The last one will have valid RSSI info
 		 */
-		if (!(rxinfo & MT_RXINFO_RSSI)) {
+		if (rxinfo & MT_RXINFO_RSSI) {
 			if (!++dev->mt76.ampdu_ref)
 				dev->mt76.ampdu_ref++;
 		}
@@ -1130,7 +1130,7 @@ void mt76x02_mac_work(struct work_struct *work)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	mt76x02_update_channel(&dev->mt76);
+	mt76_update_survey(&dev->mt76);
 	for (i = 0, idx = 0; i < 16; i++) {
 		u32 val = mt76_rr(dev, MT_TX_AGG_CNT(i));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index f7a1f82d8320..5304b6ecda26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -21,7 +21,8 @@ mt76pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = sizeof(struct mt76x02_txwi),
-		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS,
+		.drv_flags = MT_DRV_TX_ALIGNED4_SKBS |
+			     MT_DRV_SW_RX_AIRTIME,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02_tx_prepare_skb,
 		.tx_complete_skb = mt76x02_tx_complete_skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index da5e0f9a8bae..81be59c60155 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -25,6 +25,7 @@ static int mt76x2u_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
+		.drv_flags = MT_DRV_SW_RX_AIRTIME,
 		.update_survey = mt76x02_update_channel,
 		.tx_prepare_skb = mt76x02u_tx_prepare_skb,
 		.tx_complete_skb = mt76x02u_tx_complete_skb,
-- 
2.17.0

