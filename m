Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77D42E9C81
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 19:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbhADSB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 13:01:56 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57577 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726336AbhADSB4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 13:01:56 -0500
X-UUID: 39d5d166533347c6afbc996ce9bb5ea8-20210105
X-UUID: 39d5d166533347c6afbc996ce9bb5ea8-20210105
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1353749337; Tue, 05 Jan 2021 02:00:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 02:00:20 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 02:00:20 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v5 03/15] mt76: mt7921: add MAC support
Date:   Tue, 5 Jan 2021 02:00:07 +0800
Message-ID: <74a72486f95dcd77e0b03a00382e82fefefc8ce3.1609781247.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1609781247.git.objelf@gmail.com>
References: <cover.1609781247.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 30B0B3A1268C5226921CB233C3526C14CB9D7AFDB68CEE643BA4CD827B355DBB2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add Rx packet description parsing, Tx packet description compositon, handle
packet recycling and provide MAC information mt76 core needs to support
mac80211.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 1363 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |  333 ++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  354 +++++
 .../net/wireless/mediatek/mt76/mt7921/regs.h  |  413 +++++
 4 files changed, 2463 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mac.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regs.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
new file mode 100644
index 000000000000..2a77fe6abc7d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -0,0 +1,1363 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include <linux/etherdevice.h>
+#include <linux/timekeeping.h>
+#include "mt7921.h"
+#include "../dma.h"
+#include "mac.h"
+
+#define to_rssi(field, rxv)	((FIELD_GET(field, rxv) - 220) / 2)
+
+#define HE_BITS(f)		cpu_to_le16(IEEE80211_RADIOTAP_HE_##f)
+#define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
+						 IEEE80211_RADIOTAP_HE_##f)
+
+static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
+					    u16 idx, bool unicast)
+{
+	struct mt7921_sta *sta;
+	struct mt76_wcid *wcid;
+
+	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
+		return NULL;
+
+	wcid = rcu_dereference(dev->mt76.wcid[idx]);
+	if (unicast || !wcid)
+		return wcid;
+
+	if (!wcid->sta)
+		return NULL;
+
+	sta = container_of(wcid, struct mt7921_sta, wcid);
+	if (!sta->vif)
+		return NULL;
+
+	return &sta->vif->sta.wcid;
+}
+
+void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
+{
+}
+
+bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask)
+{
+	mt76_rmw(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_WLAN_IDX,
+		 FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, idx) | mask);
+
+	return mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY,
+			 0, 5000);
+}
+
+static u32 mt7921_mac_wtbl_lmac_addr(struct mt7921_dev *dev, u16 wcid)
+{
+	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
+		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
+
+	return MT_WTBL_LMAC_OFFS(wcid, 0);
+}
+
+static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
+{
+	static const u8 ac_to_tid[] = {
+		[IEEE80211_AC_BE] = 0,
+		[IEEE80211_AC_BK] = 1,
+		[IEEE80211_AC_VI] = 4,
+		[IEEE80211_AC_VO] = 6
+	};
+	struct ieee80211_sta *sta;
+	struct mt7921_sta *msta;
+	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
+	LIST_HEAD(sta_poll_list);
+	int i;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&dev->sta_poll_list, &sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+
+	rcu_read_lock();
+
+	while (true) {
+		bool clear = false;
+		u32 addr;
+		u16 idx;
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&sta_poll_list)) {
+			spin_unlock_bh(&dev->sta_poll_lock);
+			break;
+		}
+		msta = list_first_entry(&sta_poll_list,
+					struct mt7921_sta, poll_list);
+		list_del_init(&msta->poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		idx = msta->wcid.idx;
+		addr = mt7921_mac_wtbl_lmac_addr(dev, idx) + 20 * 4;
+
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u32 tx_last = msta->airtime_ac[i];
+			u32 rx_last = msta->airtime_ac[i + 4];
+
+			msta->airtime_ac[i] = mt76_rr(dev, addr);
+			msta->airtime_ac[i + 4] = mt76_rr(dev, addr + 4);
+
+			tx_time[i] = msta->airtime_ac[i] - tx_last;
+			rx_time[i] = msta->airtime_ac[i + 4] - rx_last;
+
+			if ((tx_last | rx_last) & BIT(30))
+				clear = true;
+
+			addr += 8;
+		}
+
+		if (clear) {
+			mt7921_mac_wtbl_update(dev, idx,
+					       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+			memset(msta->airtime_ac, 0, sizeof(msta->airtime_ac));
+		}
+
+		if (!msta->wcid.sta)
+			continue;
+
+		sta = container_of((void *)msta, struct ieee80211_sta,
+				   drv_priv);
+		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
+			u8 q = mt7921_lmac_mapping(dev, i);
+			u32 tx_cur = tx_time[q];
+			u32 rx_cur = rx_time[q];
+			u8 tid = ac_to_tid[i];
+
+			if (!tx_cur && !rx_cur)
+				continue;
+
+			ieee80211_sta_register_airtime(sta, tid, tx_cur,
+						       rx_cur);
+		}
+	}
+
+	rcu_read_unlock();
+}
+
+static void
+mt7921_mac_decode_he_radiotap_ru(struct mt76_rx_status *status,
+				 struct ieee80211_radiotap_he *he,
+				 __le32 *rxv)
+{
+	u32 ru_h, ru_l;
+	u8 ru, offs = 0;
+
+	ru_l = FIELD_GET(MT_PRXV_HE_RU_ALLOC_L, le32_to_cpu(rxv[0]));
+	ru_h = FIELD_GET(MT_PRXV_HE_RU_ALLOC_H, le32_to_cpu(rxv[1]));
+	ru = (u8)(ru_l | ru_h << 4);
+
+	status->bw = RATE_INFO_BW_HE_RU;
+
+	switch (ru) {
+	case 0 ... 36:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		offs = ru;
+		break;
+	case 37 ... 52:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		offs = ru - 37;
+		break;
+	case 53 ... 60:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		offs = ru - 53;
+		break;
+	case 61 ... 64:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		offs = ru - 61;
+		break;
+	case 65 ... 66:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		offs = ru - 65;
+		break;
+	case 67:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case 68:
+		status->he_ru = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	}
+
+	he->data1 |= HE_BITS(DATA1_BW_RU_ALLOC_KNOWN);
+	he->data2 |= HE_BITS(DATA2_RU_OFFSET_KNOWN) |
+		     le16_encode_bits(offs,
+				      IEEE80211_RADIOTAP_HE_DATA2_RU_OFFSET);
+}
+
+static void
+mt7921_mac_decode_he_radiotap(struct sk_buff *skb,
+			      struct mt76_rx_status *status,
+			      __le32 *rxv, u32 phy)
+{
+	/* TODO: struct ieee80211_radiotap_he_mu */
+	static const struct ieee80211_radiotap_he known = {
+		.data1 = HE_BITS(DATA1_DATA_MCS_KNOWN) |
+			 HE_BITS(DATA1_DATA_DCM_KNOWN) |
+			 HE_BITS(DATA1_STBC_KNOWN) |
+			 HE_BITS(DATA1_CODING_KNOWN) |
+			 HE_BITS(DATA1_LDPC_XSYMSEG_KNOWN) |
+			 HE_BITS(DATA1_DOPPLER_KNOWN) |
+			 HE_BITS(DATA1_BSS_COLOR_KNOWN),
+		.data2 = HE_BITS(DATA2_GI_KNOWN) |
+			 HE_BITS(DATA2_TXBF_KNOWN) |
+			 HE_BITS(DATA2_PE_DISAMBIG_KNOWN) |
+			 HE_BITS(DATA2_TXOP_KNOWN),
+	};
+	struct ieee80211_radiotap_he *he = NULL;
+	u32 ltf_size = le32_get_bits(rxv[2], MT_CRXV_HE_LTF_SIZE) + 1;
+
+	he = skb_push(skb, sizeof(known));
+	memcpy(he, &known, sizeof(known));
+
+	he->data3 = HE_PREP(DATA3_BSS_COLOR, BSS_COLOR, rxv[14]) |
+		    HE_PREP(DATA3_LDPC_XSYMSEG, LDPC_EXT_SYM, rxv[2]);
+	he->data5 = HE_PREP(DATA5_PE_DISAMBIG, PE_DISAMBIG, rxv[2]) |
+		    le16_encode_bits(ltf_size,
+				     IEEE80211_RADIOTAP_HE_DATA5_LTF_SIZE);
+	he->data6 = HE_PREP(DATA6_TXOP, TXOP_DUR, rxv[14]) |
+		    HE_PREP(DATA6_DOPPLER, DOPPLER, rxv[14]);
+
+	switch (phy) {
+	case MT_PHY_TYPE_HE_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_BEAM_CHANGE_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_BEAM_CHANGE, BEAM_CHNG, rxv[14]) |
+			     HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+		break;
+	case MT_PHY_TYPE_HE_EXT_SU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_EXT_SU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		break;
+	case MT_PHY_TYPE_HE_MU:
+		he->data1 |= HE_BITS(DATA1_FORMAT_MU) |
+			     HE_BITS(DATA1_UL_DL_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE_KNOWN);
+
+		he->data3 |= HE_PREP(DATA3_UL_DL, UPLINK, rxv[2]);
+		he->data4 |= HE_PREP(DATA4_SU_MU_SPTL_REUSE, SR_MASK, rxv[11]);
+
+		mt7921_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	case MT_PHY_TYPE_HE_TB:
+		he->data1 |= HE_BITS(DATA1_FORMAT_TRIG) |
+			     HE_BITS(DATA1_SPTL_REUSE_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE2_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE3_KNOWN) |
+			     HE_BITS(DATA1_SPTL_REUSE4_KNOWN);
+
+		he->data4 |= HE_PREP(DATA4_TB_SPTL_REUSE1, SR_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE2, SR1_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE3, SR2_MASK, rxv[11]) |
+			     HE_PREP(DATA4_TB_SPTL_REUSE4, SR3_MASK, rxv[11]);
+
+		mt7921_mac_decode_he_radiotap_ru(status, he, rxv);
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+mt7921_get_status_freq_info(struct mt7921_dev *dev, struct mt76_phy *mphy,
+			    struct mt76_rx_status *status, u8 chfreq)
+{
+	if (!test_bit(MT76_HW_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) &&
+	    !test_bit(MT76_STATE_ROC, &mphy->state)) {
+		status->freq = mphy->chandef.chan->center_freq;
+		status->band = mphy->chandef.chan->band;
+		return;
+	}
+
+	status->band = chfreq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
+}
+
+int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt7921_phy *phy = &dev->phy;
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_hdr *hdr;
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *rxv = NULL;
+	u32 mode = 0;
+	u32 rxd1 = le32_to_cpu(rxd[1]);
+	u32 rxd2 = le32_to_cpu(rxd[2]);
+	u32 rxd3 = le32_to_cpu(rxd[3]);
+	bool unicast, insert_ccmp_hdr = false;
+	u8 remove_pad;
+	int i, idx;
+	u8 chfreq;
+
+	memset(status, 0, sizeof(*status));
+
+	if (rxd1 & MT_RXD1_NORMAL_BAND_IDX)
+		return -EINVAL;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mphy->state))
+		return -EINVAL;
+
+	chfreq = FIELD_GET(MT_RXD3_NORMAL_CH_FREQ, rxd3);
+	unicast = FIELD_GET(MT_RXD3_NORMAL_ADDR_TYPE, rxd3) == MT_RXD3_NORMAL_U2M;
+	idx = FIELD_GET(MT_RXD1_NORMAL_WLAN_IDX, rxd1);
+	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
+
+	if (status->wcid) {
+		struct mt7921_sta *msta;
+
+		msta = container_of(status->wcid, struct mt7921_sta, wcid);
+		spin_lock_bh(&dev->sta_poll_lock);
+		if (list_empty(&msta->poll_list))
+			list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+		spin_unlock_bh(&dev->sta_poll_lock);
+	}
+
+	mt7921_get_status_freq_info(dev, mphy, status, chfreq);
+
+	if (status->band == NL80211_BAND_5GHZ)
+		sband = &mphy->sband_5g.sband;
+	else
+		sband = &mphy->sband_2g.sband;
+
+	if (!sband->channels)
+		return -EINVAL;
+
+	if (rxd1 & MT_RXD1_NORMAL_FCS_ERR)
+		status->flag |= RX_FLAG_FAILED_FCS_CRC;
+
+	if (rxd1 & MT_RXD1_NORMAL_TKIP_MIC_ERR)
+		status->flag |= RX_FLAG_MMIC_ERROR;
+
+	if (FIELD_GET(MT_RXD1_NORMAL_SEC_MODE, rxd1) != 0 &&
+	    !(rxd1 & (MT_RXD1_NORMAL_CLM | MT_RXD1_NORMAL_CM))) {
+		status->flag |= RX_FLAG_DECRYPTED;
+		status->flag |= RX_FLAG_IV_STRIPPED;
+		status->flag |= RX_FLAG_MMIC_STRIPPED | RX_FLAG_MIC_STRIPPED;
+	}
+
+	if (!(rxd2 & MT_RXD2_NORMAL_NON_AMPDU)) {
+		status->flag |= RX_FLAG_AMPDU_DETAILS;
+
+		/* all subframes of an A-MPDU have the same timestamp */
+		if (phy->rx_ampdu_ts != rxd[14]) {
+			if (!++phy->ampdu_ref)
+				phy->ampdu_ref++;
+		}
+		phy->rx_ampdu_ts = rxd[14];
+
+		status->ampdu_ref = phy->ampdu_ref;
+	}
+
+	remove_pad = FIELD_GET(MT_RXD2_NORMAL_HDR_OFFSET, rxd2);
+
+	if (rxd2 & MT_RXD2_NORMAL_MAX_LEN_ERROR)
+		return -EINVAL;
+
+	rxd += 6;
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
+		u8 *data = (u8 *)rxd;
+
+		if (status->flag & RX_FLAG_DECRYPTED) {
+			status->iv[0] = data[5];
+			status->iv[1] = data[4];
+			status->iv[2] = data[3];
+			status->iv[3] = data[2];
+			status->iv[4] = data[1];
+			status->iv[5] = data[0];
+
+			insert_ccmp_hdr = FIELD_GET(MT_RXD2_NORMAL_FRAG, rxd2);
+		}
+		rxd += 4;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+	}
+
+	/* RXD Group 3 - P-RXV */
+	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
+		u32 v0, v1, v2;
+
+		rxv = rxd;
+		rxd += 2;
+		if ((u8 *)rxd - skb->data >= skb->len)
+			return -EINVAL;
+
+		v0 = le32_to_cpu(rxv[0]);
+		v1 = le32_to_cpu(rxv[1]);
+		v2 = le32_to_cpu(rxv[2]);
+
+		if (v0 & MT_PRXV_HT_AD_CODE)
+			status->enc_flags |= RX_ENC_FLAG_LDPC;
+
+		status->chains = mphy->antenna_mask;
+		status->chain_signal[0] = to_rssi(MT_PRXV_RCPI0, v1);
+		status->chain_signal[1] = to_rssi(MT_PRXV_RCPI1, v1);
+		status->chain_signal[2] = to_rssi(MT_PRXV_RCPI2, v1);
+		status->chain_signal[3] = to_rssi(MT_PRXV_RCPI3, v1);
+		status->signal = status->chain_signal[0];
+
+		for (i = 1; i < hweight8(mphy->antenna_mask); i++) {
+			if (!(status->chains & BIT(i)))
+				continue;
+
+			status->signal = max(status->signal,
+					     status->chain_signal[i]);
+		}
+
+		/* RXD Group 5 - C-RXV */
+		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
+			u8 stbc = FIELD_GET(MT_CRXV_HT_STBC, v2);
+			u8 gi = FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
+			bool cck = false;
+
+			rxd += 18;
+			if ((u8 *)rxd - skb->data >= skb->len)
+				return -EINVAL;
+
+			idx = i = FIELD_GET(MT_PRXV_TX_RATE, v0);
+			mode = FIELD_GET(MT_CRXV_TX_MODE, v2);
+
+			switch (mode) {
+			case MT_PHY_TYPE_CCK:
+				cck = true;
+				fallthrough;
+			case MT_PHY_TYPE_OFDM:
+				i = mt76_get_rate(&dev->mt76, sband, i, cck);
+				break;
+			case MT_PHY_TYPE_HT_GF:
+			case MT_PHY_TYPE_HT:
+				status->encoding = RX_ENC_HT;
+				if (i > 31)
+					return -EINVAL;
+				break;
+			case MT_PHY_TYPE_VHT:
+				status->nss =
+					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+				status->encoding = RX_ENC_VHT;
+				if (i > 9)
+					return -EINVAL;
+				break;
+			case MT_PHY_TYPE_HE_MU:
+				status->flag |= RX_FLAG_RADIOTAP_HE_MU;
+				fallthrough;
+			case MT_PHY_TYPE_HE_SU:
+			case MT_PHY_TYPE_HE_EXT_SU:
+			case MT_PHY_TYPE_HE_TB:
+				status->nss =
+					FIELD_GET(MT_PRXV_NSTS, v0) + 1;
+				status->encoding = RX_ENC_HE;
+				status->flag |= RX_FLAG_RADIOTAP_HE;
+				i &= GENMASK(3, 0);
+
+				if (gi <= NL80211_RATE_INFO_HE_GI_3_2)
+					status->he_gi = gi;
+
+				status->he_dcm = !!(idx & MT_PRXV_TX_DCM);
+				break;
+			default:
+				return -EINVAL;
+			}
+			status->rate_idx = i;
+
+			switch (FIELD_GET(MT_CRXV_FRAME_MODE, v2)) {
+			case IEEE80211_STA_RX_BW_20:
+				break;
+			case IEEE80211_STA_RX_BW_40:
+				if (mode & MT_PHY_TYPE_HE_EXT_SU &&
+				    (idx & MT_PRXV_TX_ER_SU_106T)) {
+					status->bw = RATE_INFO_BW_HE_RU;
+					status->he_ru =
+						NL80211_RATE_INFO_HE_RU_ALLOC_106;
+				} else {
+					status->bw = RATE_INFO_BW_40;
+				}
+				break;
+			case IEEE80211_STA_RX_BW_80:
+				status->bw = RATE_INFO_BW_80;
+				break;
+			case IEEE80211_STA_RX_BW_160:
+				status->bw = RATE_INFO_BW_160;
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			status->enc_flags |= RX_ENC_FLAG_STBC_MASK * stbc;
+			if (mode < MT_PHY_TYPE_HE_SU && gi)
+				status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		}
+	}
+
+	skb_pull(skb, (u8 *)rxd - skb->data + 2 * remove_pad);
+
+	if (insert_ccmp_hdr) {
+		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
+
+		mt76_insert_ccmp_hdr(skb, key_id);
+	}
+
+	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE)
+		mt7921_mac_decode_he_radiotap(skb, status, rxv, mode);
+
+	hdr = mt76_skb_get_hdr(skb);
+	if (!status->wcid || !ieee80211_is_data_qos(hdr->frame_control))
+		return 0;
+
+	status->aggr = unicast &&
+		       !ieee80211_is_qos_nullfunc(hdr->frame_control);
+	status->tid = *ieee80211_get_qos_ctl(hdr) & IEEE80211_QOS_CTL_TID_MASK;
+	status->seqno = IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl));
+
+	return 0;
+}
+
+static void
+mt7921_mac_write_txwi_8023(struct mt7921_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid)
+{
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	u8 fc_type, fc_stype;
+	bool wmm = false;
+	u32 val;
+
+	if (wcid->sta) {
+		struct ieee80211_sta *sta;
+
+		sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);
+		wmm = sta->wme;
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_3) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+
+	if (be16_to_cpu(skb->protocol) >= ETH_P_802_3_MIN)
+		val |= MT_TXD1_ETH_802_3;
+
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = IEEE80211_FTYPE_DATA >> 2;
+	fc_stype = wmm ? IEEE80211_STYPE_QOS_DATA >> 4 : 0;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
+
+	txwi[2] |= cpu_to_le32(val);
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+}
+
+static void
+mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
+			    struct sk_buff *skb, struct ieee80211_key_conf *key)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
+	u8 tid = skb->priority & IEEE80211_QOS_CTL_TID_MASK;
+	__le16 fc = hdr->frame_control;
+	u8 fc_type, fc_stype;
+	u32 val;
+
+	if (ieee80211_is_action(fc) &&
+	    mgmt->u.action.category == WLAN_CATEGORY_BACK &&
+	    mgmt->u.action.u.addba_req.action_code == WLAN_ACTION_ADDBA_REQ) {
+		u16 capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
+
+		txwi[5] |= cpu_to_le32(MT_TXD5_ADD_BA);
+		tid = (capab >> 2) & IEEE80211_QOS_CTL_TID_MASK;
+	} else if (ieee80211_is_back_req(hdr->frame_control)) {
+		struct ieee80211_bar *bar = (struct ieee80211_bar *)hdr;
+		u16 control = le16_to_cpu(bar->control);
+
+		tid = FIELD_GET(IEEE80211_BAR_CTRL_TID_INFO_MASK, control);
+	}
+
+	val = FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_802_11) |
+	      FIELD_PREP(MT_TXD1_HDR_INFO,
+			 ieee80211_get_hdrlen_from_skb(skb) / 2) |
+	      FIELD_PREP(MT_TXD1_TID, tid);
+	txwi[1] |= cpu_to_le32(val);
+
+	fc_type = (le16_to_cpu(fc) & IEEE80211_FCTL_FTYPE) >> 2;
+	fc_stype = (le16_to_cpu(fc) & IEEE80211_FCTL_STYPE) >> 4;
+
+	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
+	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+
+	if (key && multicast && ieee80211_is_robust_mgmt_frame(skb) &&
+	    key->cipher == WLAN_CIPHER_SUITE_AES_CMAC) {
+		val |= MT_TXD2_BIP;
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_PROTECT_FRAME);
+	}
+
+	if (!ieee80211_is_data(fc) || multicast)
+		val |= MT_TXD2_FIX_RATE;
+
+	txwi[2] |= cpu_to_le32(val);
+
+	if (ieee80211_is_beacon(fc)) {
+		txwi[3] &= ~cpu_to_le32(MT_TXD3_SW_POWER_MGMT);
+		txwi[3] |= cpu_to_le32(MT_TXD3_REM_TX_COUNT);
+	}
+
+	if (info->flags & IEEE80211_TX_CTL_INJECTED) {
+		u16 seqno = le16_to_cpu(hdr->seq_ctrl);
+
+		if (ieee80211_is_back_req(hdr->frame_control)) {
+			struct ieee80211_bar *bar;
+
+			bar = (struct ieee80211_bar *)skb->data;
+			seqno = le16_to_cpu(bar->start_seq_num);
+		}
+
+		val = MT_TXD3_SN_VALID |
+		      FIELD_PREP(MT_TXD3_SEQ, IEEE80211_SEQ_TO_SN(seqno));
+		txwi[3] |= cpu_to_le32(val);
+	}
+
+	val = FIELD_PREP(MT_TXD7_TYPE, fc_type) |
+	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
+	txwi[7] |= cpu_to_le32(val);
+}
+
+void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, bool beacon)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt76_phy *mphy = &dev->mphy;
+	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+	u16 tx_count = 15;
+	u32 val;
+
+	if (vif) {
+		struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+
+		omac_idx = mvif->omac_idx;
+		wmm_idx = mvif->wmm_idx;
+	}
+
+	if (beacon) {
+		p_fmt = MT_TX_TYPE_FW;
+		q_idx = MT_LMAC_BCN0;
+	} else if (skb_get_queue_mapping(skb) >= MT_TXQ_PSD) {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = MT_LMAC_ALTX0;
+	} else {
+		p_fmt = MT_TX_TYPE_CT;
+		q_idx = wmm_idx * MT7921_MAX_WMM_SETS +
+			mt7921_lmac_mapping(dev, skb_get_queue_mapping(skb));
+	}
+
+	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + MT_TXD_SIZE) |
+	      FIELD_PREP(MT_TXD0_PKT_FMT, p_fmt) |
+	      FIELD_PREP(MT_TXD0_Q_IDX, q_idx);
+	txwi[0] = cpu_to_le32(val);
+
+	val = MT_TXD1_LONG_FORMAT |
+	      FIELD_PREP(MT_TXD1_WLAN_IDX, wcid->idx) |
+	      FIELD_PREP(MT_TXD1_OWN_MAC, omac_idx);
+
+	txwi[1] = cpu_to_le32(val);
+	txwi[2] = 0;
+
+	val = MT_TXD3_SW_POWER_MGMT |
+	      FIELD_PREP(MT_TXD3_REM_TX_COUNT, tx_count);
+	if (key)
+		val |= MT_TXD3_PROTECT_FRAME;
+	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
+		val |= MT_TXD3_NO_ACK;
+
+	txwi[3] = cpu_to_le32(val);
+	txwi[4] = 0;
+	txwi[5] = 0;
+	txwi[6] = 0;
+	txwi[7] = wcid->amsdu ? cpu_to_le32(MT_TXD7_HW_AMSDU) : 0;
+
+	if (is_8023)
+		mt7921_mac_write_txwi_8023(dev, txwi, skb, wcid);
+	else
+		mt7921_mac_write_txwi_80211(dev, txwi, skb, key);
+
+	if (txwi[2] & cpu_to_le32(MT_TXD2_FIX_RATE)) {
+		u16 rate;
+
+		/* hardware won't add HTC for mgmt/ctrl frame */
+		txwi[2] |= cpu_to_le32(MT_TXD2_HTC_VLD);
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			rate = MT7921_5G_RATE_DEFAULT;
+		else
+			rate = MT7921_2G_RATE_DEFAULT;
+
+		val = MT_TXD6_FIXED_BW |
+		      FIELD_PREP(MT_TXD6_TX_RATE, rate);
+		txwi[6] |= cpu_to_le32(val);
+		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
+	}
+}
+
+static void
+mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
+		    void *txp_ptr, u32 id)
+{
+	struct mt7921_hw_txp *txp = txp_ptr;
+	struct mt7921_txp_ptr *ptr = &txp->ptr[0];
+	int i, nbuf = tx_info->nbuf - 1;
+
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->nbuf = 1;
+
+	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
+
+	for (i = 0; i < nbuf; i++) {
+		u16 len = tx_info->buf[i + 1].len & MT_TXD_LEN_MASK;
+		u32 addr = tx_info->buf[i + 1].addr;
+
+		if (i == nbuf - 1)
+			len |= MT_TXD_LEN_LAST;
+
+		if (i & 1) {
+			ptr->buf1 = cpu_to_le32(addr);
+			ptr->len1 = cpu_to_le16(len);
+			ptr++;
+		} else {
+			ptr->buf0 = cpu_to_le32(addr);
+			ptr->len0 = cpu_to_le16(len);
+		}
+	}
+}
+
+static void mt7921_set_tx_blocked(struct mt7921_dev *dev, bool blocked)
+{
+	struct mt76_phy *mphy = &dev->mphy;
+	struct mt76_queue *q;
+
+	q = mphy->q_tx[0];
+	if (blocked == q->blocked)
+		return;
+
+	q->blocked = blocked;
+	if (!blocked)
+		mt76_worker_schedule(&dev->mt76.tx_worker);
+}
+
+int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct mt76_tx_cb *cb = mt76_tx_skb_cb(tx_info->skb);
+	struct mt76_txwi_cache *t;
+	struct mt7921_txp_common *txp;
+	int id;
+	u8 *txwi = (u8 *)txwi_ptr;
+
+	if (unlikely(tx_info->skb->len <= ETH_HLEN))
+		return -EINVAL;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	cb->wcid = wcid->idx;
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	spin_lock_bh(&dev->token_lock);
+	id = idr_alloc(&dev->token, t, 0, MT7921_TOKEN_SIZE, GFP_ATOMIC);
+	if (id >= 0)
+		dev->token_count++;
+
+	if (dev->token_count >= MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR)
+		mt7921_set_tx_blocked(dev, true);
+	spin_unlock_bh(&dev->token_lock);
+
+	if (id < 0)
+		return id;
+
+	mt7921_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+			      false);
+
+	txp = (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
+	memset(txp, 0, sizeof(struct mt7921_txp_common));
+	mt7921_write_hw_txp(dev, tx_info, txp, id);
+
+	tx_info->skb = DMA_DUMMY_DATA;
+
+	return 0;
+}
+
+static void
+mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
+{
+	struct mt7921_sta *msta;
+	u16 fc, tid;
+	u32 val;
+
+	if (!sta || !sta->ht_cap.ht_supported)
+		return;
+
+	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
+	if (tid >= 6) /* skip VO queue */
+		return;
+
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
+		return;
+
+	msta = (struct mt7921_sta *)sta->drv_priv;
+	if (!test_and_set_bit(tid, &msta->ampdu_state))
+		ieee80211_start_tx_ba_session(sta, tid, 0);
+}
+
+static void
+mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
+			  struct ieee80211_sta *sta, u8 stat,
+			  struct list_head *free_list)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_tx_status status = {
+		.sta = sta,
+		.info = info,
+		.skb = skb,
+		.free_list = free_list,
+	};
+	struct ieee80211_hw *hw;
+
+	if (sta) {
+		struct mt7921_sta *msta;
+
+		msta = (struct mt7921_sta *)sta->drv_priv;
+		status.rate = &msta->stats.tx_rate;
+	}
+
+	hw = mt76_tx_status_get_hw(mdev, skb);
+
+	if (info->flags & IEEE80211_TX_CTL_AMPDU)
+		info->flags |= IEEE80211_TX_STAT_AMPDU;
+
+	if (stat)
+		ieee80211_tx_info_clear_status(info);
+
+	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.tx_time = 0;
+	ieee80211_tx_status_ext(hw, &status);
+}
+
+void mt7921_txp_skb_unmap(struct mt76_dev *dev,
+			  struct mt76_txwi_cache *t)
+{
+	struct mt7921_txp_common *txp;
+	int i;
+
+	txp = mt7921_txwi_to_txp(dev, t);
+
+	for (i = 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
+		struct mt7921_txp_ptr *ptr = &txp->hw.ptr[i];
+		bool last;
+		u16 len;
+
+		len = le16_to_cpu(ptr->len0);
+		last = len & MT_TXD_LEN_LAST;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf0), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+
+		len = le16_to_cpu(ptr->len1);
+		last = len & MT_TXD_LEN_LAST;
+		len &= MT_TXD_LEN_MASK;
+		dma_unmap_single(dev->dev, le32_to_cpu(ptr->buf1), len,
+				 DMA_TO_DEVICE);
+		if (last)
+			break;
+	}
+}
+
+void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_tx_free *free = (struct mt7921_tx_free *)skb->data;
+	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_txwi_cache *txwi;
+	struct ieee80211_sta *sta = NULL;
+	LIST_HEAD(free_list);
+	struct sk_buff *tmp;
+	bool wake = false;
+	u8 i, count;
+
+	/* clean DMA queues and unmap buffers first */
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_PSD], false);
+	mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[MT_TXQ_BE], false);
+
+	/* TODO: MT_TX_FREE_LATENCY is msdu time from the TXD is queued into PLE,
+	 * to the time ack is received or dropped by hw (air + hw queue time).
+	 * Should avoid accessing WTBL to get Tx airtime, and use it instead.
+	 */
+	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
+	for (i = 0; i < count; i++) {
+		u32 msdu, info = le32_to_cpu(free->info[i]);
+		u8 stat;
+
+		/* 1'b1: new wcid pair.
+		 * 1'b0: msdu_id with the same 'wcid pair' as above.
+		 */
+		if (info & MT_TX_FREE_PAIR) {
+			struct mt7921_sta *msta;
+			struct mt7921_phy *phy;
+			struct mt76_wcid *wcid;
+			u16 idx;
+
+			count++;
+			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
+			wcid = rcu_dereference(dev->mt76.wcid[idx]);
+			sta = wcid_to_sta(wcid);
+			if (!sta)
+				continue;
+
+			msta = container_of(wcid, struct mt7921_sta, wcid);
+			phy = msta->vif->phy;
+			spin_lock_bh(&dev->sta_poll_lock);
+			if (list_empty(&msta->stats_list))
+				list_add_tail(&msta->stats_list, &phy->stats_list);
+			if (list_empty(&msta->poll_list))
+				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
+			spin_unlock_bh(&dev->sta_poll_lock);
+			continue;
+		}
+
+		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
+		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
+
+		spin_lock_bh(&dev->token_lock);
+		txwi = idr_remove(&dev->token, msdu);
+		if (txwi)
+			dev->token_count--;
+		if (dev->token_count < MT7921_TOKEN_SIZE - MT7921_TOKEN_FREE_THR &&
+		    dev->mphy.q_tx[0]->blocked)
+			wake = true;
+		spin_unlock_bh(&dev->token_lock);
+
+		if (!txwi)
+			continue;
+
+		mt7921_txp_skb_unmap(mdev, txwi);
+		if (txwi->skb) {
+			struct ieee80211_tx_info *info = IEEE80211_SKB_CB(txwi->skb);
+			void *txwi_ptr = mt76_get_txwi_ptr(mdev, txwi);
+
+			if (likely(txwi->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+				mt7921_tx_check_aggr(sta, txwi_ptr);
+
+			if (sta && !info->tx_time_est) {
+				struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+				int pending;
+
+				pending = atomic_dec_return(&wcid->non_aql_packets);
+				if (pending < 0)
+					atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
+			}
+
+			mt7921_tx_complete_status(mdev, txwi->skb, sta, stat, &free_list);
+			txwi->skb = NULL;
+		}
+
+		mt76_put_txwi(mdev, txwi);
+	}
+
+	mt7921_mac_sta_poll(dev);
+
+	if (wake) {
+		spin_lock_bh(&dev->token_lock);
+		mt7921_set_tx_blocked(dev, false);
+		spin_unlock_bh(&dev->token_lock);
+	}
+
+	mt76_worker_schedule(&dev->mt76.tx_worker);
+
+	napi_consume_skb(skb, 1);
+
+	list_for_each_entry_safe(skb, tmp, &free_list, list) {
+		skb_list_del_init(skb);
+		napi_consume_skb(skb, 1);
+	}
+}
+
+void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
+{
+	struct mt7921_dev *dev;
+
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_txwi_cache *t;
+		struct mt7921_txp_common *txp;
+		u16 token;
+
+		txp = mt7921_txwi_to_txp(mdev, e->txwi);
+
+		token = le16_to_cpu(txp->hw.msdu_id[0]) & ~MT_MSDU_ID_VALID;
+		spin_lock_bh(&dev->token_lock);
+		t = idr_remove(&dev->token, token);
+		spin_unlock_bh(&dev->token_lock);
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb) {
+		struct mt76_tx_cb *cb = mt76_tx_skb_cb(e->skb);
+		struct mt76_wcid *wcid;
+
+		wcid = rcu_dereference(dev->mt76.wcid[cb->wcid]);
+
+		mt7921_tx_complete_status(mdev, e->skb, wcid_to_sta(wcid), 0,
+					  NULL);
+	}
+}
+
+void mt7921_mac_reset_counters(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		mt76_rr(dev, MT_TX_AGG_CNT(0, i));
+		mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
+	}
+
+	dev->mt76.phy.survey_time = ktime_get_boottime();
+	memset(&dev->mt76.aggr_stats[0], 0, sizeof(dev->mt76.aggr_stats) / 2);
+
+	/* reset airtime counters */
+	mt76_rr(dev, MT_MIB_SDR9(0));
+	mt76_rr(dev, MT_MIB_SDR36(0));
+	mt76_rr(dev, MT_MIB_SDR37(0));
+
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+	mt76_set(dev, MT_WF_RMAC_MIB_AIRTIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+}
+
+void mt7921_mac_set_timing(struct mt7921_phy *phy)
+{
+	s16 coverage_class = phy->coverage_class;
+	struct mt7921_dev *dev = phy->dev;
+	u32 val, reg_offset;
+	u32 cck = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 231) |
+		  FIELD_PREP(MT_TIMEOUT_VAL_CCA, 48);
+	u32 ofdm = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, 60) |
+		   FIELD_PREP(MT_TIMEOUT_VAL_CCA, 28);
+	int sifs, offset;
+	bool is_5ghz = phy->mt76->chandef.chan->band == NL80211_BAND_5GHZ;
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
+		return;
+
+	if (is_5ghz)
+		sifs = 16;
+	else
+		sifs = 10;
+
+	mt76_set(dev, MT_ARB_SCR(0),
+		 MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+	udelay(1);
+
+	offset = 3 * coverage_class;
+	reg_offset = FIELD_PREP(MT_TIMEOUT_VAL_PLCP, offset) |
+		     FIELD_PREP(MT_TIMEOUT_VAL_CCA, offset);
+
+	mt76_wr(dev, MT_TMAC_CDTR(0), cck + reg_offset);
+	mt76_wr(dev, MT_TMAC_ODTR(0), ofdm + reg_offset);
+	mt76_wr(dev, MT_TMAC_ICR0(0),
+		FIELD_PREP(MT_IFS_EIFS, 360) |
+		FIELD_PREP(MT_IFS_RIFS, 2) |
+		FIELD_PREP(MT_IFS_SIFS, sifs) |
+		FIELD_PREP(MT_IFS_SLOT, phy->slottime));
+
+	if (phy->slottime < 20 || is_5ghz)
+		val = MT7921_CFEND_RATE_DEFAULT;
+	else
+		val = MT7921_CFEND_RATE_11B;
+
+	mt76_rmw_field(dev, MT_AGG_ACR0(0), MT_AGG_ACR_CFEND_RATE, val);
+	mt76_clear(dev, MT_ARB_SCR(0),
+		   MT_ARB_SCR_TX_DISABLE | MT_ARB_SCR_RX_DISABLE);
+}
+
+static u8
+mt7921_phy_get_nf(struct mt7921_phy *phy, int idx)
+{
+	return 0;
+}
+
+static void
+mt7921_phy_update_channel(struct mt76_phy *mphy, int idx)
+{
+	struct mt7921_dev *dev = container_of(mphy->dev, struct mt7921_dev, mt76);
+	struct mt7921_phy *phy = (struct mt7921_phy *)mphy->priv;
+	struct mt76_channel_state *state;
+	u64 busy_time, tx_time, rx_time, obss_time;
+	int nf;
+
+	busy_time = mt76_get_field(dev, MT_MIB_SDR9(idx),
+				   MT_MIB_SDR9_BUSY_MASK);
+	tx_time = mt76_get_field(dev, MT_MIB_SDR36(idx),
+				 MT_MIB_SDR36_TXTIME_MASK);
+	rx_time = mt76_get_field(dev, MT_MIB_SDR37(idx),
+				 MT_MIB_SDR37_RXTIME_MASK);
+	obss_time = mt76_get_field(dev, MT_WF_RMAC_MIB_AIRTIME14(idx),
+				   MT_MIB_OBSSTIME_MASK);
+
+	nf = mt7921_phy_get_nf(phy, idx);
+	if (!phy->noise)
+		phy->noise = nf << 4;
+	else if (nf)
+		phy->noise += nf - (phy->noise >> 4);
+
+	state = mphy->chan_state;
+	state->cc_busy += busy_time;
+	state->cc_tx += tx_time;
+	state->cc_rx += rx_time + obss_time;
+	state->cc_bss_rx += rx_time;
+	state->noise = -(phy->noise >> 4);
+}
+
+void mt7921_update_channel(struct mt76_dev *mdev)
+{
+	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
+
+	mt7921_phy_update_channel(&mdev->phy, 0);
+	/* reset obss airtime */
+	mt76_set(dev, MT_WF_RMAC_MIB_TIME0(0), MT_WF_RMAC_MIB_RXTIME_CLR);
+}
+
+static bool
+mt7921_wait_reset_state(struct mt7921_dev *dev, u32 state)
+{
+	bool ret;
+
+	ret = wait_event_timeout(dev->reset_wait,
+				 (READ_ONCE(dev->reset_state) & state),
+				 MT7921_RESET_TIMEOUT);
+
+	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
+	return ret;
+}
+
+static void
+mt7921_dma_reset(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	int i;
+
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	usleep_range(1000, 2000);
+
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], true);
+	for (i = 0; i < __MT_TXQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, phy->mt76->q_tx[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		mt76_queue_rx_reset(dev, i);
+	}
+
+	mt76_set(dev, MT_WFDMA0_GLO_CFG,
+		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+}
+
+void mt7921_tx_token_put(struct mt7921_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->token_lock);
+	idr_for_each_entry(&dev->token, txwi, id) {
+		mt7921_txp_skb_unmap(&dev->mt76, txwi);
+		if (txwi->skb) {
+			struct ieee80211_hw *hw;
+
+			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
+			ieee80211_free_txskb(hw, txwi->skb);
+		}
+		mt76_put_txwi(&dev->mt76, txwi);
+		dev->token_count--;
+	}
+	spin_unlock_bh(&dev->token_lock);
+	idr_destroy(&dev->token);
+}
+
+/* system error recovery */
+void mt7921_mac_reset_work(struct work_struct *work)
+{
+	struct mt7921_dev *dev;
+
+	dev = container_of(work, struct mt7921_dev, reset_work);
+
+	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_DMA))
+		return;
+
+	ieee80211_stop_queues(mt76_hw(dev));
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+
+	/* lock/unlock all queues to ensure that no tx is pending */
+	mt76_txq_schedule_all(&dev->mphy);
+
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	napi_disable(&dev->mt76.napi[0]);
+	napi_disable(&dev->mt76.napi[1]);
+	napi_disable(&dev->mt76.napi[2]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
+
+	mt7921_tx_token_put(dev);
+	idr_init(&dev->token);
+
+	if (mt7921_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
+		mt7921_dma_reset(&dev->phy);
+
+		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
+		mt7921_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
+	}
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+
+	napi_enable(&dev->mt76.napi[0]);
+	napi_schedule(&dev->mt76.napi[0]);
+
+	napi_enable(&dev->mt76.napi[1]);
+	napi_schedule(&dev->mt76.napi[1]);
+
+	napi_enable(&dev->mt76.napi[2]);
+	napi_schedule(&dev->mt76.napi[2]);
+
+	ieee80211_wake_queues(mt76_hw(dev));
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7921_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
+				     MT7921_WATCHDOG_TIME);
+}
+
+static void
+mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	struct mib_stats *mib = &phy->mib;
+	int i, aggr0 = 0, aggr1;
+
+	memset(mib, 0, sizeof(*mib));
+
+	mib->fcs_err_cnt = mt76_get_field(dev, MT_MIB_SDR3(0),
+					  MT_MIB_SDR3_FCS_ERR_MASK);
+
+	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
+		u32 val, val2;
+
+		val = mt76_rr(dev, MT_MIB_MB_SDR1(0, i));
+
+		val2 = FIELD_GET(MT_MIB_ACK_FAIL_COUNT_MASK, val);
+		if (val2 > mib->ack_fail_cnt)
+			mib->ack_fail_cnt = val2;
+
+		val2 = FIELD_GET(MT_MIB_BA_MISS_COUNT_MASK, val);
+		if (val2 > mib->ba_miss_cnt)
+			mib->ba_miss_cnt = val2;
+
+		val = mt76_rr(dev, MT_MIB_MB_SDR0(0, i));
+		val2 = FIELD_GET(MT_MIB_RTS_RETRIES_COUNT_MASK, val);
+		if (val2 > mib->rts_retries_cnt) {
+			mib->rts_cnt = FIELD_GET(MT_MIB_RTS_COUNT_MASK, val);
+			mib->rts_retries_cnt = val2;
+		}
+
+		val = mt76_rr(dev, MT_TX_AGG_CNT(0, i));
+		val2 = mt76_rr(dev, MT_TX_AGG_CNT2(0, i));
+
+		dev->mt76.aggr_stats[aggr0++] += val & 0xffff;
+		dev->mt76.aggr_stats[aggr0++] += val >> 16;
+		dev->mt76.aggr_stats[aggr1++] += val2 & 0xffff;
+		dev->mt76.aggr_stats[aggr1++] += val2 >> 16;
+	}
+}
+
+void mt7921_mac_work(struct work_struct *work)
+{
+	struct mt7921_phy *phy;
+	struct mt76_phy *mphy;
+
+	mphy = (struct mt76_phy *)container_of(work, struct mt76_phy,
+					       mac_work.work);
+	phy = mphy->priv;
+
+	mutex_lock(&mphy->dev->mutex);
+
+	mt76_update_survey(mphy->dev);
+	if (++mphy->mac_work_count == 5) {
+		mphy->mac_work_count = 0;
+
+		mt7921_mac_update_mib_stats(phy);
+	}
+
+	mutex_unlock(&mphy->dev->mutex);
+
+	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+				     MT7921_WATCHDOG_TIME);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
new file mode 100644
index 000000000000..a0c1fa0f20e4
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -0,0 +1,333 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_MAC_H
+#define __MT7921_MAC_H
+
+#define MT_CT_PARSE_LEN			72
+#define MT_CT_DMA_BUF_NUM		2
+
+#define MT_RXD0_LENGTH			GENMASK(15, 0)
+#define MT_RXD0_PKT_FLAG                GENMASK(19, 16)
+#define MT_RXD0_PKT_TYPE		GENMASK(31, 27)
+
+#define MT_RXD0_NORMAL_ETH_TYPE_OFS	GENMASK(22, 16)
+#define MT_RXD0_NORMAL_IP_SUM		BIT(23)
+#define MT_RXD0_NORMAL_UDP_TCP_SUM	BIT(24)
+
+enum rx_pkt_type {
+	PKT_TYPE_TXS,
+	PKT_TYPE_TXRXV,
+	PKT_TYPE_NORMAL,
+	PKT_TYPE_RX_DUP_RFB,
+	PKT_TYPE_RX_TMR,
+	PKT_TYPE_RETRIEVE,
+	PKT_TYPE_TXRX_NOTIFY,
+	PKT_TYPE_RX_EVENT,
+	PKT_TYPE_NORMAL_MCU,
+};
+
+/* RXD DW1 */
+#define MT_RXD1_NORMAL_WLAN_IDX		GENMASK(9, 0)
+#define MT_RXD1_NORMAL_GROUP_1		BIT(11)
+#define MT_RXD1_NORMAL_GROUP_2		BIT(12)
+#define MT_RXD1_NORMAL_GROUP_3		BIT(13)
+#define MT_RXD1_NORMAL_GROUP_4		BIT(14)
+#define MT_RXD1_NORMAL_GROUP_5		BIT(15)
+#define MT_RXD1_NORMAL_SEC_MODE		GENMASK(20, 16)
+#define MT_RXD1_NORMAL_KEY_ID		GENMASK(22, 21)
+#define MT_RXD1_NORMAL_CM		BIT(23)
+#define MT_RXD1_NORMAL_CLM		BIT(24)
+#define MT_RXD1_NORMAL_ICV_ERR		BIT(25)
+#define MT_RXD1_NORMAL_TKIP_MIC_ERR	BIT(26)
+#define MT_RXD1_NORMAL_FCS_ERR		BIT(27)
+#define MT_RXD1_NORMAL_BAND_IDX		BIT(28)
+#define MT_RXD1_NORMAL_SPP_EN		BIT(29)
+#define MT_RXD1_NORMAL_ADD_OM		BIT(30)
+#define MT_RXD1_NORMAL_SEC_DONE		BIT(31)
+
+/* RXD DW2 */
+#define MT_RXD2_NORMAL_BSSID		GENMASK(5, 0)
+#define MT_RXD2_NORMAL_CO_ANT		BIT(6)
+#define MT_RXD2_NORMAL_BF_CQI		BIT(7)
+#define MT_RXD2_NORMAL_MAC_HDR_LEN	GENMASK(12, 8)
+#define MT_RXD2_NORMAL_HDR_TRANS	BIT(13)
+#define MT_RXD2_NORMAL_HDR_OFFSET	GENMASK(15, 14)
+#define MT_RXD2_NORMAL_TID		GENMASK(19, 16)
+#define MT_RXD2_NORMAL_MU_BAR		BIT(21)
+#define MT_RXD2_NORMAL_SW_BIT		BIT(22)
+#define MT_RXD2_NORMAL_AMSDU_ERR	BIT(23)
+#define MT_RXD2_NORMAL_MAX_LEN_ERROR	BIT(24)
+#define MT_RXD2_NORMAL_HDR_TRANS_ERROR	BIT(25)
+#define MT_RXD2_NORMAL_INT_FRAME	BIT(26)
+#define MT_RXD2_NORMAL_FRAG		BIT(27)
+#define MT_RXD2_NORMAL_NULL_FRAME	BIT(28)
+#define MT_RXD2_NORMAL_NDATA		BIT(29)
+#define MT_RXD2_NORMAL_NON_AMPDU	BIT(30)
+#define MT_RXD2_NORMAL_BF_REPORT	BIT(31)
+
+/* RXD DW3 */
+#define MT_RXD3_NORMAL_RXV_SEQ		GENMASK(7, 0)
+#define MT_RXD3_NORMAL_CH_FREQ		GENMASK(15, 8)
+#define MT_RXD3_NORMAL_ADDR_TYPE	GENMASK(17, 16)
+#define MT_RXD3_NORMAL_U2M		BIT(0)
+#define MT_RXD3_NORMAL_HTC_VLD		BIT(0)
+#define MT_RXD3_NORMAL_TSF_COMPARE_LOSS	BIT(19)
+#define MT_RXD3_NORMAL_BEACON_MC	BIT(20)
+#define MT_RXD3_NORMAL_BEACON_UC	BIT(21)
+#define MT_RXD3_NORMAL_AMSDU		BIT(22)
+#define MT_RXD3_NORMAL_MESH		BIT(23)
+#define MT_RXD3_NORMAL_MHCP		BIT(24)
+#define MT_RXD3_NORMAL_NO_INFO_WB	BIT(25)
+#define MT_RXD3_NORMAL_DISABLE_RX_HDR_TRANS	BIT(26)
+#define MT_RXD3_NORMAL_POWER_SAVE_STAT	BIT(27)
+#define MT_RXD3_NORMAL_MORE		BIT(28)
+#define MT_RXD3_NORMAL_UNWANT		BIT(29)
+#define MT_RXD3_NORMAL_RX_DROP		BIT(30)
+#define MT_RXD3_NORMAL_VLAN2ETH		BIT(31)
+
+/* RXD DW4 */
+#define MT_RXD4_NORMAL_PAYLOAD_FORMAT	GENMASK(1, 0)
+#define MT_RXD4_NORMAL_PATTERN_DROP	BIT(9)
+#define MT_RXD4_NORMAL_CLS		BIT(10)
+#define MT_RXD4_NORMAL_OFLD		GENMASK(12, 11)
+#define MT_RXD4_NORMAL_MAGIC_PKT	BIT(13)
+#define MT_RXD4_NORMAL_WOL		GENMASK(18, 14)
+#define MT_RXD4_NORMAL_CLS_BITMAP	GENMASK(28, 19)
+#define MT_RXD3_NORMAL_PF_MODE		BIT(29)
+#define MT_RXD3_NORMAL_PF_STS		GENMASK(31, 30)
+
+/* P-RXV */
+#define MT_PRXV_TX_RATE			GENMASK(6, 0)
+#define MT_PRXV_TX_DCM			BIT(4)
+#define MT_PRXV_TX_ER_SU_106T		BIT(5)
+#define MT_PRXV_NSTS			GENMASK(9, 7)
+#define MT_PRXV_HT_AD_CODE		BIT(11)
+#define MT_PRXV_HE_RU_ALLOC_L		GENMASK(31, 28)
+#define MT_PRXV_HE_RU_ALLOC_H		GENMASK(3, 0)
+#define MT_PRXV_RCPI3			GENMASK(31, 24)
+#define MT_PRXV_RCPI2			GENMASK(23, 16)
+#define MT_PRXV_RCPI1			GENMASK(15, 8)
+#define MT_PRXV_RCPI0			GENMASK(7, 0)
+
+/* C-RXV */
+#define MT_CRXV_HT_STBC			GENMASK(1, 0)
+#define MT_CRXV_TX_MODE			GENMASK(7, 4)
+#define MT_CRXV_FRAME_MODE		GENMASK(10, 8)
+#define MT_CRXV_HT_SHORT_GI		GENMASK(14, 13)
+#define MT_CRXV_HE_LTF_SIZE		GENMASK(18, 17)
+#define MT_CRXV_HE_LDPC_EXT_SYM		BIT(20)
+#define MT_CRXV_HE_PE_DISAMBIG		BIT(23)
+#define MT_CRXV_HE_UPLINK		BIT(31)
+
+#define MT_CRXV_HE_SR_MASK		GENMASK(11, 8)
+#define MT_CRXV_HE_SR1_MASK		GENMASK(16, 12)
+#define MT_CRXV_HE_SR2_MASK             GENMASK(20, 17)
+#define MT_CRXV_HE_SR3_MASK             GENMASK(24, 21)
+
+#define MT_CRXV_HE_BSS_COLOR		GENMASK(5, 0)
+#define MT_CRXV_HE_TXOP_DUR		GENMASK(12, 6)
+#define MT_CRXV_HE_BEAM_CHNG		BIT(13)
+#define MT_CRXV_HE_DOPPLER		BIT(16)
+
+#define MT_CRXV_SNR		GENMASK(18, 13)
+#define MT_CRXV_FOE_LO		GENMASK(31, 19)
+#define MT_CRXV_FOE_HI		GENMASK(6, 0)
+#define MT_CRXV_FOE_SHIFT	13
+
+enum tx_header_format {
+	MT_HDR_FORMAT_802_3,
+	MT_HDR_FORMAT_CMD,
+	MT_HDR_FORMAT_802_11,
+	MT_HDR_FORMAT_802_11_EXT,
+};
+
+enum tx_pkt_type {
+	MT_TX_TYPE_CT,
+	MT_TX_TYPE_SF,
+	MT_TX_TYPE_CMD,
+	MT_TX_TYPE_FW,
+};
+
+enum tx_port_idx {
+	MT_TX_PORT_IDX_LMAC,
+	MT_TX_PORT_IDX_MCU
+};
+
+enum tx_mcu_port_q_idx {
+	MT_TX_MCU_PORT_RX_Q0 = 0x20,
+	MT_TX_MCU_PORT_RX_Q1,
+	MT_TX_MCU_PORT_RX_Q2,
+	MT_TX_MCU_PORT_RX_Q3,
+	MT_TX_MCU_PORT_RX_FWDL = 0x3e
+};
+
+#define MT_CT_INFO_APPLY_TXD		BIT(0)
+#define MT_CT_INFO_COPY_HOST_TXD_ALL	BIT(1)
+#define MT_CT_INFO_MGMT_FRAME		BIT(2)
+#define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
+#define MT_CT_INFO_HSR2_TX		BIT(4)
+#define MT_CT_INFO_FROM_HOST		BIT(7)
+
+#define MT_TXD_SIZE			(8 * 4)
+
+#define MT_TXD0_Q_IDX			GENMASK(31, 25)
+#define MT_TXD0_PKT_FMT			GENMASK(24, 23)
+#define MT_TXD0_ETH_TYPE_OFFSET		GENMASK(22, 16)
+#define MT_TXD0_TX_BYTES		GENMASK(15, 0)
+
+#define MT_TXD1_LONG_FORMAT		BIT(31)
+#define MT_TXD1_TGID			BIT(30)
+#define MT_TXD1_OWN_MAC			GENMASK(29, 24)
+#define MT_TXD1_AMSDU			BIT(23)
+#define MT_TXD1_TID			GENMASK(22, 20)
+#define MT_TXD1_HDR_PAD			GENMASK(19, 18)
+#define MT_TXD1_HDR_FORMAT		GENMASK(17, 16)
+#define MT_TXD1_HDR_INFO		GENMASK(15, 11)
+#define MT_TXD1_ETH_802_3		BIT(15)
+#define MT_TXD1_VTA			BIT(10)
+#define MT_TXD1_WLAN_IDX		GENMASK(9, 0)
+
+#define MT_TXD2_FIX_RATE		BIT(31)
+#define MT_TXD2_FIXED_RATE		BIT(30)
+#define MT_TXD2_POWER_OFFSET		GENMASK(29, 24)
+#define MT_TXD2_MAX_TX_TIME		GENMASK(23, 16)
+#define MT_TXD2_FRAG			GENMASK(15, 14)
+#define MT_TXD2_HTC_VLD			BIT(13)
+#define MT_TXD2_DURATION		BIT(12)
+#define MT_TXD2_BIP			BIT(11)
+#define MT_TXD2_MULTICAST		BIT(10)
+#define MT_TXD2_RTS			BIT(9)
+#define MT_TXD2_SOUNDING		BIT(8)
+#define MT_TXD2_NDPA			BIT(7)
+#define MT_TXD2_NDP			BIT(6)
+#define MT_TXD2_FRAME_TYPE		GENMASK(5, 4)
+#define MT_TXD2_SUB_TYPE		GENMASK(3, 0)
+
+#define MT_TXD3_SN_VALID		BIT(31)
+#define MT_TXD3_PN_VALID		BIT(30)
+#define MT_TXD3_SW_POWER_MGMT		BIT(29)
+#define MT_TXD3_BA_DISABLE		BIT(28)
+#define MT_TXD3_SEQ			GENMASK(27, 16)
+#define MT_TXD3_REM_TX_COUNT		GENMASK(15, 11)
+#define MT_TXD3_TX_COUNT		GENMASK(10, 6)
+#define MT_TXD3_TIMING_MEASURE		BIT(5)
+#define MT_TXD3_DAS			BIT(4)
+#define MT_TXD3_EEOSP			BIT(3)
+#define MT_TXD3_EMRD			BIT(2)
+#define MT_TXD3_PROTECT_FRAME		BIT(1)
+#define MT_TXD3_NO_ACK			BIT(0)
+
+#define MT_TXD4_PN_LOW			GENMASK(31, 0)
+
+#define MT_TXD5_PN_HIGH			GENMASK(31, 16)
+#define MT_TXD5_MD			BIT(15)
+#define MT_TXD5_ADD_BA			BIT(14)
+#define MT_TXD5_TX_STATUS_HOST		BIT(10)
+#define MT_TXD5_TX_STATUS_MCU		BIT(9)
+#define MT_TXD5_TX_STATUS_FMT		BIT(8)
+#define MT_TXD5_PID			GENMASK(7, 0)
+
+#define MT_TXD6_TX_IBF			BIT(31)
+#define MT_TXD6_TX_EBF			BIT(30)
+#define MT_TXD6_TX_RATE			GENMASK(29, 16)
+#define MT_TXD6_SGI			GENMASK(15, 14)
+#define MT_TXD6_HELTF			GENMASK(13, 12)
+#define MT_TXD6_LDPC			BIT(11)
+#define MT_TXD6_SPE_ID_IDX		BIT(10)
+#define MT_TXD6_ANT_ID			GENMASK(7, 4)
+#define MT_TXD6_DYN_BW			BIT(3)
+#define MT_TXD6_FIXED_BW		BIT(2)
+#define MT_TXD6_BW			GENMASK(1, 0)
+
+#define MT_TXD7_TXD_LEN			GENMASK(31, 30)
+#define MT_TXD7_UDP_TCP_SUM		BIT(29)
+#define MT_TXD7_IP_SUM			BIT(28)
+
+#define MT_TXD7_TYPE			GENMASK(21, 20)
+#define MT_TXD7_SUB_TYPE		GENMASK(19, 16)
+
+#define MT_TXD7_PSE_FID			GENMASK(27, 16)
+#define MT_TXD7_SPE_IDX			GENMASK(15, 11)
+#define MT_TXD7_HW_AMSDU		BIT(10)
+#define MT_TXD7_TX_TIME			GENMASK(9, 0)
+
+#define MT_TX_RATE_STBC			BIT(13)
+#define MT_TX_RATE_NSS			GENMASK(12, 10)
+#define MT_TX_RATE_MODE			GENMASK(9, 6)
+#define MT_TX_RATE_SU_EXT_TONE		BIT(5)
+#define MT_TX_RATE_DCM			BIT(4)
+#define MT_TX_RATE_IDX			GENMASK(3, 0)
+
+#define MT_TXP_MAX_BUF_NUM		6
+
+struct mt7921_txp {
+	__le16 flags;
+	__le16 token;
+	u8 bss_idx;
+	__le16 rept_wds_wcid;
+	u8 nbuf;
+	__le32 buf[MT_TXP_MAX_BUF_NUM];
+	__le16 len[MT_TXP_MAX_BUF_NUM];
+} __packed __aligned(4);
+
+struct mt7921_tx_free {
+	__le16 rx_byte_cnt;
+	__le16 ctrl;
+	u8 txd_cnt;
+	u8 rsv[3];
+	__le32 info[];
+} __packed __aligned(4);
+
+#define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
+#define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
+#define MT_TX_FREE_LATENCY		GENMASK(12, 0)
+/* 0: success, others: dropped */
+#define MT_TX_FREE_STATUS		GENMASK(14, 13)
+#define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
+#define MT_TX_FREE_PAIR			BIT(31)
+/* will support this field in further revision */
+#define MT_TX_FREE_RATE			GENMASK(13, 0)
+
+static inline struct mt7921_txp_common *
+mt7921_txwi_to_txp(struct mt76_dev *dev, struct mt76_txwi_cache *t)
+{
+	u8 *txwi;
+
+	if (!t)
+		return NULL;
+
+	txwi = mt76_get_txwi_ptr(dev, t);
+
+	return (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
+}
+
+#define MT_HW_TXP_MAX_MSDU_NUM		4
+#define MT_HW_TXP_MAX_BUF_NUM		4
+
+#define MT_MSDU_ID_VALID		BIT(15)
+
+#define MT_TXD_LEN_MASK			GENMASK(11, 0)
+#define MT_TXD_LEN_MSDU_LAST		BIT(14)
+#define MT_TXD_LEN_AMSDU_LAST		BIT(15)
+#define MT_TXD_LEN_LAST			BIT(15)
+
+struct mt7921_txp_ptr {
+	__le32 buf0;
+	__le16 len0;
+	__le16 len1;
+	__le32 buf1;
+} __packed __aligned(4);
+
+struct mt7921_hw_txp {
+	__le16 msdu_id[MT_HW_TXP_MAX_MSDU_NUM];
+	struct mt7921_txp_ptr ptr[MT_HW_TXP_MAX_BUF_NUM / 2];
+} __packed __aligned(4);
+
+struct mt7921_txp_common {
+	union {
+		struct mt7921_hw_txp hw;
+	};
+};
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
new file mode 100644
index 000000000000..d339ee12cb7d
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -0,0 +1,354 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_H
+#define __MT7921_H
+
+#include <linux/interrupt.h>
+#include <linux/ktime.h>
+#include "../mt76.h"
+#include "regs.h"
+
+#define MT7921_MAX_INTERFACES		4
+#define MT7921_MAX_WMM_SETS		4
+#define MT7921_WTBL_SIZE		20
+#define MT7921_WTBL_RESERVED		(MT7921_WTBL_SIZE - 1)
+#define MT7921_WTBL_STA			(MT7921_WTBL_RESERVED - \
+					 MT7921_MAX_INTERFACES)
+
+#define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
+#define MT7921_WATCHDOG_TIME		(HZ / 10)
+#define MT7921_RESET_TIMEOUT		(30 * HZ)
+
+#define MT7921_TX_RING_SIZE		2048
+#define MT7921_TX_MCU_RING_SIZE		256
+#define MT7921_TX_FWDL_RING_SIZE	128
+
+#define MT7921_RX_RING_SIZE		1536
+#define MT7921_RX_MCU_RING_SIZE		512
+
+#define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
+#define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
+
+#define MT7921_EEPROM_SIZE		3584
+#define MT7921_TOKEN_SIZE		8192
+#define MT7921_TOKEN_FREE_THR		64
+
+#define MT7921_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
+#define MT7921_CFEND_RATE_11B		0x03	/* 11B LP, 11M */
+#define MT7921_5G_RATE_DEFAULT		0x4b	/* OFDM 6M */
+#define MT7921_2G_RATE_DEFAULT		0x0	/* CCK 1M */
+
+#define MT7921_SKU_RATE_NUM		161
+#define MT7921_SKU_MAX_DELTA_IDX	MT7921_SKU_RATE_NUM
+#define MT7921_SKU_TABLE_SIZE		(MT7921_SKU_RATE_NUM + 1)
+
+#define MT7921_SCAN_IE_LEN		600
+
+struct mt7921_vif;
+struct mt7921_sta;
+
+enum mt7921_txq_id {
+	MT7921_TXQ_BAND0,
+	MT7921_TXQ_BAND1,
+	MT7921_TXQ_FWDL = 16,
+	MT7921_TXQ_MCU_WM,
+};
+
+enum mt7921_rxq_id {
+	MT7921_RXQ_BAND0 = 0,
+	MT7921_RXQ_BAND1,
+	MT7921_RXQ_MCU_WM = 0,
+};
+
+struct mt7921_sta_stats {
+	struct rate_info prob_rate;
+	struct rate_info tx_rate;
+
+	unsigned long per;
+	unsigned long changed;
+	unsigned long jiffies;
+};
+
+struct mt7921_sta_key_conf {
+	s8 keyidx;
+	u8 key[16];
+};
+
+struct mt7921_sta {
+	struct mt76_wcid wcid; /* must be first */
+
+	struct mt7921_vif *vif;
+
+	struct list_head stats_list;
+	struct list_head poll_list;
+	u32 airtime_ac[8];
+
+	struct mt7921_sta_stats stats;
+
+	unsigned long ampdu_state;
+
+	struct mt7921_sta_key_conf bip;
+};
+
+struct mt7921_vif {
+	u16 idx;
+	u8 omac_idx;
+	u8 band_idx;
+	u8 wmm_idx;
+	u8 scan_seq_num;
+
+	struct mt7921_sta sta;
+	struct mt7921_phy *phy;
+
+	struct ieee80211_tx_queue_params queue_params[IEEE80211_NUM_ACS];
+};
+
+struct mib_stats {
+	u16 ack_fail_cnt;
+	u16 fcs_err_cnt;
+	u16 rts_cnt;
+	u16 rts_retries_cnt;
+	u16 ba_miss_cnt;
+};
+
+struct mt7921_phy {
+	struct mt76_phy *mt76;
+	struct mt7921_dev *dev;
+
+	struct ieee80211_sband_iftype_data iftype[2][NUM_NL80211_IFTYPES];
+
+	struct ieee80211_vif *monitor_vif;
+
+	u32 rxfilter;
+	u64 omac_mask;
+
+	u16 noise;
+
+	s16 coverage_class;
+	u8 slottime;
+
+	__le32 rx_ampdu_ts;
+	u32 ampdu_ref;
+
+	struct mib_stats mib;
+	struct list_head stats_list;
+
+	struct sk_buff_head scan_event_list;
+	struct delayed_work scan_work;
+};
+
+struct mt7921_dev {
+	union { /* must be first */
+		struct mt76_dev mt76;
+		struct mt76_phy mphy;
+	};
+
+	const struct mt76_bus_ops *bus_ops;
+	struct mt7921_phy phy;
+	struct tasklet_struct irq_tasklet;
+
+	u16 chainmask;
+
+	struct work_struct init_work;
+	struct work_struct reset_work;
+	wait_queue_head_t reset_wait;
+	u32 reset_state;
+
+	struct list_head sta_poll_list;
+	spinlock_t sta_poll_lock;
+
+	spinlock_t token_lock;
+	int token_count;
+	struct idr token;
+
+	u8 fw_debug;
+};
+
+enum {
+	HW_BSSID_0 = 0x0,
+	HW_BSSID_1,
+	HW_BSSID_2,
+	HW_BSSID_3,
+	HW_BSSID_MAX = HW_BSSID_3,
+	EXT_BSSID_START = 0x10,
+	EXT_BSSID_1,
+	EXT_BSSID_15 = 0x1f,
+	EXT_BSSID_MAX = EXT_BSSID_15,
+	REPEATER_BSSID_START = 0x20,
+	REPEATER_BSSID_MAX = 0x3f,
+};
+
+enum {
+	MT_LMAC_AC00,
+	MT_LMAC_AC01,
+	MT_LMAC_AC02,
+	MT_LMAC_AC03,
+	MT_LMAC_ALTX0 = 0x10,
+	MT_LMAC_BMC0,
+	MT_LMAC_BCN0,
+};
+
+static inline struct mt7921_phy *
+mt7921_hw_phy(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return phy->priv;
+}
+
+static inline struct mt7921_dev *
+mt7921_hw_dev(struct ieee80211_hw *hw)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	return container_of(phy->dev, struct mt7921_dev, mt76);
+}
+
+static inline u8 mt7921_lmac_mapping(struct mt7921_dev *dev, u8 ac)
+{
+	/* LMAC uses the reverse order of mac80211 AC indexes */
+	return 3 - ac;
+}
+
+extern const struct ieee80211_ops mt7921_ops;
+extern struct pci_driver mt7921_pci_driver;
+
+u32 mt7921_reg_map(struct mt7921_dev *dev, u32 addr);
+
+int mt7921_register_device(struct mt7921_dev *dev);
+void mt7921_unregister_device(struct mt7921_dev *dev);
+int mt7921_eeprom_init(struct mt7921_dev *dev);
+void mt7921_eeprom_parse_band_config(struct mt7921_phy *phy);
+int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
+				   struct ieee80211_channel *chan,
+				   u8 chain_idx);
+void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
+int mt7921_dma_init(struct mt7921_dev *dev);
+void mt7921_dma_prefetch(struct mt7921_dev *dev);
+void mt7921_dma_cleanup(struct mt7921_dev *dev);
+int mt7921_mcu_init(struct mt7921_dev *dev);
+int mt7921_mcu_add_bss_info(struct mt7921_phy *phy,
+			    struct ieee80211_vif *vif, int enable);
+int mt7921_mcu_sta_update_hdr_trans(struct mt7921_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta);
+int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct mt7921_sta *msta, struct ieee80211_key_conf *key,
+		       enum set_key_cmd cmd);
+int mt7921_set_channel(struct mt7921_phy *phy);
+int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd);
+int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif);
+int mt7921_mcu_set_eeprom(struct mt7921_dev *dev);
+int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset);
+int mt7921_mcu_set_mac(struct mt7921_dev *dev, int band, bool enable,
+		       bool hdr_trans);
+int mt7921_mcu_set_rts_thresh(struct mt7921_phy *phy, u32 val);
+int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl);
+void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mcu_exit(struct mt7921_dev *dev);
+
+static inline bool is_mt7921(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7961;
+}
+
+static inline void mt7921_irq_enable(struct mt7921_dev *dev, u32 mask)
+{
+	mt76_set_irq_mask(&dev->mt76, 0, 0, mask);
+
+	tasklet_schedule(&dev->irq_tasklet);
+}
+
+static inline u32
+mt7921_reg_map_l1(struct mt7921_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	/* use read to push write */
+	mt76_rr(dev, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static inline u32
+mt7921_l1_rr(struct mt7921_dev *dev, u32 addr)
+{
+	return mt76_rr(dev, mt7921_reg_map_l1(dev, addr));
+}
+
+static inline void
+mt7921_l1_wr(struct mt7921_dev *dev, u32 addr, u32 val)
+{
+	mt76_wr(dev, mt7921_reg_map_l1(dev, addr), val);
+}
+
+static inline u32
+mt7921_l1_rmw(struct mt7921_dev *dev, u32 addr, u32 mask, u32 val)
+{
+	val |= mt7921_l1_rr(dev, addr) & ~mask;
+	mt7921_l1_wr(dev, addr, val);
+
+	return val;
+}
+
+#define mt7921_l1_set(dev, addr, val)	mt7921_l1_rmw(dev, addr, 0, val)
+#define mt7921_l1_clear(dev, addr, val)	mt7921_l1_rmw(dev, addr, val, 0)
+
+bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
+void mt7921_mac_reset_counters(struct mt7921_phy *phy);
+void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, bool beacon);
+void mt7921_mac_set_timing(struct mt7921_phy *phy);
+int mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mac_fill_rx_vector(struct mt7921_dev *dev, struct sk_buff *skb);
+void mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb);
+int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7921_mac_work(struct work_struct *work);
+void mt7921_mac_reset_work(struct work_struct *work);
+int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info);
+void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc);
+void mt7921_tx_token_put(struct mt7921_dev *dev);
+void mt7921_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb);
+void mt7921_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
+void mt7921_stats_work(struct work_struct *work);
+void mt7921_txp_skb_unmap(struct mt76_dev *dev,
+			  struct mt76_txwi_cache *txwi);
+void mt7921_set_stream_he_caps(struct mt7921_phy *phy);
+void mt7921_update_channel(struct mt76_dev *mdev);
+int mt7921_init_debugfs(struct mt7921_dev *dev);
+int
+mt7921_mcu_uni_add_dev(struct mt7921_dev *dev,
+		       struct ieee80211_vif *vif, bool enable);
+int
+mt7921_mcu_uni_add_bss(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       bool enable);
+
+int
+mt7921_mcu_uni_add_sta(struct mt7921_dev *dev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta, bool enable);
+int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+void mt7921_scan_work(struct work_struct *work);
+int mt7921_mcu_set_channel_domain(struct mt7921_phy *phy);
+int mt7921_mcu_hw_scan(struct mt7921_phy *phy, struct ieee80211_vif *vif,
+		       struct ieee80211_scan_request *scan_req);
+int mt7921_mcu_cancel_hw_scan(struct mt7921_phy *phy,
+			      struct ieee80211_vif *vif);
+u32 mt7921_get_wtbl_info(struct mt7921_dev *dev, u16 wlan_idx);
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
new file mode 100644
index 000000000000..08e248c586bd
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -0,0 +1,413 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_REGS_H
+#define __MT7921_REGS_H
+
+/* MCU WFDMA1 */
+#define MT_MCU_WFDMA1_BASE		0x3000
+#define MT_MCU_WFDMA1(ofs)		(MT_MCU_WFDMA1_BASE + (ofs))
+
+#define MT_MCU_INT_EVENT		MT_MCU_WFDMA1(0x108)
+#define MT_MCU_INT_EVENT_DMA_STOPPED	BIT(0)
+#define MT_MCU_INT_EVENT_DMA_INIT	BIT(1)
+#define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
+#define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
+
+#define MT_PLE_BASE			0x8000
+#define MT_PLE(ofs)			(MT_PLE_BASE + (ofs))
+
+#define MT_PLE_FL_Q0_CTRL		MT_PLE(0x1b0)
+#define MT_PLE_FL_Q1_CTRL		MT_PLE(0x1b4)
+#define MT_PLE_FL_Q2_CTRL		MT_PLE(0x1b8)
+#define MT_PLE_FL_Q3_CTRL		MT_PLE(0x1bc)
+
+#define MT_PLE_AC_QEMPTY(ac, n)		MT_PLE(0x300 + 0x10 * (ac) + \
+					       ((n) << 2))
+#define MT_PLE_AMSDU_PACK_MSDU_CNT(n)	MT_PLE(0x10e0 + ((n) << 2))
+
+#define MT_MDP_BASE			0xf000
+#define MT_MDP(ofs)			(MT_MDP_BASE + (ofs))
+
+#define MT_MDP_DCR0			MT_MDP(0x000)
+#define MT_MDP_DCR0_DAMSDU_EN		BIT(15)
+
+#define MT_MDP_DCR1			MT_MDP(0x004)
+#define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
+
+#define MT_MDP_BNRCFR0(_band)		MT_MDP(0x070 + ((_band) << 8))
+#define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
+#define MT_MDP_RCFR0_MCU_RX_CTL_NON_BAR	GENMASK(7, 6)
+#define MT_MDP_RCFR0_MCU_RX_CTL_BAR	GENMASK(9, 8)
+
+#define MT_MDP_BNRCFR1(_band)		MT_MDP(0x074 + ((_band) << 8))
+#define MT_MDP_RCFR1_MCU_RX_BYPASS	GENMASK(23, 22)
+#define MT_MDP_RCFR1_RX_DROPPED_UCAST	GENMASK(28, 27)
+#define MT_MDP_RCFR1_RX_DROPPED_MCAST	GENMASK(30, 29)
+#define MT_MDP_TO_HIF			0
+#define MT_MDP_TO_WM			1
+
+/* TMAC: band 0(0x21000), band 1(0xa1000) */
+#define MT_WF_TMAC_BASE(_band)		((_band) ? 0xa1000 : 0x21000)
+#define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
+
+#define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
+#define MT_TMAC_TCR0_TBTT_STOP_CTRL	BIT(25)
+
+#define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, 0x090)
+#define MT_TMAC_ODTR(_band)		MT_WF_TMAC(_band, 0x094)
+#define MT_TIMEOUT_VAL_PLCP		GENMASK(15, 0)
+#define MT_TIMEOUT_VAL_CCA		GENMASK(31, 16)
+
+#define MT_TMAC_ICR0(_band)		MT_WF_TMAC(_band, 0x0a4)
+#define MT_IFS_EIFS			GENMASK(8, 0)
+#define MT_IFS_RIFS			GENMASK(14, 10)
+#define MT_IFS_SIFS			GENMASK(22, 16)
+#define MT_IFS_SLOT			GENMASK(30, 24)
+
+#define MT_TMAC_CTCR0(_band)			MT_WF_TMAC(_band, 0x0f4)
+#define MT_TMAC_CTCR0_INS_DDLMT_REFTIME		GENMASK(5, 0)
+#define MT_TMAC_CTCR0_INS_DDLMT_EN		BIT(17)
+#define MT_TMAC_CTCR0_INS_DDLMT_VHT_SMPDU_EN	BIT(18)
+
+#define MT_TMAC_TRCR0(_band)		MT_WF_TMAC(_band, 0x09c)
+#define MT_TMAC_TFCR0(_band)		MT_WF_TMAC(_band, 0x1e0)
+
+#define MT_WF_DMA_BASE(_band)		((_band) ? 0xa1e00 : 0x21e00)
+#define MT_WF_DMA(_band, ofs)		(MT_WF_DMA_BASE(_band) + (ofs))
+
+#define MT_DMA_DCR0(_band)		MT_WF_DMA(_band, 0x000)
+#define MT_DMA_DCR0_MAX_RX_LEN		GENMASK(15, 3)
+#define MT_DMA_DCR0_RXD_G5_EN		BIT(23)
+
+/* LPON: band 0(0x24200), band 1(0xa4200) */
+#define MT_WF_LPON_BASE(_band)		((_band) ? 0xa4200 : 0x24200)
+#define MT_WF_LPON(_band, ofs)		(MT_WF_LPON_BASE(_band) + (ofs))
+
+#define MT_LPON_UTTR0(_band)		MT_WF_LPON(_band, 0x080)
+#define MT_LPON_UTTR1(_band)		MT_WF_LPON(_band, 0x084)
+
+#define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
+#define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
+#define MT_LPON_TCR_SW_WRITE		BIT(0)
+
+/* MIB: band 0(0x24800), band 1(0xa4800) */
+#define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
+#define MT_WF_MIB(_band, ofs)		(MT_WF_MIB_BASE(_band) + (ofs))
+
+#define MT_MIB_SDR3(_band)		MT_WF_MIB(_band, 0x014)
+#define MT_MIB_SDR3_FCS_ERR_MASK	GENMASK(15, 0)
+
+#define MT_MIB_SDR9(_band)		MT_WF_MIB(_band, 0x02c)
+#define MT_MIB_SDR9_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR16(_band)		MT_WF_MIB(_band, 0x048)
+#define MT_MIB_SDR16_BUSY_MASK		GENMASK(23, 0)
+
+#define MT_MIB_SDR34(_band)		MT_WF_MIB(_band, 0x090)
+#define MT_MIB_MU_BF_TX_CNT		GENMASK(15, 0)
+
+#define MT_MIB_SDR36(_band)		MT_WF_MIB(_band, 0x098)
+#define MT_MIB_SDR36_TXTIME_MASK	GENMASK(23, 0)
+#define MT_MIB_SDR37(_band)		MT_WF_MIB(_band, 0x09c)
+#define MT_MIB_SDR37_RXTIME_MASK	GENMASK(23, 0)
+
+#define MT_MIB_DR8(_band)		MT_WF_MIB(_band, 0x0c0)
+#define MT_MIB_DR9(_band)		MT_WF_MIB(_band, 0x0c4)
+#define MT_MIB_DR11(_band)		MT_WF_MIB(_band, 0x0cc)
+
+#define MT_MIB_MB_SDR0(_band, n)	MT_WF_MIB(_band, 0x100 + ((n) << 4))
+#define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
+#define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
+
+#define MT_MIB_MB_SDR1(_band, n)	MT_WF_MIB(_band, 0x104 + ((n) << 4))
+#define MT_MIB_BA_MISS_COUNT_MASK	GENMASK(15, 0)
+#define MT_MIB_ACK_FAIL_COUNT_MASK	GENMASK(31, 16)
+
+#define MT_MIB_MB_SDR2(_band, n)	MT_WF_MIB(_band, 0x108 + ((n) << 4))
+#define MT_MIB_FRAME_RETRIES_COUNT_MASK	GENMASK(15, 0)
+
+#define MT_TX_AGG_CNT(_band, n)		MT_WF_MIB(_band, 0x0a8 + ((n) << 2))
+#define MT_TX_AGG_CNT2(_band, n)	MT_WF_MIB(_band, 0x164 + ((n) << 2))
+#define MT_MIB_ARNG(_band, n)		MT_WF_MIB(_band, 0x4b8 + ((n) << 2))
+#define MT_MIB_ARNCR_RANGE(val, n)	(((val) >> ((n) << 3)) & GENMASK(7, 0))
+
+#define MT_WTBLON_TOP_BASE		0x34000
+#define MT_WTBLON_TOP(ofs)		(MT_WTBLON_TOP_BASE + (ofs))
+#define MT_WTBLON_TOP_WDUCR		MT_WTBLON_TOP(0x0)
+#define MT_WTBLON_TOP_WDUCR_GROUP	GENMASK(2, 0)
+
+#define MT_WTBL_UPDATE			MT_WTBLON_TOP(0x030)
+#define MT_WTBL_UPDATE_WLAN_IDX		GENMASK(9, 0)
+#define MT_WTBL_UPDATE_ADM_COUNT_CLEAR	BIT(12)
+#define MT_WTBL_UPDATE_BUSY		BIT(31)
+
+#define MT_WTBL_BASE			0x38000
+#define MT_WTBL_LMAC_ID			GENMASK(14, 8)
+#define MT_WTBL_LMAC_DW			GENMASK(7, 2)
+#define MT_WTBL_LMAC_OFFS(_id, _dw)	(MT_WTBL_BASE | \
+					FIELD_PREP(MT_WTBL_LMAC_ID, _id) | \
+					FIELD_PREP(MT_WTBL_LMAC_DW, _dw))
+
+/* AGG: band 0(0x20800), band 1(0xa0800) */
+#define MT_WF_AGG_BASE(_band)		((_band) ? 0xa0800 : 0x20800)
+#define MT_WF_AGG(_band, ofs)		(MT_WF_AGG_BASE(_band) + (ofs))
+
+#define MT_AGG_AWSCR0(_band, _n)	MT_WF_AGG(_band, 0x05c + (_n) * 4)
+#define MT_AGG_PCR0(_band, _n)		MT_WF_AGG(_band, 0x06c + (_n) * 4)
+#define MT_AGG_PCR0_MM_PROT		BIT(0)
+#define MT_AGG_PCR0_GF_PROT		BIT(1)
+#define MT_AGG_PCR0_BW20_PROT		BIT(2)
+#define MT_AGG_PCR0_BW40_PROT		BIT(4)
+#define MT_AGG_PCR0_BW80_PROT		BIT(6)
+#define MT_AGG_PCR0_ERP_PROT		GENMASK(12, 8)
+#define MT_AGG_PCR0_VHT_PROT		BIT(13)
+#define MT_AGG_PCR0_PTA_WIN_DIS		BIT(15)
+
+#define MT_AGG_PCR1_RTS0_NUM_THRES	GENMASK(31, 23)
+#define MT_AGG_PCR1_RTS0_LEN_THRES	GENMASK(19, 0)
+
+#define MT_AGG_ACR0(_band)		MT_WF_AGG(_band, 0x084)
+#define MT_AGG_ACR_CFEND_RATE		GENMASK(13, 0)
+#define MT_AGG_ACR_BAR_RATE		GENMASK(29, 16)
+
+#define MT_AGG_MRCR(_band)		MT_WF_AGG(_band, 0x098)
+#define MT_AGG_MRCR_BAR_CNT_LIMIT	GENMASK(15, 12)
+#define MT_AGG_MRCR_LAST_RTS_CTS_RN	BIT(6)
+#define MT_AGG_MRCR_RTS_FAIL_LIMIT	GENMASK(11, 7)
+#define MT_AGG_MRCR_TXCMD_RTS_FAIL_LIMIT	GENMASK(28, 24)
+
+#define MT_AGG_ATCR1(_band)		MT_WF_AGG(_band, 0x0f0)
+#define MT_AGG_ATCR3(_band)		MT_WF_AGG(_band, 0x0f4)
+
+/* ARB: band 0(0x20c00), band 1(0xa0c00) */
+#define MT_WF_ARB_BASE(_band)		((_band) ? 0xa0c00 : 0x20c00)
+#define MT_WF_ARB(_band, ofs)		(MT_WF_ARB_BASE(_band) + (ofs))
+
+#define MT_ARB_SCR(_band)		MT_WF_ARB(_band, 0x080)
+#define MT_ARB_SCR_TX_DISABLE		BIT(8)
+#define MT_ARB_SCR_RX_DISABLE		BIT(9)
+
+#define MT_ARB_DRNGR0(_band, _n)	MT_WF_ARB(_band, 0x194 + (_n) * 4)
+
+/* RMAC: band 0(0x21400), band 1(0xa1400) */
+#define MT_WF_RMAC_BASE(_band)		((_band) ? 0xa1400 : 0x21400)
+#define MT_WF_RMAC(_band, ofs)		(MT_WF_RMAC_BASE(_band) + (ofs))
+
+#define MT_WF_RFCR(_band)		MT_WF_RMAC(_band, 0x000)
+#define MT_WF_RFCR_DROP_STBC_MULTI	BIT(0)
+#define MT_WF_RFCR_DROP_FCSFAIL		BIT(1)
+#define MT_WF_RFCR_DROP_VERSION		BIT(3)
+#define MT_WF_RFCR_DROP_PROBEREQ	BIT(4)
+#define MT_WF_RFCR_DROP_MCAST		BIT(5)
+#define MT_WF_RFCR_DROP_BCAST		BIT(6)
+#define MT_WF_RFCR_DROP_MCAST_FILTERED	BIT(7)
+#define MT_WF_RFCR_DROP_A3_MAC		BIT(8)
+#define MT_WF_RFCR_DROP_A3_BSSID	BIT(9)
+#define MT_WF_RFCR_DROP_A2_BSSID	BIT(10)
+#define MT_WF_RFCR_DROP_OTHER_BEACON	BIT(11)
+#define MT_WF_RFCR_DROP_FRAME_REPORT	BIT(12)
+#define MT_WF_RFCR_DROP_CTL_RSV		BIT(13)
+#define MT_WF_RFCR_DROP_CTS		BIT(14)
+#define MT_WF_RFCR_DROP_RTS		BIT(15)
+#define MT_WF_RFCR_DROP_DUPLICATE	BIT(16)
+#define MT_WF_RFCR_DROP_OTHER_BSS	BIT(17)
+#define MT_WF_RFCR_DROP_OTHER_UC	BIT(18)
+#define MT_WF_RFCR_DROP_OTHER_TIM	BIT(19)
+#define MT_WF_RFCR_DROP_NDPA		BIT(20)
+#define MT_WF_RFCR_DROP_UNWANTED_CTL	BIT(21)
+
+#define MT_WF_RFCR1(_band)		MT_WF_RMAC(_band, 0x004)
+#define MT_WF_RFCR1_DROP_ACK		BIT(4)
+#define MT_WF_RFCR1_DROP_BF_POLL	BIT(5)
+#define MT_WF_RFCR1_DROP_BA		BIT(6)
+#define MT_WF_RFCR1_DROP_CFEND		BIT(7)
+#define MT_WF_RFCR1_DROP_CFACK		BIT(8)
+
+#define MT_WF_RMAC_MIB_TIME0(_band)	MT_WF_RMAC(_band, 0x03c4)
+#define MT_WF_RMAC_MIB_RXTIME_CLR	BIT(31)
+#define MT_WF_RMAC_MIB_RXTIME_EN	BIT(30)
+
+#define MT_WF_RMAC_MIB_AIRTIME14(_band)	MT_WF_RMAC(_band, 0x03b8)
+#define MT_MIB_OBSSTIME_MASK		GENMASK(23, 0)
+#define MT_WF_RMAC_MIB_AIRTIME0(_band)	MT_WF_RMAC(_band, 0x0380)
+
+/* WFDMA0 */
+#define MT_WFDMA0_BASE			0xd4000
+#define MT_WFDMA0(ofs)			(MT_WFDMA0_BASE + (ofs))
+
+#define MT_WFDMA0_RST			MT_WFDMA0(0x100)
+#define MT_WFDMA0_RST_LOGIC_RST		BIT(4)
+#define MT_WFDMA0_RST_DMASHDL_ALL_RST	BIT(5)
+
+#define MT_WFDMA0_BUSY_ENA		MT_WFDMA0(0x13c)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO0	BIT(0)
+#define MT_WFDMA0_BUSY_ENA_TX_FIFO1	BIT(1)
+#define MT_WFDMA0_BUSY_ENA_RX_FIFO	BIT(2)
+
+#define MT_MCU_CMD                     MT_WFDMA0(0x1f0)
+#define MT_MCU_CMD_STOP_DMA_FW_RELOAD  BIT(1)
+#define MT_MCU_CMD_STOP_DMA            BIT(2)
+#define MT_MCU_CMD_RESET_DONE          BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE       BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE	       BIT(5)
+#define MT_MCU_CMD_ERROR_MASK          GENMASK(5, 1)
+
+#define MT_WFDMA0_HOST_INT_STA		MT_WFDMA0(0x200)
+#define HOST_RX_DONE_INT_STS0		BIT(0)	/* Rx mcu */
+#define HOST_RX_DONE_INT_STS2		BIT(2)	/* Rx data */
+#define HOST_RX_DONE_INT_STS4		BIT(22)	/* Rx mcu after fw downloaded */
+#define HOST_TX_DONE_INT_STS16		BIT(26)
+#define HOST_TX_DONE_INT_STS17		BIT(27) /* MCU tx done*/
+
+#define MT_WFDMA0_HOST_INT_ENA		MT_WFDMA0(0x204)
+#define HOST_RX_DONE_INT_ENA0		BIT(0)
+#define HOST_RX_DONE_INT_ENA1		BIT(1)
+#define HOST_RX_DONE_INT_ENA2		BIT(2)
+#define HOST_RX_DONE_INT_ENA3		BIT(3)
+#define HOST_TX_DONE_INT_ENA0		BIT(4)
+#define HOST_TX_DONE_INT_ENA1		BIT(5)
+#define HOST_TX_DONE_INT_ENA2		BIT(6)
+#define HOST_TX_DONE_INT_ENA3		BIT(7)
+#define HOST_TX_DONE_INT_ENA4		BIT(8)
+#define HOST_TX_DONE_INT_ENA5		BIT(9)
+#define HOST_TX_DONE_INT_ENA6		BIT(10)
+#define HOST_TX_DONE_INT_ENA7		BIT(11)
+#define HOST_TX_DONE_INT_ENA8		BIT(12)
+#define HOST_TX_DONE_INT_ENA9		BIT(13)
+#define HOST_TX_DONE_INT_ENA10		BIT(14)
+#define HOST_TX_DONE_INT_ENA11		BIT(15)
+#define HOST_TX_DONE_INT_ENA12		BIT(16)
+#define HOST_TX_DONE_INT_ENA13		BIT(17)
+#define HOST_TX_DONE_INT_ENA14		BIT(18)
+#define HOST_RX_COHERENT_EN		BIT(20)
+#define HOST_TX_COHERENT_EN		BIT(21)
+#define HOST_RX_DONE_INT_ENA4		BIT(22)
+#define HOST_RX_DONE_INT_ENA5		BIT(23)
+#define HOST_TX_DONE_INT_ENA16		BIT(26)
+#define HOST_TX_DONE_INT_ENA17		BIT(27)
+#define MCU2HOST_SW_INT_ENA		BIT(29)
+#define HOST_TX_DONE_INT_ENA18		BIT(30)
+
+/* WFDMA interrupt */
+#define MT_INT_RX_DONE_DATA		HOST_RX_DONE_INT_ENA2
+#define MT_INT_RX_DONE_WM		HOST_RX_DONE_INT_ENA0
+#define MT_INT_RX_DONE_WM2		HOST_RX_DONE_INT_ENA4
+#define MT_INT_RX_DONE_ALL		(MT_INT_RX_DONE_DATA | \
+					 MT_INT_RX_DONE_WM | \
+					 MT_INT_RX_DONE_WM2)
+#define MT_INT_TX_DONE_MCU_WM		HOST_TX_DONE_INT_ENA17
+#define MT_INT_TX_DONE_FWDL		HOST_TX_DONE_INT_ENA16
+#define MT_INT_TX_DONE_BAND0		HOST_TX_DONE_INT_ENA0
+#define MT_INT_MCU_CMD			MCU2HOST_SW_INT_ENA
+
+#define MT_INT_TX_DONE_MCU		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_FWDL)
+#define MT_INT_TX_DONE_ALL		(MT_INT_TX_DONE_MCU_WM |	\
+					 MT_INT_TX_DONE_BAND0 |	\
+					GENMASK(18, 4))
+
+#define MT_WFDMA0_GLO_CFG		MT_WFDMA0(0x208)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_EN	BIT(0)
+#define MT_WFDMA0_GLO_CFG_TX_DMA_BUSY	BIT(1)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
+#define MT_WFDMA0_GLO_CFG_RX_DMA_BUSY	BIT(3)
+#define MT_WFDMA0_GLO_CFG_TX_WB_DDONE	BIT(6)
+#define MT_WFDMA0_GLO_CFG_FIFO_LITTLE_ENDIAN	BIT(12)
+#define MT_WFDMA0_GLO_CFG_CSR_DISP_BASE_PTR_CHAIN_EN BIT(15)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO_PFET2	BIT(21)
+#define MT_WFDMA0_GLO_CFG_OMIT_RX_INFO	BIT(27)
+#define MT_WFDMA0_GLO_CFG_OMIT_TX_INFO	BIT(28)
+#define MT_WFDMA0_GLO_CFG_CLK_GAT_DIS	BIT(30)
+
+#define MT_WFDMA0_RST_DTX_PTR		MT_WFDMA0(0x20c)
+#define MT_WFDMA0_GLO_CFG_EXT0		MT_WFDMA0(0x2b0)
+#define MT_WFDMA0_CSR_TX_DMASHDL_ENABLE	BIT(6)
+#define MT_WFDMA0_PRI_DLY_INT_CFG0	MT_WFDMA0(0x2f0)
+
+#define MT_RX_DATA_RING_BASE		MT_WFDMA0(0x520)
+
+#define MT_WFDMA0_TX_RING0_EXT_CTRL	MT_WFDMA0(0x600)
+#define MT_WFDMA0_TX_RING1_EXT_CTRL	MT_WFDMA0(0x604)
+#define MT_WFDMA0_TX_RING2_EXT_CTRL	MT_WFDMA0(0x608)
+#define MT_WFDMA0_TX_RING3_EXT_CTRL	MT_WFDMA0(0x60c)
+#define MT_WFDMA0_TX_RING4_EXT_CTRL	MT_WFDMA0(0x610)
+#define MT_WFDMA0_TX_RING5_EXT_CTRL	MT_WFDMA0(0x614)
+#define MT_WFDMA0_TX_RING6_EXT_CTRL	MT_WFDMA0(0x618)
+#define MT_WFDMA0_TX_RING16_EXT_CTRL	MT_WFDMA0(0x640)
+#define MT_WFDMA0_TX_RING17_EXT_CTRL	MT_WFDMA0(0x644)
+
+#define MT_WFDMA0_RX_RING0_EXT_CTRL	MT_WFDMA0(0x680)
+#define MT_WFDMA0_RX_RING1_EXT_CTRL	MT_WFDMA0(0x684)
+#define MT_WFDMA0_RX_RING2_EXT_CTRL	MT_WFDMA0(0x688)
+#define MT_WFDMA0_RX_RING3_EXT_CTRL	MT_WFDMA0(0x68c)
+#define MT_WFDMA0_RX_RING4_EXT_CTRL	MT_WFDMA0(0x690)
+#define MT_WFDMA0_RX_RING5_EXT_CTRL	MT_WFDMA0(0x694)
+
+#define MT_TX_RING_BASE			MT_WFDMA0(0x300)
+#define MT_RX_EVENT_RING_BASE		MT_WFDMA0(0x500)
+
+/* WFDMA CSR */
+#define MT_WFDMA_EXT_CSR_BASE          0xd7000
+#define MT_WFDMA_EXT_CSR(ofs)          (MT_WFDMA_EXT_CSR_BASE + (ofs))
+#define MT_WFDMA_EXT_CSR_HIF_MISC	MT_WFDMA_EXT_CSR(0x44)
+#define MT_WFDMA_EXT_CSR_HIF_MISC_BUSY	BIT(0)
+
+#define MT_INFRA_CFG_BASE		0xfe000
+#define MT_INFRA(ofs)			(MT_INFRA_CFG_BASE + (ofs))
+
+#define MT_HIF_REMAP_L1			MT_INFRA(0x260)
+#define MT_HIF_REMAP_L1_MASK		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_OFFSET		GENMASK(15, 0)
+#define MT_HIF_REMAP_L1_BASE		GENMASK(31, 16)
+#define MT_HIF_REMAP_BASE_L1		0xe0000
+
+#define MT_SWDEF_BASE			0x41f200
+#define MT_SWDEF(ofs)			(MT_SWDEF_BASE + (ofs))
+#define MT_SWDEF_MODE			MT_SWDEF(0x3c)
+#define MT_SWDEF_NORMAL_MODE		0
+#define MT_SWDEF_ICAP_MODE		1
+#define MT_SWDEF_SPECTRUM_MODE		2
+
+#define MT_TOP_BASE			0x18060000
+#define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
+
+#define MT_TOP_LPCR_HOST_BAND0		MT_TOP(0x10)
+#define MT_TOP_LPCR_HOST_FW_OWN		BIT(0)
+#define MT_TOP_LPCR_HOST_DRV_OWN	BIT(1)
+
+#define MT_TOP_MISC			MT_TOP(0xf0)
+#define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
+
+#define MT_HW_BOUND			0x70010020
+#define MT_HW_CHIPID			0x70010200
+#define MT_HW_REV			0x70010204
+
+#define MT_PCIE_MAC_BASE		0x74030000
+#define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
+#define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
+
+#define MT_DMA_SHDL(ofs)		(0xd6000 + (ofs))
+#define MT_DMASHDL_SW_CONTROL		MT_DMA_SHDL(0x004)
+#define MT_DMASHDL_DMASHDL_BYPASS	BIT(28)
+#define MT_DMASHDL_OPTIONAL		MT_DMA_SHDL(0x008)
+#define MT_DMASHDL_PAGE			MT_DMA_SHDL(0x00c)
+#define MT_DMASHDL_REFILL		MT_DMA_SHDL(0x010)
+#define MT_DMASHDL_PKT_MAX_SIZE		MT_DMA_SHDL(0x01c)
+#define MT_DMASHDL_PKT_MAX_SIZE_PLE	GENMASK(11, 0)
+#define MT_DMASHDL_PKT_MAX_SIZE_PSE	GENMASK(27, 16)
+
+#define MT_DMASHDL_GROUP_QUOTA(_n)	MT_DMA_SHDL(0x020 + ((_n) << 2))
+#define MT_DMASHDL_GROUP_QUOTA_MIN	GENMASK(11, 0)
+#define MT_DMASHDL_GROUP_QUOTA_MAX	GENMASK(27, 16)
+
+#define MT_DMASHDL_Q_MAP(_n)		MT_DMA_SHDL(0x060 + ((_n) << 2))
+#define MT_DMASHDL_Q_MAP_MASK		GENMASK(3, 0)
+#define MT_DMASHDL_Q_MAP_SHIFT(_n)	(4 * ((_n) % 8))
+
+#define MT_DMASHDL_SCHED_SET(_n)	MT_DMA_SHDL(0x070 + ((_n) << 2))
+
+#define MT_CONN_ON_MISC			0x7c0600f0
+#define MT_TOP_MISC2_FW_N9_RDY		GENMASK(1, 0)
+
+#endif
-- 
2.25.1

