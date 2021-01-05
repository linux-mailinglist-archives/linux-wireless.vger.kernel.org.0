Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F792EA6CD
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jan 2021 09:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbhAEI5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jan 2021 03:57:12 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43173 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726777AbhAEI5M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jan 2021 03:57:12 -0500
X-UUID: 1e18f1f4d4f144ad87be40de49e6bef7-20210105
X-UUID: 1e18f1f4d4f144ad87be40de49e6bef7-20210105
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 528098802; Tue, 05 Jan 2021 16:56:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 16:56:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 16:56:06 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 5/6] mt76: mt7915: calculate new packet length when tx_time is set in testmode
Date:   Tue, 5 Jan 2021 16:55:28 +0800
Message-ID: <20210105085529.14206-5-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210105085529.14206-1-shayne.chen@mediatek.com>
References: <20210105085529.14206-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If tx_time is set, calculate a new packet length based on tx time and
tx rate.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/testmode.c  | 96 ++++++++++++++++++-
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 748c9b55e498..a8e639ffe6de 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -237,6 +237,96 @@ mt7915_tm_set_ipg_params(struct mt7915_phy *phy, u32 ipg, u8 mode)
 				     aifsn, cw, cw, 0);
 }
 
+static int
+mt7915_tm_set_tx_len(struct mt7915_phy *phy, u32 tx_time)
+{
+	struct mt76_phy *mphy = phy->mt76;
+	struct mt76_testmode_data *td = &mphy->test;
+	struct sk_buff *old = td->tx_skb, *new;
+	struct ieee80211_supported_band *sband;
+	struct rate_info rate = {};
+	u16 flags = 0, tx_len;
+	u32 bitrate;
+
+	if (!tx_time || !old)
+		return 0;
+
+	rate.mcs = td->tx_rate_idx;
+	rate.nss = td->tx_rate_nss;
+
+	switch (td->tx_rate_mode) {
+	case MT76_TM_TX_MODE_CCK:
+	case MT76_TM_TX_MODE_OFDM:
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT76_TM_TX_MODE_HT:
+		rate.mcs += rate.nss * 8;
+		flags |= RATE_INFO_FLAGS_MCS;
+
+		if (td->tx_rate_sgi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT76_TM_TX_MODE_VHT:
+		flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+		if (td->tx_rate_sgi)
+			flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT76_TM_TX_MODE_HE_SU:
+	case MT76_TM_TX_MODE_HE_EXT_SU:
+	case MT76_TM_TX_MODE_HE_TB:
+	case MT76_TM_TX_MODE_HE_MU:
+		rate.he_gi = td->tx_rate_sgi;
+		flags |= RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		break;
+	}
+	rate.flags = flags;
+
+	switch (mphy->chandef.width) {
+	case NL80211_CHAN_WIDTH_160:
+	case NL80211_CHAN_WIDTH_80P80:
+		rate.bw = RATE_INFO_BW_160;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		rate.bw = RATE_INFO_BW_80;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		rate.bw = RATE_INFO_BW_40;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		break;
+	}
+
+	bitrate = cfg80211_calculate_bitrate(&rate);
+	tx_len = bitrate * tx_time / 10 / 8;
+
+	if (tx_len < sizeof(struct ieee80211_hdr))
+		tx_len = sizeof(struct ieee80211_hdr);
+	else if (tx_len > IEEE80211_MAX_FRAME_LEN)
+		tx_len = IEEE80211_MAX_FRAME_LEN;
+
+	new = alloc_skb(tx_len, GFP_KERNEL);
+	if (!new)
+		return -ENOMEM;
+
+	skb_copy_header(new, old);
+	__skb_put_zero(new, tx_len);
+	memcpy(new->data, old->data, sizeof(struct ieee80211_hdr));
+
+	dev_kfree_skb(old);
+	td->tx_skb = new;
+
+	return 0;
+}
+
 static void
 mt7915_tm_reg_backup_restore(struct mt7915_phy *phy)
 {
@@ -312,7 +402,6 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 					 9, 8, 6, 10, 16, 12, 18, 0};
 	struct mt76_testmode_data *td = &phy->mt76->test;
 	struct mt7915_dev *dev = phy->dev;
-	struct sk_buff *skb = td->tx_skb;
 	struct ieee80211_tx_info *info;
 	u8 duty_cycle = td->tx_duty_cycle;
 	u32 tx_time = td->tx_time;
@@ -347,14 +436,15 @@ mt7915_tm_set_tx_frames(struct mt7915_phy *phy, bool en)
 	}
 
 	mt7915_tm_set_ipg_params(phy, ipg, td->tx_rate_mode);
+	mt7915_tm_set_tx_len(phy, tx_time);
 
 	if (ipg)
 		td->tx_queued_limit = MT76_TM_TIMEOUT * 1000000 / ipg / 2;
 
-	if (!en || !skb)
+	if (!en || !td->tx_skb)
 		return;
 
-	info = IEEE80211_SKB_CB(skb);
+	info = IEEE80211_SKB_CB(td->tx_skb);
 	info->control.vif = phy->monitor_vif;
 
 	mt7915_tm_set_trx(phy, TM_MAC_TX, en);
-- 
2.29.2

